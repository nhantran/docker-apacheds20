FROM nhantran/oraclejdk17
MAINTAINER Nhan Tran <tranphanquocnhan@gmail.com>

WORKDIR /opt
RUN wget http://www.webhostingjams.com/mirror/apache//directory/apacheds/dist/2.0.0-M20/apacheds-2.0.0-M20.tar.gz
RUN tar xvf apacheds-2.0.0-M20.tar.gz
RUN mv apacheds-2.0.0-M20 apacheds && rm apacheds-2.0.0-M20.tar.gz
RUN apt-get install -y ldap-utils

ADD startApacheDS apacheds/bin/startApacheDS
ADD updateAdminPassword apacheds/bin/updateAdminPassword
RUN chmod u+x apacheds/bin/startApacheDS
RUN chmod u+x apacheds/bin/updateAdminPassword

EXPOSE 10389

RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
