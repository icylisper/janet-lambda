#!/bin/bash

export PATH=$PATH:${JANET_PATH}/bin
JANET_INSTALL_DIR=/janet

mkdir -p ${JANET_PATH}/{lib,bin,include}
mkdir -p ${JANET_PATH}/include/janet
mkdir -p ${JANET_INSTALL_DIR}

wget https://github.com/janet-lang/janet/releases/download/${JANET_VERSION}/janet-${JANET_VERSION}-linux.tar.gz
tar zxvf janet-${JANET_VERSION}-linux.tar.gz -C ${JANET_INSTALL_DIR} --strip-components=1
rm -f janet-${JANET_VERSION}-linux.tar.gz

cp -v ${JANET_INSTALL_DIR}/janet ${JANET_PATH}/bin/
cp -v ${JANET_INSTALL_DIR}/jpm ${JANET_PATH}/bin/
cp -v ${JANET_INSTALL_DIR}/*.h ${JANET_PATH}/include/
cp -v ${JANET_INSTALL_DIR}/*.h ${JANET_PATH}/include/janet/
cp -v ${JANET_INSTALL_DIR}/libjanet.* ${JANET_PATH}/lib/

jpm deps && jpm build && jpm install

cp build/bootstrap bootstrap
rm -rf build
echo "Test"
./bootstrap '{"a": 2}'
