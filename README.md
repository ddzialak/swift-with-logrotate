### Build docker image with open stack storage (swift)

Mostly inspired on https://github.com/MorrisJobke/docker-swift-onlyone,
main difference is that there is a logrotate enabled and empty files
older than 7 days and directories are removed in daily basis to avoid
out of disk space (counting data size as also number of occupied inodes).
These improvements should cause, that storage is ready for tests
for really, really long time.


```
$ git clone https://github.com/ddzialak/swift-with-logrotate.git

$ docker build swift-with-logrotate --tag swift-with-logrotate:latest

$ mkdir -p /tmp/swift-data

$ docker run --name swift-container --detach --restart always --publish "0.0.0.0:9001:8080" --volume "/tmp/swift-data:/srv" swift-with-logrotate:latest

```

Image ready to go: https://hub.docker.com/repository/docker/ddzialak/swift-with-logrotate

```
docker pull ddzialak/swift-with-logrotate
```

