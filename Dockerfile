FROM ubuntu:20.04
EXPOSE 18080 18081
RUN adduser --system  --gecos "Monero Node Service" --disabled-password --group --home /var/lib/monerod monerod
RUN chown monerod /var/lib/monerod

USER monerod
WORKDIR /var/lib/monerod

# Should be in /etc but we keep everything in one directory because we can
COPY configs /var/lib/monerod/configs
COPY ["docker-entrypoint.sh", "monerod" ,"/usr/local/bin/"]

ENTRYPOINT ["monerod"]
CMD ["--non-interactive", "--config-file=/var/lib/monerod/configs/production.config"]
