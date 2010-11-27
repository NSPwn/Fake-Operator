#!/bin/sh

make clean
make
make -C ../fakeoperatorprefs clean
make -C ../fakeoperatorprefs
make -C ../fakeoperatorprefs install
rm -rf layout/Library
cp -R ../fakeoperatorprefs/_/* layout
make package
