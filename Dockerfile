FROM 	ubuntu:latest

MAINTAINER      YIFENG HUANG    (YIFENG.HUANG@OUTLOOK.COM)


RUN apt-get update
RUN apt-get install -y pptpd iptables
RUN rm -rf /var/lib/apt/lists/*

RUN echo "abc * 13641688762 *" >> /etc/ppp/chap-secrets
RUN echo "hyf * 13641688762 *" >> /etc/ppp/chap-secrets
RUN echo "localip 192.168.0.1" >> /etc/pptpd.conf
RUN echo "remoteip 192.168.0.100-200" >> /etc/pptpd.conf
RUN echo "ms-dns 8.8.8.8" >> /etc/ppp/pptpd-options

RUN echo "#!/bin/bash" >> run.sh
RUN echo "iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE" >> run.sh
RUN echo "pptpd -f" >> run.sh
RUN chmod +x run.sh
EXPOSE 1723

CMD ["run.sh"]
