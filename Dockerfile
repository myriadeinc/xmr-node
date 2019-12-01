FROM ubuntu:18.04

# Create monero user
RUN adduser --system --group --disabled-password monero && \
	mkdir -p /wallet /home/monero/.bitmonero && \
	chown -R monero:monero /home/monero/.bitmonero && \
	chown -R monero:monero /wallet

VOLUME /home/monero
# Contains the blockchain
VOLUME /home/monero/.bitmonero
WORKDIR /home/monero
COPY . .
RUN dpkg -i monero-v0.15_1.0_amd64.deb

# Generate your wallet via accessing the container and run:
# cd /wallet
# monero-wallet-cli
VOLUME /wallet

EXPOSE 18080
EXPOSE 80

# switch to user monero
USER monero

ENTRYPOINT ["monerod", "--detach","--nont-interactive","--config-file=configs/production.config"]

# FOR MANUAL DATA INTEGRITY CHECKING ENTRYPOINT ["tail", "-f", "/dev/null"]
