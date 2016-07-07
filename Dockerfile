#
# OpenVPN server image.
#
# Start the server with a command like:
# docker run -d -p 1199:1199/udp --privileged --net=host --name vpn-server \
#   -e HOST=$(hostname) -e SERVER_IP=10.0.47.0 -e IP_MASK=255.255.255.128 \
#   -v /etc/ssl/openvpn/:/certs hkjn/openvpn
#
# Running a server on $(hostname) requires that /etc/openvpn exists and contains the
# following:
# * pki/ca.crt: The CA certificate.
# * pki/$(hostname).key: The key for the server.
# * pki/$(hostname).crt: The certificate for the server.
# * pki/dh.pem: Diffie-Hellman parameters.
#
FROM hkjn/alpine

MAINTAINER Henrik Jonsson <me@hkjn.me>

# Install openvpn.
RUN apk add --no-cache bash openvpn

COPY run /usr/local/sbin/
CMD ["run"]

