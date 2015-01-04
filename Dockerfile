FROM ubuntu:14.10

# Install base packages
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install curl unzip -y

# Install Dependancys
RUN apt-get install python build-essential -y


# download source
#VOLUME /opt/teeworld
RUN mkdir -p /opt/teeworld
WORKDIR /opt/teeworld
RUN curl https://downloads.teeworlds.com/teeworlds-0.6.3-src.tar.gz | tar -vxz
RUN curl -O https://www.teeworlds.com/files/bam-0.4.0.zip && unzip bam-0.4.0.zip && rm bam-0.4.0.zip

# Compile bam
WORKDIR /opt/teeworld/bam-0.4.0
RUN ./make_unix.sh

# Compile TeeWorld Servera
WORKDIR /opt/teeworld/teeworlds-0.6.3-src
RUN ../bam-0.4.0/bam server_release

# add config file
ADD server.cfg /opt/teeworld/server.cfg

#define ports
EXPOSE 8303/udp
EXPOSE 8304
# Define default command
CMD ["/opt/teeworld/teeworlds-0.6.3-src/teeworlds_srv", "-f", "/opt/teeworld/server.cfg"]
