#!/bin/bash -xv
work=`dirname $0`
cd $work
podman build --force-rm --tag minidlna:latest .

