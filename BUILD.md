# Build Blockstream Green for Windows, Mac OS and Linux

## Before you build

This BUILD.md file assumes you are building for Windows and Linux on Ubuntu 18.04 and for OSX on latest OSX.

A 'Dockerfile' file is provided to build Linux and Windows binaries.

## Clone the repo

```
git clone https://github.com/Blockstream/green_qt.git
cd green_qt
```

## Debug builds with symbols

Note: change 'linux' to 'windows' to build a full symbols build for Windows

```
docker run -v $PWD:/ga greenaddress/ci@sha256:d0484f3fe4d0acdc83ba17f8799b957502be90996dbd386900db5851f964e92b /bin/sh -c "cd /ga && ./tools/buildgreen.sh linux allsymbolsunstripped && cp /docker_bld_root/build-linux-gcc/Green /ga/Green"
```

## Build static release on macOS

```
./tools/buildgreen.sh osx
```

## Build static release on Linux

```
docker run -v $PWD:/ga greenaddress/ci@sha256:d0484f3fe4d0acdc83ba17f8799b957502be90996dbd386900db5851f964e92b /bin/sh -c "cd /ga && ./tools/buildgreen.sh linux && cp /docker_bld_root/build-linux-gcc/Green /ga/Green"
```

## Build static release on Linux for Windows

```
docker run -v $PWD:/ga greenaddress/ci@sha256:d0484f3fe4d0acdc83ba17f8799b957502be90996dbd386900db5851f964e92b /bin/sh -c "cd /ga && ./tools/buildgreen.sh Windows && cp build-mingw-w64/release/Green.exe /ga/Green.exe"
```

## Development in QtCreator

Building with QtCreator and dynamically linking with Qt and GDK is possible. For
now Qt is not built with -shared so one must be configured in QtCreator (see
Manage Kits dialog).
Just open the project green.pro and configure it with the kit of choice. Then
define the build environments BUILDROOT and GDKBLDID according the build done
from the previous steps. For instance, in macos these would look like:
```
BUILDROOT=build-osx-clang
GDKBLDID=0f8cef9fdf5f08fa8a33736a2e70d8e87b5260f19b46aa2f1a157bb8956b6280
```
