#!/bin/bash

#function to check minidlna status
function check_status {
until [[ $dstatus = Up ]] ; do
pstatus=`docker ps -a| grep minidlna | awk -F"  " '{print $5}'| awk '{print $1}'`
[[ "$pstatus" = "Up" ]] && dstatus=Up && check_minidlna_files && return
[[ "$pstatus" = "Running" ]] && dstatus=Up &&check_minidlna_files 
[[ "$pstatus" = "" ]] && dstatus=Down && start_minidlna_docker 
[[ "$pstatus" = "Restarting" ]] &&  dstatus=Loop  &&rebuild_minidlna_docker && sleep 10
[[ "$pstatus" = "Down" ]] &&  dstatus=Down  && start_minidlna_docker && sleep 10
[[ "$pstatus" = "Exited" ]] &&  dstatus=Down  && start_minidlna_docker && sleep 10
done
}

function check_minidlna_files {
files=`curl -s localhost:8200 | cut -d">" -f 22-24 | sed -e s/\>//g -e s/\<//g -e s/\\\///g | sed -e 's/td/ /g'| awk '{print $3}'`
[[ -t 1 ]] && echo $files files available 
}

function start_minidlna_docker {
start_status=`docker start minidlna  2>&1`
[[ $start_status = minidlna ]] && return
echo $start_status | grep "No such container"  && run_status=`/home/pi/projects/docker/docker-minidlna/start_docker.sh  2>&1` 
echo $run_status | grep "No such image" && /home/pi/projects/docker/docker-minidlna/build_docker_image.sh  ; /home/pi/projects/docker/docker-minidlna/start_docker.sh
}

function rebuild_minidlna_docker {
/home/pi/projects/docker/docker-minidlna/stop_docker.sh
/home/pi/projects/docker/docker-minidlna/start_docker.sh
}

check_status
