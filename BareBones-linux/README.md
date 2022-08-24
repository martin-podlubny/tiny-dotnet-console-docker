# My BareBones (bb) linux

## Wat? A bare-minimum base image for dotnet console app.

Custom bare minimum build rootfs built using `buildroot-2022.02.4`.

It has nothing. Well...
  * It has `initd` to run shit
  * `musl` for C lib cuz dotnet runtime...
  * `libstdc++6` for CPP libs cuz dotnet runtime...

The whole rootfs is 2.4MB, of which 1.5MB is `libstdc++6` and 700kB is `musl`.
Cannae think of a way to satisfy dotnet deps for less space than that...
And even then the official list of runtime deps is longer than just `libc` and
`libstdcpp`, so only lerd knows which parts of .NET actually fully work :D

## Build how?

```
🌸 docker build --tag bb:latest .
```

This will spin up ubuntu docker image, get [buildroot](https://buildroot.org/),
and use it to build a custom linux image from sources. Only including what's
configured in [buildroot.config](buildroot.config).

Then you will have `bb:latest` available as a base image for dockerizing your
tiny self-contained dotnet binaries.