
FROM resin/rpi-raspbian:jessie

MAINTAINER Pie <pie@piesweb.co.uk>

ENV PYTHON_VERSION 3.5.2

RUN apt-get update && apt-get install -y -qq curl \
    build-essential \
    libncursesw5-dev \
    libgdbm-dev \
    libc6-dev \
    zlib1g-dev \
    libsqlite3-dev \
    tk-dev \
    libssl-dev \
    openssl \
    file \
    && cd /tmp \
    && curl -SLk "https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.xz" -o python.tar.xz \
    && tar xf python.tar.xz \
    && rm python.tar.xz \
    && cd "/tmp/Python-$PYTHON_VERSION" \
    && ./configure --enable-shared \
    && make \
    && mkdir tmp_install \
    && make install DESTDIR=tmp_install \
    && for F in `find tmp_install | xargs file | grep "executable" | grep ELF | grep "not stripped" | cut -f 1 -d :`; do \
            [ -f $F ] && strip --strip-unneeded $F; \
        done \
    && for F in `find tmp_install | xargs file | grep "shared object" | grep ELF | grep "not stripped" | cut -f 1 -d :`; do \
            [ -f $F ] && if [ ! -w $F ]; then chmod u+w $F && strip -g $F && chmod u-w $F; else strip -g $F; fi \
        done \
    && for F in `find tmp_install | xargs file | grep "current ar archive" | cut -f 1 -d :`; do \
            [ -f $F ] && strip -g $F; \
        done \
    && find tmp_install \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' + \
    && find tmp_install \( -type d -a -name test -o -name tests \) | xargs rm -rf \
    && $(cd tmp_install; cp -R . /) \
    && /sbin/ldconfig \
    && curl -SLk 'https://bootstrap.pypa.io/get-pip.py' | python3 \
    && find /usr/local \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' + \
    && find /usr/local \( -type d -a -name test -o -name tests \) | xargs rm -rf \
    && rm -rf "/tmp/Python-$PYTHON_VERSION" \
    && apt-get --purge remove \
        build-essential \
        libncursesw5-dev \
        libgdbm-dev \
        libc6-dev \
        zlib1g-dev \
        libsqlite3-dev \
        tk-dev \
        libssl-dev \
        openssl \
        file \
    && apt-get autoremove \
    && cd /usr/local/bin \
    && ln -s easy_install-3.5 easy_install \
    && ln -s idel3 idle \
    && ln -s pydoc3 pydoc \
    && ln -s python3 python \
    && ln -s python3-config python-config

CMD ["/bin/bash"]
