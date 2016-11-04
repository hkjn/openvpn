openvpn
=======

Repo openvpn holds an OpenVPN image.

Start the server with a command like:

```
docker run -d -p 1199:1199/udp --privileged --net=host --name vpn-server \
   -e HOST=$(hostname) -e SERVER_IP=10.0.47.0 -e IP_MASK=255.255.255.128 \
   -v /etc/openvpn/:/certs hkjn/openvpn
```

Running a server on $(hostname) requires that /etc/openvpn exists and contains the
following files:
* `ca.pem`: The CA certificate.
* `$(hostname)-key.pem`: The key for the server.
* `$(hostname).pem`: The certificate for the server.
* `dh.pem`: Diffie-Hellman parameters.

## Generating certs

The certificates can be generated using `hkjn/pki`:

```
$ docker run -v /etc/openvpn:/certs hkjn/pki initca
$ docker run -v /etc/openvpn:/certs hkjn/pki gencert $(hostname)

```

## Generating DH params

The Diffie-Hellman parameters can be generated with:

```
openssl dhparam -outform PEM -out dhparam.pem 4096
```
