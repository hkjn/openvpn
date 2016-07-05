#!/bin/bash
#
# Runs OpenVPN server on 1194/udp.
#
set -euo pipefail

die() {
  echo "[FATAL] $@" >&2
  exit 1
}

[[ "$SERVER_IP" ]] || die "No SERVER_IP specified."
[[ "$IP_MASK" ]] || die "No IP_MASK specified."

# Check if all files exist before creating them, so we're idempotent
# when run repeatedly.
[ -d /dev/net ] || mkdir -p /dev/net
[ -c /dev/net/tun ] || mknod /dev/net/tun c 10 200

cd /etc/openvpn

[ -e pki/ca.crt ] || die "No CA certificate present; checked /etc/openvpn/pki/ca.crt."
[ -e pki/private/$HOST.key ] || die "No server key present; checked /etc/openvpn/pki/private/$HOST.key."
[ -e pki/issued/$HOST.crt ] || die "No server certificate present; checked /etc/openvpn/pki/issued/$HOST.crt."
[ ! -e pki/dh.pem ] || die "No Diffie-Hellman params present; checked pki/dh.pem."

if [ ! -f udp1194.conf ]; then
		echo "Creating udp1194.conf.."
		cat >udp1194.conf <<EOF
server $SERVER_IP $IP_MASK
verb 3
topology p2p

key pki/private/$HOST.key
ca pki/ca.crt
cert pki/issued/$HOST.crt
dh pki/dh.pem
keepalive 10 60
persist-key
persist-tun
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"

# Avoid log spam due to clients on WiFi connections or other unreliable
# connections sending duplicated UDP packets.
mute-replay-warnings

client-to-client

proto udp
port 1194
dev tun1194
status openvpn-status-1194.log
EOF
fi


echo "[INFO] Starting openvpn.."
touch udp1194.log
exec openvpn udp1194.conf
