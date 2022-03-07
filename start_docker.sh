sudo docker run -d \
    --restart unless-stopped \
    --net=host \
	--pull=never \
    -v /media/pi/mediafiles:/media \
    --name minidlna \
    -e MINIDLNA1_MEDIA_DIR=V,/media/Movies \
    -e MINIDLNA2_MEDIA_DIR=V,/media/TV \
    -e MINIDLNA3_MEDIA_DIR=A,/media/Music \
    -e MINIDLNA4_MEDIA_DIR=V,/media/3D \
    -e MINIDLNA_PORT=8200 \
    -e MINIDLNA_FRIENDLY_NAME="mediacenter_DLNA" \
    minidlna:latest
