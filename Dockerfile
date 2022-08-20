FROM nightscape/scala-mill

# install bloop server
RUN apt-get update \
  && wget -O /usr/bin/coursier https://git.io/coursier-cli && chmod +x /usr/bin/coursier \
  && coursier install --dir /usr/bin bloop --only-prebuilt=true \
  && coursier bootstrap bloop --standalone -o bloop

WORKDIR /tmp

COPY bin/ .

RUN mill mill.contrib.Bloop/install

RUN bloop compile root

RUN bloop run root

CMD [""]
