#!/bin/bash

docker build . -t pacbrew-test -f Dockerfile.test
docker run pacbrew-test

