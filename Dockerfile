FROM twobombs/cudacluster:dev

RUN apt update && apt install -y libxrandr-dev

RUN apt remove --purge cmake 
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
RUN apt-add-repository "deb https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main" && apt update && apt install -y cmake && apt clean all

RUN git clone --recursive https://github.com/NVlabs/instant-ngp.git && cd instant-ngp && cmake .

COPY run-node /root/run-node
RUN chmod 744 /root/run-node 

EXPOSE 22 80 8801-8811
ENTRYPOINT /root/run-node
