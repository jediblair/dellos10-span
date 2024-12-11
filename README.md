# Dell OS10 Spanning / Monitoring configuration helper

This script will assist in generating required configuration for adding a number of vlans to a spanning session on a Dell OS10 based switch

Usage: ./generate-span.sh 10 20 30
```
ip access-list MONITOR-10
 seq 10 permit ip any any capture session 1
ipv6 access-list MONITOR-10
 seq 10 permit ipv6 any any capture session 1
ip access-list MONITOR-20
 seq 10 permit ip any any capture session 1
ipv6 access-list MONITOR-20
 seq 10 permit ipv6 any any capture session 1
ip access-list MONITOR-30
 seq 10 permit ip any any capture session 1
ipv6 access-list MONITOR-30
 seq 10 permit ipv6 any any capture session 1

interface vlan10
 ip access-group MONITOR-10 in
 ipv6 access-group MONITOR-10 in
interface vlan20
 ip access-group MONITOR-20 in
 ipv6 access-group MONITOR-20 in
interface vlan30
 ip access-group MONITOR-30 in
 ipv6 access-group MONITOR-30 in

monitor session 1
 description "Monitoring Session"
 destination interface ethernet1/1/24
 flow-based enable
 source interface vlan10 rx
 source interface vlan20 rx
 source interface vlan30 rx
```
