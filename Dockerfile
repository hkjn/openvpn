#
# OpenVPN server image.
#
FROM hkjn/alpine

MAINTAINER Henrik Jonsson <me@hkjn.me>

# Install openvpn.
RUN apk add --no-cache bash openvpn

COPY run /usr/local/sbin/
CMD ["run"]

