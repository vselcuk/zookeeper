FROM zookeeper:3.5

RUN mkdir /scripts/
COPY ./scripts /scripts
RUN chmod +x /scripts/*.sh

CMD /scripts/run.sh
