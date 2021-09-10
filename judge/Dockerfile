FROM node:14

RUN sed -i s@/deb.debian.org/@/mirrors.aliyun.com/@g /etc/apt/sources.list
RUN apt-get clean


RUN yarn global add pm2 @hydrooj/hydrojudge && \
    wget https://s3.undefined.moe/file/executor-amd64 -O /usr/bin/sandbox && \
    chmod +x /usr/bin/sandbox

RUN apt-get -qq update && \
    apt-get install -y \
    gcc \
    python3 \
    g++ \
    fp-compiler \
    python \
    php7.0-cli \
    rustc \
    haskell-platform \
    libjavascriptcoregtk-4.0-bin \
    golang \
    ruby \
    mono-runtime \
    mono-mcs

RUN wget https://download.java.net/java/GA/jdk16.0.2/d4a915d82b4c4fbb9bde534da945d746/7/GPL/openjdk-16.0.2_linux-x64_bin.tar.gz && \
    tar xvf openjdk-16.0.2_linux-x64_bin.tar.gz

RUN mv /jdk-16.0.2 /usr/lib && \
    ln -s /usr/lib/jdk-16.0.2/bin/javac /usr/bin/javac && \
    ln -s /usr/lib/jdk-16.0.2/bin/java /usr/bin/java

ADD ./entrypoint.sh /root/entrypoint.sh
ADD ./judge.yaml /root/judge.yaml
RUN chmod +x /root/entrypoint.sh


ENTRYPOINT /root/entrypoint.sh
