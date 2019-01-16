FROM novate/hexo

RUN buildDeps='git-core ca-certificates' \
  && apt-get update \
  && apt-get install -y $buildDeps --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
  && cd /var/opt/hexo \
  && npm i -S hexo-generator-search hexo-generator-feed hexo-renderer-less hexo-autoprefixer hexo-generator-json-content \
  && git clone http://github.com/stkevintan/hexo-theme-material-flow themes/material-flow \
  && apt-get purge -y --auto-remove $buildDeps

EXPOSE 4000

VOLUME /var/opt/blog

WORKDIR /var/opt/blog

COPY assets/source/images/avatar.png /var/opt/hexo/source/images/
COPY assets/source/images/favicon.ico /var/opt/hexo/source/images/
COPY assets/themes/material-flow/_config.yml /var/opt/hexo/themes/material-flow/
COPY assets/_config.yml /var/opt/hexo/

COPY assets/wrapper /usr/local/bin/

CMD ["/usr/local/bin/wrapper"]
