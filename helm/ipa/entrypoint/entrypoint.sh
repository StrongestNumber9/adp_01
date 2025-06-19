#!/bin/bash
bash /entrypoint-common.sh;

if [ ! -f /data/data.tar ]; then
    echo "No /data/data.tar, init was not properly executed?";
    exit 1;
fi;
echo "Init already done, restoring and continuing..";
tar -xvf /data/data.tar -C /;
systemctl restart ipa;
journalctl -fu ipa;
exit 0;
