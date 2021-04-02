#! /bin/sh
# env PREFIX=/Users/holzschu/src/Xcode_iPad/wasi-sdk/opt make

# Source files for libraries:
mkdir -p Resources/usr/src
mkdir -p Resources/usr/src/libc
mkdir -p Resources/usr/src/libc++
mkdir -p Resources/usr/src/libc++abi
mkdir -p Resources/usr/src/libc-printscan-long-double
mkdir -p Resources/usr/src/libc-printscan-no-floating-point
find src/wasi-libc/build -type f -name \*.o -exec cp {} Resources/usr/src/libc/ \;

mv Resources/usr/src/libc/*long-double* Resources/usr/src/libc-printscan-long-double/
mv Resources/usr/src/libc/*no-floating-point* Resources/usr/src/libc-printscan-no-floating-point/

cp build/libcxx/src/CMakeFiles/cxx_static.dir/*.obj Resources/usr/src/libc++
cp build/libcxxabi/src/CMakeFiles/cxxabi_static.dir/*.o Resources/usr/src/libc++abi

mkdir -p Resources/usr/src/libwasi-emulated-mman
mv Resources/usr/src/libc/mman.o Resources/usr/src/libwasi-emulated-mman/

mkdir -p Resources/usr/src/libwasi-emulated-process-clocks
mv Resources/usr/src/libc/getrusage.o Resources/usr/src/libwasi-emulated-process-clocks
mv Resources/usr/src/libc/clock.o  Resources/usr/src/libwasi-emulated-process-clocks
mv Resources/usr/src/libc/times.o Resources/usr/src/libwasi-emulated-process-clocks

mkdir -p Resources/usr/src/libwasi-emulated-signal
mv Resources/usr/src/libc/signal.o Resources/usr/src/libwasi-emulated-signal
mv Resources/usr/src/libc/psignal.o Resources/usr/src/libwasi-emulated-signal
mv Resources/usr/src/libc/strsignal.o Resources/usr/src/libwasi-emulated-signal

mkdir -p Resources/usr/src/libclang_rt.builtins-wasm32
cp ./build/compiler-rt/CMakeFiles/clang_rt.builtins-wasm32.dir/*.obj Resources/usr/src/libclang_rt.builtins-wasm32/

# include files: 
cp -r ./build/install/Users/holzschu/src/Xcode_iPad/wasi-sdk/opt/lib Resources/usr
cp -r ./build/install/Users/holzschu/src/Xcode_iPad/wasi-sdk/opt/share/wasi-sysroot/lib Resources/usr
cp -r ./build/install/Users/holzschu/src/Xcode_iPad/wasi-sdk/opt/share/wasi-sysroot/include Resources/usr
cp -r ./build/install/Users/holzschu/src/Xcode_iPad/wasi-sdk/opt/share/wasi-sysroot/share Resources/usr
# Remove lib*.a files (but keep *.o):
find Resources/ -name \*.a -delete
# Copy extra files from Resources:
cp -r ../a-Shell/Resources/usr/share/magic.mgc Resources/usr/share/
cp -r ../a-Shell/Resources/usr/share/mk Resources/usr/share/
# Check work:
diff -rbwq Resources/usr ../a-Shell/Resources/usr/ | grep -v differ$
