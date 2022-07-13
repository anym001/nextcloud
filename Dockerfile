FROM nextcloud:24-apache

RUN apt-get update \
  && apt-get install -y wget gnupg2 unzip nano

# Install ffmpeg for video conversion
RUN apt-get install -y ffmpeg

# Install libmagickcore for svg compatibility
RUN apt-get install -y libmagickcore-6.q16-6-extra

# Install bzip2 needed to extract models
RUN apt-get install -y libbz2-dev
RUN docker-php-ext-install bz2

# Enable repo and install dlib
RUN echo "deb https://repo.delellis.com.ar bullseye bullseye" > /etc/apt/sources.list.d/20-pdlib.list \
  && wget -qO - https://repo.delellis.com.ar/repo.gpg.key | apt-key add -
RUN apt-get update \
  && apt-get install -y libdlib-dev

# Install pdlib extension
RUN wget https://github.com/goodspb/pdlib/archive/master.zip \
  && mkdir -p /usr/src/php/ext/ \
  && unzip -d /usr/src/php/ext/ master.zip \
  && rm master.zip
RUN docker-php-ext-install pdlib-master

# Increase memory limit
ENV MEMORY_LIMIT="4096M"
RUN echo memory_limit=${MEMORY_LIMIT} > /usr/local/etc/php/conf.d/z-memory-limit.ini

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]
