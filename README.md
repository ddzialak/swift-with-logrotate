# Build docker image to setup open stack storage with swift interface

```
$ git clone https://github.com/ddzialak/swift-with-logrotate.git

$ docker build swift-with-logrotate --tag swift-with-logrotate:latest

$ mkdir /tmp/swift-data

$ docker run --name swift-container --detach --restart always --publish "0.0.0.0:9001:8080" --volume "/tmp/swift-data:/srv" swift-with-logrotate:latest


