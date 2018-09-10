#!/bin/sh
#
# Name:    vars.sh
#
# Purpose: Create temporary arteact download server
#
# Author:  Max-Florian Bidlingmaier <maks@konsolan.de>
#
#=============================================================
function finish {
  docker stop oraResDl 2>&1 > /dev/null
}
trap finish EXIT INT TERM

thisPath=`pwd`
resPath=$(echo $thisPath | rev | cut -d'/' -f3- | rev)
docker run --rm -p 32321:80 -v $resPath/oracleResources:/usr/share/nginx/html:ro -d --name oraResDl nginx

#Change this to your docker engine hostname
export RESSRV="docker-lab01:32321"
