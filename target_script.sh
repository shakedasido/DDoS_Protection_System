#!/bin/bash

# IPTables paths
IPTABLES="/sbin/iptables"
IP6TABLES="/sbin/ip6tables"

# Logging options
LOG="LOG --log-level debug --log-tcp-sequence --log-tcp-options"
LOG="$LOG --log-ip-options"
RLIMIT="-m limit --limit 3/s --limit-burst 8"
# Kernel configuration for DDoS mitigation
#------------------------------------------------------------------------------
# Enable TCP syncookies to protect against SYN flood attacks
echo 1 > /proc/sys/net/ipv4/tcp_syncookies

# Disable IP forwarding to avoid being used as a relay
echo 0 > /proc/sys/net/ipv4/ip_forward

# Enable IP spoofing protection
for i in /proc/sys/net/ipv4/conf/*/rp_filter; do echo 1 > "$i"; done


# SYN Flood Attack Mitigation
"$IPTABLES" -N SYN_FLOOD
"$IPTABLES" -A INPUT -p tcp --syn -j SYN_FLOOD
"$IPTABLES" -A SYN_FLOOD -m limit --limit 1/s --limit-burst 4 -j RETURN
"$IPTABLES" -A SYN_FLOOD -j LOG --log-prefix "SYN Flood: "
"$IPTABLES" -A SYN_FLOOD -j DROP

# ICMP Flood Attack Mitigation
"$IPTABLES" -A INPUT -p icmp --icmp-type echo-request -m limit --limit 1/s --limit-burst 2 -j ACCEPT
"$IPTABLES" -A INPUT -p icmp --icmp-type echo-request -j LOG --log-prefix "ICMP Flood: "
"$IPTABLES" -A INPUT -p icmp --icmp-type echo-request -j DROP

# Invalid Packet Attack Mitigation
"$IPTABLES" -A INPUT -m state --state INVALID -j LOG --log-prefix "Invalid Packet: "
"$IPTABLES" -A INPUT -m state --state INVALID -j DROP

# Fragmented ICMP Packet Attack Mitigation
"$IPTABLES" -A INPUT -p icmp --fragment -j LOG --log-prefix "Fragmented ICMP: "
"$IPTABLES" -A INPUT -p icmp --fragment -j DROP

# IPv6 ICMP Flood Attack Mitigation
if test -x "$IP6TABLES"; then
    "$IP6TABLES" -A INPUT -p icmpv6 --icmpv6-type echo-request -m limit --limit 1/s --limit-burst 2 -j ACCEPT
    "$IP6TABLES" -A INPUT -p icmpv6 --icmpv6-type echo-request -j LOG --log-prefix "ICMPv6 Flood: "
    "$IP6TABLES" -A INPUT -p icmpv6 --icmpv6-type echo-request -j DROP
     # Drop all invalid IPv6 packets
    "$IP6TABLES" -A INPUT -m state --state INVALID -j LOG --log-prefix "Invalid IPv6 Packet: "
    "$IP6TABLES" -A INPUT -m state --state INVALID -j DROP
fi

# Exit gracefully
exit 0
