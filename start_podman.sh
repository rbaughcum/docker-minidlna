podman run -d \
    --restart unless-stopped \
    --net=host \
	--pull=never \
    -v /media/pi/mediafiles:/media \
    --name minidlna \
    -e MINIDLNA1_MEDIA_DIR=V,/media/Movies \
    -e MINIDLNA2_MEDIA_DIR=V,/media/TV \
    -e MINIDLNA3_MEDIA_DIR=A,/media/Music \
    -e MINIDLNA3_DB_DIR=A,/media/.minidlna.db \
    -e MINIDLNA_PORT=8200 \
    -e MINIDLNA_FRIENDLY_NAME="PI-VIEWER-5000" \
    localhost/minidlna
podman generate systemd --new --name minidlna | sudo tee /etc/systemd/system/minidlna.service 
sudo systemctl enable minidlna
sudo systemctl start minidlna
