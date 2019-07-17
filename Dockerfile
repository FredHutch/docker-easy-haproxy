FROM haproxy:1.9-alpine

WORKDIR /scripts

RUN apk add --no-cache bash python3 py-yaml supervisor docker

COPY requirements.txt /scripts
RUN pip3 install --upgrade pip \
 && pip install -r requirements.txt

COPY swarm.* /scripts/
COPY static.* /scripts/
COPY templates /scripts/templates/
COPY easymapping /scripts/easymapping/

COPY assets /


#CMD ["haproxy", "-f", "/etc/haproxy/haproxy.cfg"]
CMD ["/usr/bin/supervisord",  "-n",  "-c", "/etc/supervisord.conf" ]