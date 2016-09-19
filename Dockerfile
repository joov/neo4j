FROM hypriot/rpi-java:latest
MAINTAINER Johannes Wenzel <johannes.wenzel@web.de>

ENV NEO4J_SHA256 e1da51163eb18380623788eabea34dfe23ee21c99deca4e7922094b0d242e805
ENV NEO4J_URI http://dist.neo4j.org/neo4j-community-3.0.4-unix.tar.gz

RUN apt-get update 
RUN apt-get -y install curl

RUN curl --fail --silent --show-error --location --output neo4j.tar.gz $NEO4J_URI \
    && tar --extract --file neo4j.tar.gz --directory /var/lib \
    && mv /var/lib/neo4j-* /var/lib/neo4j \
    && rm neo4j.tar.gz

WORKDIR /var/lib/neo4j

RUN mv data /data \
    && ln --symbolic /data

VOLUME /data

COPY docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 7474 7473 7687

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["neo4j"]
