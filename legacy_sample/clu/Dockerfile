# Debianで Portable CLU (PCLU) をビルドして実行
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential git curl ca-certificates autoconf automake libtool pkg-config m4 \
 && rm -rf /var/lib/apt/lists/*

ENV CLUHOME=/opt/pclu
WORKDIR /opt

# PCLU（実用フォーク）
RUN git clone https://github.com/nbuwe/pclu.git $CLUHOME

# --- Boehm GC 7.2s をビルド（privateヘッダも配置） ---
RUN set -eux; \
    mkdir -p "$CLUHOME/code/gc"; \
    cd /tmp; \
    curl -fsSL https://github.com/ivmai/bdwgc/releases/download/v7.2s/gc-7.2s.tar.gz -o gc.tar.gz; \
    mkdir -p /tmp/gc-src; \
    tar -xzf gc.tar.gz --strip-components=1 -C /tmp/gc-src; \
    cd /tmp/gc-src; \
    CFLAGS="-O2 -fcommon" ./configure --enable-static=yes --enable-shared=no \
                --enable-threads=no --with-libatomic-ops=no \
                --prefix="$CLUHOME/code/gc"; \
    make -j"$(nproc)"; \
    make install; \
    # 未インストールの private / 補助ヘッダを補完
    mkdir -p "$CLUHOME/code/gc/include/gc/private"; \
    cp -a include/private/*.h "$CLUHOME/code/gc/include/gc/private/"; \
    cp -a include/*.h          "$CLUHOME/code/gc/include/gc/"

# --- PCLU 本体をビルド（symlinksに任せるので code/include/gc は作らない） ---
WORKDIR $CLUHOME
RUN mkdir -p $CLUHOME/include $CLUHOME/exe && \
    make symlinks || true && \
    cd code && make -w && \
    cd $CLUHOME/code/cmp && make -w && \
    cd $CLUHOME/lib && make libs && \
    cd $CLUHOME/cmpclu && make lib && make -w

ENV PATH="$CLUHOME/exe:$PATH"
WORKDIR /work
