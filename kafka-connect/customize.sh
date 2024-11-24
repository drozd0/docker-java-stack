#!/usr/bin/env bash

DEBEZIUM_VERSION=$1
ASYNC_PROFILER=$2

echo "Running customize script" && \
echo "##### DEBEZIUM_VERSION - $DEBEZIUM_VERSION"
echo "##### ASYNC_PROFILER - $ASYNC_PROFILER"

yum update -y && \
yum install -yq vim jq wget unzip htop

arch=$(uname -m)
echo "Installing async profiler"
if [[ "$arch" == "x86_64" ]]; then
  echo "x86 architecture detected."
  wget -q https://github.com/async-profiler/async-profiler/releases/download/v$ASYNC_PROFILER/async-profiler-$ASYNC_PROFILER-linux-x64.tar.gz -O /tmp/async-profiler-$ASYNC_PROFILER-linux.tar.gz
else
  echo "arm architecture detected."
  wget -q https://github.com/async-profiler/async-profiler/releases/download/v$ASYNC_PROFILER/async-profiler-$ASYNC_PROFILER-linux-arm64.tar.gz -O /tmp/async-profiler-$ASYNC_PROFILER-linux.tar.gz
fi

tar -xvzf /tmp/async-profiler-$ASYNC_PROFILER-linux.tar.gz -C /appuser/profiler && \
chmod 775 -R /appuser/profiler/ && \
chown -R appuser:appuser /appuser/profiler/

echo "Installing Debezium MySQL connector" && \
wget https://repo1.maven.org/maven2/io/debezium/debezium-connector-mysql/$DEBEZIUM_VERSION/debezium-connector-mysql-$DEBEZIUM_VERSION-plugin.tar.gz -O /tmp/debezium-connector-mysql-plugin.tar.gz && \
tar -xvzf /tmp/debezium-connector-mysql-plugin.tar.gz -C /usr/share/java/kafka