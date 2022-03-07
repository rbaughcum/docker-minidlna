#!/bin/bash -xv
work=`dirname $0`
cd $work
build_output=`sudo docker build . 2>&1`
id=`echo $build_output | grep "Successfully built" | awk  '{print $NF}'`
sudo docker tag $id minidlna:latest

