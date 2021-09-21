FROM alpine
RUN apk update && apk add cmd:pip3
RUN pip3 install mqtt-recorder
WORKDIR /data
CMD uname -m
