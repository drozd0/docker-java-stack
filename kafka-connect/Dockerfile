FROM confluentinc/cp-kafka-connect:7.7.1

USER root

COPY customize.sh /etc/confluent/docker/customize.sh

ARG DEBEZIUM_VERSION=3.0.2.Final
ARG ASYNC_PROFILER=3.0

RUN chmod +x /etc/confluent/docker/customize.sh && \
    /etc/confluent/docker/customize.sh $DEBEZIUM_VERSION $ASYNC_PROFILER && \
    rm /etc/confluent/docker/customize.sh

USER appuser