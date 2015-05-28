FROM nhantran/oraclejdk17
MAINTAINER Nhan Tran <tranphanquocnhan@gmail.com>

WORKDIR /opt
RUN wget http://www.webhostingjams.com/mirror/apache//directory/apacheds/dist/2.0.0-M20/apacheds-2.0.0-M20.tar.gz
RUN tar xvf apacheds-2.0.0-M20.tar.gz
RUN mv apacheds-2.0.0-M20 apacheds && rm apacheds-2.0.0-M20.tar.gz
RUN apt-get install -y ldap-utils

ADD startApacheDS apacheds/bin/startApacheDS
RUN chmod u+x apacheds/bin/startApacheDS
ADD updatePassword.ldif apacheds/bin/updatePassword.ldif

EXPOSE 10389

CMD ["/opt/apacheds/bin/startApacheDS"]