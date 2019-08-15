docker-desync
=============

Docker image for [desync](https://github.com/folbricht/desync), an alternative implementation of [casync](https://github.com/systemd/casync) written in [Go](https://golang.org/).

## Usage

Split a blob and create an index:

```bash
$ mkdir -p store
$ docker run --rm -it \
    -v $(pwd):/w \
    -v $(pwd)/store:/store \
    panta/desync desync make -s /store /w/ubuntu.iso.caibx /w/ubuntu.iso
```

See the [desync github page](https://github.com/folbricht/desync) for the official examples.

To rebuild from index and store:

```bash
$ rm ubuntu.iso
$ docker run --rm -it \
    -v $(pwd):/w \
    -v $(pwd)/store:/store \
    panta/desync desync extract -s /store /w/ubuntu.iso.caibx /w/ubuntu.iso
```
