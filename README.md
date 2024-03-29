# xeus-sql-binaries

Weekly builds of https://github.com/jupyter-xeus/xeus-sql.

![hydrun CI](https://github.com/pojntfx/xeus-sql-binaries/workflows/hydrun%20CI/badge.svg)

## Installation

Binaries packages (`.tar.gz`, built against the GNU `libc`) are built weekly and uploaded to [GitHub releases](https://github.com/pojntfx/xeus-sql-binaries/releases).

You can install them like so:

```shell
# Fetch the xeus-sql binary package for your architecture (x86_64 is supported; aarch64 is blocked until soci-core becomes available on aarch64)
curl -L -o /tmp/xeus-sql.tar.gz https://github.com/pojntfx/xeus-sql-binaries/releases/download/latest/xeus-sql.$(uname -m).tar.gz

# Extract the package to /usr/local/xeus-sql. You must install in this prefix.
XEUS_PREFIX=/usr/local/xeus-sql
sudo mkdir -p ${XEUS_PREFIX}
sudo tar -C ${XEUS_PREFIX} -xzf /tmp/xeus-sql.tar.gz

# Install the kernel
sudo jupyter kernelspec install ${XEUS_PREFIX}/share/jupyter/kernels/xsql --sys-prefix
```

## License

xeus-sql Binaries (c) 2021 Felicitas Pojtinger and contributors

SPDX-License-Identifier: BSD-3-Clause
