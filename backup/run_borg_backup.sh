#!/bin/sh

# some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM


basepath="$(dirname $(realpath $0))"
info "Sourcing env file"
if [ -f "$basepath/run_borg_backup.env" ]; then
    . "$basepath/run_borg_backup.env"
else
    info "Could not find env file. Proceeding anyway."
fi

info "Running scripts in $basepath/backup.d"
run-parts -v -- "$basepath/backup.d"

info "Starting backup"

# Backup the most important directories into an archive named after
# the machine this script is currently running on:

borg create                                   \
    --verbose                                 \
    --filter AME                              \
    --list                                    \
    --stats                                   \
    --show-rc                                 \
    --compression zstd                        \
    --exclude-caches                          \
    --exclude '/home/*/.cache/*'              \
    --exclude '/var/cache/*'                  \
    --exclude '/var/tmp/*'                    \
    --exclude '*/nobackup/*'                  \
    --exclude '/srv/git/gitea/repo-archive/*' \
                                              \
    ::'{hostname}-{now}'                      \
    /srv                                      \
    /var/lib/docker/volumes                   \

backup_exit=$?

info "Pruning repository"

# Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
# archives of THIS machine. The '{hostname}-' prefix is very important to
# limit prune's operation to this machine's archives and not apply to
# other machines' archives also:

borg prune                          \
    --list                          \
    --prefix '{hostname}-'          \
    --show-rc                       \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  6               \

prune_exit=$?

# Use the `compact` subcommand to remove unused chunks and clean up space.
borg compact

compact_exit=$?

# use highest exit code as global exit code
# global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))
global_exit=$(echo -e "$backup_exit\n$prune_exit\n$compact_exit" | sort -rn | head -1)

if [ ${global_exit} -eq 0 ]; then
    info "Backup, Prune and Compact finished successfully"
elif [ ${global_exit} -eq 1 ]; then
    info "Backup and/or Prune and/or Compact finished with warnings"
else
    info "Backup and/or Prune and/or Compact finished with errors"
fi

exit ${global_exit}
