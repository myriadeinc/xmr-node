FROM ubuntu:18.04
RUN apt-get update && \
	apt-get install sudo 
# Create user docker	
RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN mkdir -p /xmr && chmod 777 -R /xmr
USER docker
COPY . /xmr
RUN sudo dpkg -i /xmr/monero-v0.15_1.0_amd64.deb

EXPOSE 18080 18081


ENTRYPOINT ["monerod"]
CMD ["--non-interactive", "--config-file=/xmr/configs/production.config"]
