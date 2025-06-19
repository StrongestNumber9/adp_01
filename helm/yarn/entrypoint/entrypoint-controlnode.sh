#!/bin/bash
bash /entrypoint-common.sh jobhistoryserver resourcemanager HTTP;
systemctl start jobhistoryserver;
systemctl start resourcemanager;
journalctl -fu jobhistoryserver -fu resourcemanager;
