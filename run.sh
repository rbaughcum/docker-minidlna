#!/bin/bash

set -e

> /etc/minidlna.conf

for VAR in `env`; do
if [[ $VAR =~ ^MINIDLNA_ ]] ; then name=`echo "$VAR" | sed -r "s/MINIDLNA?_(.*)=.*/\1/g" | tr '[:upper:]' '[:lower:]'`
    value=`echo "$VAR" | sed -r "s/.*=(.*)/\1/g"`
    echo "${name}=${value}" >> /etc/minidlna.conf
    echo
  elif [[ $VAR =~ ^MINIDLNA._ ]]; then
    name=`echo "$VAR" | sed -r "s/MINIDLNA._(.*)=.*/\1/g" | tr '[:upper:]' '[:lower:]'`
    value=`echo "$VAR" | sed -r "s/.*=(.*)/\1/g"`
    echo "${name}=${value}" >> /etc/minidlna.conf
    echo
  fi

done
if [ -f /var/run/minidlna.pid  ] ; then
rm -rf /var/run/minidlna.pid
kill -9 `ps -ef| grep minidlna | awk '{print $2}'`
fi
if [ ! -d /media/TV/ ] ; then 
   echo There are no media directories 
   exit 1   
else 
  exec /usr/sbin/minidlnad -d $@
fi
