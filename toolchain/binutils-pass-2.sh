#!/bin/bash

if [ "$(whoami)" != "lfs" ]; then
        echo "Script must be run as user: lfs"
        exit 255
fi

cd $LFS/sources
tar xvf binutils-2.38.tar.xz
cd binutils-2.38
sed '6009s/$add_dir//' -i ltmain.sh

mkdir -v build
cd       build

../configure                   \
    --prefix=/usr              \
    --build=$(../config.guess) \
    --host=$LFS_TGT            \
    --disable-nls              \
    --enable-shared            \
    --disable-werror           \
    --enable-64-bit-bfd

make

make DESTDIR=$LFS install


# Footer
cd $LFS/sources
rm -rf binutils-2.38
echo "Done - binutils-2.38.tar.xz"

