FROM fedora:32

RUN dnf makecache

RUN dnf install -y pandoc \
	tree \
	rust

RUN dnf install -y cargo \
	openssl openssl-devel openssl-static \
        fontconfig-devel \
	freetype-devel \
	harfbuzz-devel \
	graphite2-devel \
	libpng-devel \
	zlib-devel \
	pkgconf-pkg-config \
        gcc-c++

RUN adduser pandoc && \
	chmod -R 755 ~pandoc

USER pandoc:pandoc
RUN cargo install tectonic

USER root:root
RUN printf '#!/bin/bash\n\nset -eux\n\n/bin/tree .\n/usr/bin/pandoc \"$@\"' > /entrypoint.sh && \
        chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "-v" ]

COPY Dockerfile /Dockerfile
WORKDIR /data

USER pandoc:pandoc
ENV PATH="~pandoc/.cargo/bin:${PATH}"
