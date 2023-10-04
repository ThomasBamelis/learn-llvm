#!/bin/sh

# This doesn't work right now, linker says no main symbol, but I checked to object file
# and there is a main symbol...
# Just use compile all I guess

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
mkdir -p $SCRIPT_DIR/../build-tinylang
cd $SCRIPT_DIR/../build-tinylang
cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug                 \
  -DLLVM_DIR="../install/lib/cmake/llvm"                \
  -DCMAKE_INSTALL_PREFIX="../install-tinylang"          \
  -DCMAKE_C_COMPILER=clang                              \
  -DCMAKE_CXX_COMPILER=clang++                          \
  ../tinylang/

ninja -j20
ninja install
