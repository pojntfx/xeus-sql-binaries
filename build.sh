#!/bin/bash

# Install dependencies
apt update
apt install -y make curl git sudo

# Install miniforge
XEUS_PREFIX=/usr/local/xeus-sql
curl -L -o /tmp/miniforge.sh https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-$(uname -m).sh
chmod +x /tmp/miniforge.sh
mkdir -p ${XEUS_PREFIX}
/tmp/miniforge.sh -bfp ${XEUS_PREFIX} -u
rm /tmp/miniforge.sh

# Add miniforge to the path temporarily
export PATH="$PATH:${XEUS_PREFIX}/bin"

# Install dependencies
conda install -c conda-forge -y cmake xeus=1.0.0 cppzmq nlohmann_json xtl=0.7.0 cpp-tabulate soci-core xproperty=0.11.0 xvega-bindings=0.0.10 xvega=0.0.10 compilers soci-mysql soci-sqlite soci-postgresql

# Install xeus-sql
rm -rf /tmp/xeus-sql
cd /tmp
git clone https://github.com/jupyter-xeus/xeus-sql.git
cd xeus-sql
git checkout $(git describe --tags $(git rev-list --tags --max-count=1))
mkdir -p build && cd build
cmake -D CMAKE_INSTALL_PREFIX=${XEUS_PREFIX} -D CMAKE_INSTALL_LIBDIR=${XEUS_PREFIX}/lib ..
make install -j$(nproc)
rm -rf /tmp/xeus-sql

# Remove build dependencies
conda clean -y -f

# Create tar archive
cd ${XEUS_PREFIX}
mkdir -p /out
tar -zcf /out/xeus-sql.$(uname -m).tar.gz *

# Copy to /out
mkdir -p /data/out
mv /out/xeus-sql.$(uname -m).tar.gz /data/out
