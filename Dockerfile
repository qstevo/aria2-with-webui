FROM alpine:3.10

ARG ariaNg_url=https://github.com/mayswind/AriaNg/releases/download/1.1.4/AriaNg-1.1.4-AllInOne.zip
RUN apk update && \
	apk add --no-cache --update bash aria2 darkhttpd && \
	mkdir -p /conf && \
	mkdir -p /conf-copy && \
	mkdir -p /data && \
        mkdir -p /web && \
        wget $ariaNg_url && \
        unzip AriaNg*.zip -d /web && \
        rm AriaNg*.zip

COPY files /conf-copy

RUN chmod +x /conf-copy/start.sh

WORKDIR /
VOLUME ["/data"]
VOLUME ["/conf"]
EXPOSE 6800
EXPOSE 8080
EXPOSE 8081

ENTRYPOINT ["sh", "-c", "/conf-copy/start.sh"]
