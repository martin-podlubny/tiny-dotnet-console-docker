# A small self-contained dotnet console app

## Building

To run the binary, you need to build my custom `bb:latest` (BareBones linux)
docker base image. It builds linux from sources using [buildroot](https://buildroot.org/).

So head to [`BareBones-linux/README.md`](BareBones-linux/README.md) and build that
first. That readme also has info about just how barebones that image is xD Then you
can build this:


```bash
🌸 docker build --tag dotnet-self-contained:latest .
```

## Running

```bash
🌸 docker run --rm dotnet-self-contained:latest

Hello, World!
```

## How big?

```bash
🌸 docker image ls dotnet-self-contained:latest

REPOSITORY              TAG       IMAGE ID       CREATED          SIZE
dotnet-self-contained   latest    e1aeba7a0ab9   14 minutes ago   7.9MB
```

