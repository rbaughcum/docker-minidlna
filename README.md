# minidnla in docker

This is minidlna on top of minimal debian distibution.
It can be configured with environment variables.

## Usage
I wanted to make sure my DLNA was running all the time, so I placed a script in the repo called Check_Media_Minidlna.sh
 If you place this in your crontab it will keep your minidlna docker running and make sure it has your media directories up to date. Runs every 5 minutes.

```
0/5 * * * * /home/pi/projects/docker/docker-minidlna/Check_Media_Minidlna.sh
@reboot /home/pi/projects/docker/docker-minidlna/Check_Media_Minidlna.sh
```
start_docker.sh
stop_docker.sh

modify start_docker.sh and Prefix any config directive of 
minidlna with `MINIDLNA_` and run your container:

```
docker run -d \
    --restart unless-stopped \
    --net=host \
    -v /media/pi/mediafiles:/media \
    --name minidlna \
    -e MINIDLNA1_MEDIA_DIR=V,/media/Movies \
    -e MINIDLNA2_MEDIA_DIR=V,/media/TV \
    -e MINIDLNA3_MEDIA_DIR=A,/media/Music \
    -e MINIDLNA4_MEDIA_DIR=V,/media/3D \
    -e MINIDLNA_PORT=8200 \
    -e MINIDLNA_FRIENDLY_NAME="mediacenter_DLNA" \
    minidlna:latest

```
The setup above assumes I have an automounted disk called mediafiles on a Raspberry PI named mediacenter with the root folder of Movies, TV, Music, and 3D.

when modifying your config make sure you change the type of data V=video A=Music P=Pictures
 
See: http://manpages.ubuntu.com/manpages/raring/man5/minidlna.conf.5.html
