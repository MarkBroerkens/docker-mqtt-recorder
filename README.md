# docker-mqtt-recorder
multi-platform docker container that runs [mqtt-recorder](https://github.com/rpdswtk/mqtt_recorder) by [@rpdswtk](https://github.com/rpdswtk)

## How to run
Run the docker container with the following configuration:
* interactive mode so that you can run the mqtt-recorder command and press ^C so that the recording gets saved
* bind an external volume to the container so that the recording gets persisted
* attach to given network

```sh
name@host> docker run -it --rm broerkens/mqtt-recorder -v $(pwd)/data:/data --network my_network /bin/ash
/data> mqtt-recorder --host localhost --port 1883 --mode record --file /data/record_date.csv --encode_b64    
```

Press ^C in order to stop recording



```sh
/data> mqtt-recorder --host localhost --port 1883 --mode replay --file /data/record_date.csv --encode_b64
```


## Testing
Start mqtt broker and start recording to that broker
```sh
name@term1> docker network create my_network
name@term1> docker run --name broker -d --rm --network my_network eclipse-mosquitto:1.6
name@term1> docker run --name mqtt-recorder -it --rm -v $(pwd)/data:/data --network my_network broerkens/mqtt-recorder /bin/ash
/data> mqtt-recorder --host broker --port 1883 --mode record --file /data/record_date.csv --encode_b64
```

```sh
name@term2> docker run --name client -it --rm --network my_network efrecon/mqtt-client pub -h broker -t test/mqtt-recorder -m "hello world" -d
name@term2> docker run --name client -it --rm --network my_network efrecon/mqtt-client sub -h broker -t # -v
```


```sh
/data> ^C
/data> mqtt-recorder --host broker --port 1883 --mode replay --file /data/record_date.csv --encode_b64
/data> exit
name@term1> docker stop broker
name@term1> docker stop client
name@term1> docker network rm my_network
```

## License
MIT License



