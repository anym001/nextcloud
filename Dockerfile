FROM nextcloud:24-apache

RUN apt-get update \
  && apt-get install -y wget gnupg2 unzip
  
ENV DATA_DIR=/nextcloudface
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV DATA_PERM=770
ENV USER="nextcloudface"
ENV MEMORY_LIMIT="4096M"

RUN mkdir $DATA_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048
  
ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]
