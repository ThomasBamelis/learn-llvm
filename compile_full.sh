#!/bin/sh

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
mkdir -p $SCRIPT_DIR/build
cd $SCRIPT_DIR/build
cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug                 \
  -DLLVM_EXTERNAL_PROJECTS=tinylang                     \
  -DLLVM_EXTERNAL_TINYLANG_SOURCE_DIR=../tinylang       \
  -DCMAKE_INSTALL_PREFIX="../install"                   \
  -DCMAKE_C_COMPILER=clang                              \
  -DCMAKE_CXX_COMPILER=clang++                          \
  -DLLVM_TARGETS_TO_BUILD="AArch64;X86"                 \
  -DLLVM_ENABLE_PROJECTS="llvm"                         \
  ../llvm-project/llvm

ninja -j20
ninja install
