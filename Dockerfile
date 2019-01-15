FROM novate/node

RUN apt-get update \
  && apt-get install -y git-core --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
  && npm install -g hexo-cli \
  && hexo init /var/opt/hexo \
  && cd /var/opt/hexo \
  && npm i -S hexo-generator-search hexo-generator-feed hexo-renderer-less hexo-autoprefixer hexo-generator-json-content \
  && git clone https://github.com/stkevintan/hexo-theme-material-flow themes/material-flow

WORKDIR /var/opt/blog

EXPOSE 4000

VOLUME /var/opt/blog

COPY assets/source/images/avatar.png /var/opt/hexo/source/images/
COPY assets/source/images/favicon.ico /var/opt/hexo/source/images/
COPY assets/themes/material-flow/_config.yml /var/opt/hexo/themes/material-flow/
COPY assets/_config.yml /var/opt/hexo/

COPY assets/wrapper /usr/local/bin/

CMD ["/usr/local/bin/wrapper"]
