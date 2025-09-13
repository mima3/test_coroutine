FROM fukamachi/sbcl:latest
RUN apt-get update && apt-get install -y --no-install-recommends git patch && rm -rf /var/lib/apt/lists/*
WORKDIR /app
ARG GIT_REF=89178b1ae0373313db86d895c4c7265407bd3c40
RUN git clone https://github.com/jeffshrager/IPL-V.git . \
 && git fetch origin ${GIT_REF} --depth=1 \
 && git checkout -qf ${GIT_REF}
COPY src/j100-h5-stop.patch /app/j100-h5-stop.patch
RUN patch -p0 < /app/j100-h5-stop.patch 
