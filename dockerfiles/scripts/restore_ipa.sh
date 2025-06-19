#!/bin/bash
if [ ! -f /data/ipa-client.tar ]; then
    echo "No /data/ipa-client.tar, init was not properly executed?";
    exit 1;
fi;
echo "Init already done, restoring and continuing..";
tar -xf /data/ipa-client.tar -C /;
