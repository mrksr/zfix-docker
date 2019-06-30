#!/bin/sh

# if ( \
#     find /data/logs \
#     | sort -t'-' -n -k4 \
#     | sort -r -t'-' -s -k1,3 \
#     | head -n 1 \
#     | xargs tail -n 10 \
#     | grep -i 'error\|fatal' \
#     | grep -q -i -v 'download\|parse\|invalid\|handling' \
#     ); then
#     pkill mautrix-whatsapp
#     exit 1
# fi

pkill mautrix-whatsapp
sleep 5s
exit 1
