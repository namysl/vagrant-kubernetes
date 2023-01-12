#!/bin/bash

worker1=$(vagrant ssh-config worker1 | grep HostName | grep -Po '(\d{1,3}.){4}')
worker2=$(vagrant ssh-config worker2 | grep HostName | grep -Po '(\d{1,3}.){4}')

echo "IPs below should be included in master's /etc/hosts"
echo -e "$worker1 worker1\n$worker2 worker2"