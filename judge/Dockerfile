FROM node:14

RUN sed -i s@/deb.debian.org/@/mirrors.aliyun.com/@g /etc/apt/sources.list
RUN apt-get clean

RUN yarn global add pm2  && \
    wget https://s3.undefined.moe/file/executor-amd64 -O /usr/bin/sandbox && \
    chmod +x /usr/bin/sandbox

RUN apt-get -qq update && \
    apt-get install -y \
    gcc \
    python3 \
    g++ \
    python \
    libjavascriptcoregtk-4.0-bin \
    golang

# 安装Jdk16
RUN wget https://download.java.net/java/GA/jdk16.0.2/d4a915d82b4c4fbb9bde534da945d746/7/GPL/openjdk-16.0.2_linux-x64_bin.tar.gz && \
    tar xvf openjdk-16.0.2_linux-x64_bin.tar.gz && \
    rm -f openjdk-16.0.2_linux-x64_bin.tar.gz 

# 安装pypy3
RUN wget https://downloads.python.org/pypy/pypy3.8-v7.3.6rc1-linux64.tar.bz2 && \
    tar jxvf pypy3.8-v7.3.6rc1-linux64.tar.bz2 && \
    rm -f pypy3.8-v7.3.6rc1-linux64.tar.bz2

RUN mv /pypy3.8-v7.3.6rc1-linux64 /usr/lib && \
    ln -s /usr/lib/pypy3.8-v7.3.6rc1-linux64/bin/pypy /usr/bin/pypy && \
    ln -s /usr/lib/pypy3.8-v7.3.6rc1-linux64/bin/pypy3 /usr/bin/pypy3

RUN mv /jdk-16.0.2 /usr/lib && \
    ln -s /usr/lib/jdk-16.0.2/bin/javac /usr/bin/javac && \
    ln -s /usr/lib/jdk-16.0.2/bin/java /usr/bin/java

ADD ./entrypoint.sh /root/entrypoint.sh
ADD ./judge.yaml /root/judge.yaml
RUN chmod +x /root/entrypoint.sh


ENTRYPOINT ["/root/entrypoint.sh"]
