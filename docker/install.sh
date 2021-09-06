#!/bin/bash -xe

apt-get update
apt-get install -y sudo

# wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
# cat >>/etc/apt/sources.list <<EOF
# deb http://apt.llvm.org/buster/ llvm-toolchain-buster-12 main
# deb-src http://apt.llvm.org/buster/ llvm-toolchain-buster-12 main
# EOF
# apt-get update

# sudo apt-get install -y autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev git
# git clone https://github.com/riscv/riscv-gnu-toolchain
# cd riscv-gnu-toolchain

# echo "Starting RISC-V Toolchain build process"

# ARCH=rv32im
# rm -rf $ARCH
# mkdir $ARCH; cd $ARCH
# ../configure  --prefix=/opt/$ARCH --with-arch=$ARCH --with-abi=ilp32
# sudo make -j3
# cd ..


# ARCH=rv32i
# rm -rf $ARCH
# mkdir $ARCH; cd $ARCH
# ../configure  --prefix=/opt/$ARCH --with-arch=$ARCH --with-abi=ilp32
# sudo make -j3
# cd ..

# echo -e "\\nRISC-V Toolchain installation completed!"

#apt-get install -y clang-12 openocd make

#add-apt-repository -y ppa:openjdk-r/ppa
#apt-get install -y openjdk-8-jdk sudo
#update-alternatives --config java
#update-alternatives --config javac

#echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
#echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list
#curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
#apt-get update
#apt-get install -y sbt

# Bootstrap sbt/scala
#mkdir /sbt
#(cd /root && sbt help)

apt-get install -y verilator perl gdb g++ make build-essential xorg-dev libudev-dev libgl1-mesa-dev libglu1-mesa-dev libasound2-dev libpulse-dev libopenal-dev libogg-dev libvorbis-dev libaudiofile-dev libpng-dev libfreetype6-dev libusb-dev libdbus-1-dev zlib1g-dev libdirectfb-dev libsdl2-dev


wget https://github.com/stnolting/riscv-gcc-prebuilt/releases/download/rv32i-2.0.0/riscv32-unknown-elf.gcc-10.2.0.rv32i.ilp32.newlib.tar.gz
tar -C /usr -xvf riscv32-unknown-elf.gcc-10.2.0.rv32i.ilp32.newlib.tar.gz
rm riscv32-unknown-elf.gcc-10.2.0.rv32i.ilp32.newlib.tar.gz
