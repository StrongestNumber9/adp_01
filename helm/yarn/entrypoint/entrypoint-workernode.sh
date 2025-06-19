#!/bin/bash
bash /entrypoint-common.sh nodemanager HTTP;
systemctl start nodemanager;
journalctl -fu nodemanager;
