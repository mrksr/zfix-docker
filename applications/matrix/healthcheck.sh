#!/bin/sh

if (find /data/logs | sort -r | head -n 1 | xargs tail -n 10 | grep -i 'error\|fatal' | grep -q -v 'download\|parse'); then
    pkill mautrix-whatsapp
    exit 1
fi
