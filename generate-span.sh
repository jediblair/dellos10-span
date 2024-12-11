#!/bin/bash
# SPAN Monitoring Configuration for Dell OS10
# see Dell OS10 documentation
# https://www.dell.com/support/manuals/en-nz/smartfabric-os10-emp-partner/smartfabric-os-user-guide-10-5-6/example-configure-local-port-monitoring-with-vlan-as-the-source?guid=guid-b545d52f-0092-4863-8b0d-7a426523f94e&lang=en-us

# Input vlan numbers array from command line
# eg ./generate-span.sh 10 20 30 40 50

# modify your destination interface accordingly

vlans=( "$@" )
destif="ethernet1/1/24"

# Access Lists - One per vlan
for vlan in "${vlans[@]}"; do
        echo "ip access-list MONITOR-$vlan"
        echo " seq 10 permit ip any any capture session 1"
        echo "ipv6 access-list MONITOR-$vlan"
        echo " seq 10 permit ipv6 any any capture session 1"
done

echo

# vlan interface config to enable monitoring
for vlan in "${vlans[@]}"; do
        echo "interface vlan$vlan"
        echo " ip access-group MONITOR-$vlan in"
        echo " ipv6 access-group MONITOR-$vlan in"
done

echo

# monitoring session configuration
echo "monitor session 1"
echo " description \"Monitoring Session\""

# change this to required destination
echo " destination interface $destif"
echo " flow-based enable"

for vlan in "${vlans[@]}"; do
        echo " source interface vlan$vlan rx"
done
# all done
