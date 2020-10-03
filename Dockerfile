# Please execute the following command to build
# docker build -t [container_name] this_file_path

# Please execute the following command to start it
# docker run -itd --name [container_name] -p xx:xx [container_name]

# Please execute the following command to attach
# docker exec -it [container_name] /bin/bash

FROM ghcr.io/kuroko3417/mc-server-template:latest
LABEL maintainer="kuroko3417 <kuroko3417@gmail.com>"

RUN : "初期設定（最低限必要なツールをインストール）" && \
	yum update -y && \
	yum install -y \
		java

ARG JAR_PATH="/opt/minecraft/"
ARG JAR_FILE_NAME="spigot-1.16.3.jar"
ENV JAR_FILE_PATH=$JAR_PATH$JAR_FILE_NAME

RUN mkdir -p $JAR_PATH

COPY config/eula.txt $JAR_PATH
COPY config/$JAR_FILE_NAME $JAR_PATH

COPY docker-entorypoint.sh /entorypoint.sh
COPY config/minecraft.sh /minecraft.sh

RUN chmod u+x /entorypoint.sh
RUN	chmod u+x /minecraft.sh

WORKDIR $JAR_PATH
ENTRYPOINT [ "/entorypoint.sh" ]
