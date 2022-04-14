FROM debian:latest

RUN apt-get update && apt-get upgrade -y && apt-get install -y minidlna wget
ADD ./run.sh /run.sh

ENTRYPOINT ["/run.sh"]
