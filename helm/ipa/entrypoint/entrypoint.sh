#!/bin/bash
bash /entrypoint-common.sh;

if [ ! -d /data/backup ]; then
    echo "No /data/backup, init was not properly executed?";
    exit 1;
fi;


# Asks for password and confirmation.
echo "Init already done, restoring from backup..";
echo -e "{{.Values.ipa.password}}\ny" | ipa-restore /data/backup;
echo "Backup restored, following the logs.";

# Additional check for liveness
touch /ipa.ready;

# This should never return
journalctl -fu ipa;

# Failure state detected
systemctl exit 1;
