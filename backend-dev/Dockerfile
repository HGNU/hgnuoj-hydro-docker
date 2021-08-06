FROM node:14
RUN apt update && apt install netcat -y
RUN yarn global add npx pm2
ADD ./entrypoint.sh /root/entrypoint.sh
ADD ./healthcheck.sh /root/healthcheck.sh
ADD ./watch-compile.sh /root/watch-compile.sh
RUN chmod +x /root/entrypoint.sh
ENTRYPOINT /root/entrypoint.sh
HEALTHCHECK --start-period=30s  --interval=15s --timeout=5s --retries=3 CMD /bin/bash /root/healthcheck.sh
