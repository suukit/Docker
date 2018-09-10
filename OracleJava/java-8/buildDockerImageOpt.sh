#!/bin/sh
#
# Name:    buildDockerImageOpt.sh
#
# Purpose: Builds an Oracle JDK 1.8 Docker Image
#
# Author:  Dirk Nachbar https://dirknachbar.blogspot.com
#          Max-Florian Bidlingmaier <maks@konsolan.de>
#
#=============================================================
. ../../vars.sh

docker build --build-arg RESSRV="$RESSRV" -t oracle/serverjdk:8 -f DockerfileOpt .
