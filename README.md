## Synopsis

Docker container for the Bento4 tool box

## Motivation

Bento4 is an awesome toolkit but is not easy to use, so i made it easier.
And now it support http(s) location.

## Installation

```console
$ docker build -t bento4 .
$ docker run --rm -v $PWD:/mnt bento4
Bento4 in Docker 1-5-0-613
Usage: bento4 tool [args ...]
       bento4 ls

Bento4 in Docker is a containerized version of Bento4,
with support of http(s) url.

Available tools:
  aac2mp4
  mp42aac
  mp42hls
  mp42ts
  mp4compact
  mp4dash
  mp4dashclone
  mp4dcfpackager
  mp4decrypt
  mp4dump
  mp4edit
  mp4encrypt
  mp4extract
  mp4fragment
  mp4hls
  mp4info
  mp4mux
  mp4rtphintinfo
  mp4split
  mp4tag

See https://www.bento4.com/documentation/ for details on the command.
Running the tool without any argument will print out a summary of the tool’s command line options and parameters.
```

## Contributors
[GG](https://code.mgo.com/users/ggoussard)

## License

Licensed under the [WTFPL](http://www.wtfpl.net).
