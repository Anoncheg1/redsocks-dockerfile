## redsocks-dockerfile

```
docker pull ghcr.io/anoncheg1/redsocks:latest
```

"sha256:c89974a429a648681686c2d51b7f5d308409634c9a644497df68eb1435b4783d"

Container size: 148MB

multi-platform: linux/amd64, linux/arm64, linux/arm/v8, linux/arm/v7

## Other Dockerfiles
- https://github.com/ncarlier/dockerfiles/tree/master/redsocks
- https://github.com/Myts2/redsocks-docker

## Description

This docker image allows you to use docker on a host without being bored by your corporate proxy.

You have just to run this container and all your other containers will be able to access directly to internet (without any proxy configuration).

## Usage

Start the container like this:

```
docker run --privileged=true --net=host -d ncarlier/redsocks 1.2.3.4 3128
```

Replace the IP and the port by those of your proxy.

The container will start redsocks and automatically configure iptable to forward **all** the TCP traffic of the `$DOCKER_NET` interface (`docker0` by default) through the proxy.

You can forward all the TCP traffic regardless the interface by unset the `DOCKER_NET` variable: `-e DOCKER_NET`.

If you want to add exception for an IP or a range of IP you can edit the whitelist file.
Once edited you can replace this file into the container by mounting it:

```
docker run --privileged=true --net=host \
  -v whitelist.txt:/etc/redsocks-whitelist.txt \
  -d ncarlier/redsocks 1.2.3.4 3128
```

Use docker stop to halt the container. The iptables rules should be reversed. If not, you can execute this command:

```
iptables-save | grep -v REDSOCKS | iptables-restore
```
## Example of usage
```
docker run --name my-redsocks --privileged \
       --net=host -e DOCKER_NET=127.0.0.1 \
       --cap-drop=ALL --cap-add=NET_ADMIN --cap-add=NET_RAW \
       -d ncarlier/redsocks 1.2.3.4 1080

docker run --network=container:my-redsocks curlimages/curl curl https://ifconfig.me
```
## Build

Build the image with `make`.

> Use `make help` to see available commands for this image.
