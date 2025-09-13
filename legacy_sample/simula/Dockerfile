# Simula 67 (GNU Cim) をソースからビルド
FROM debian:bookworm-slim

# 1) 必要ツール
RUN apt-get update && apt-get install -y --no-install-recommends \
    git ca-certificates build-essential cmake ninja-build \
    bison flex pkg-config \
 && rm -rf /var/lib/apt/lists/*

# 2) CMake ビルド
RUN git clone https://github.com/sergev/simula-compiler.git /opt/cim \
 && cmake -S /opt/cim -B /opt/cim/build -G Ninja -DCMAKE_BUILD_TYPE=Release \
 && cmake --build /opt/cim/build -j"$(nproc)" \
 && cmake --install /opt/cim/build

# 実行用
WORKDIR /work
CMD ["/bin/bash"]
