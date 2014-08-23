FROM ubuntu:trusty
MAINTAINER Niklas Andersson <niklas.andersson@openforce.se>
ENV REFRESHED_AT 2014-08-23-1
RUN apt-get update -yqq
ADD slapd.debconf /tmp/slapd.debconf
ADD of.ldif /tmp/of.ldif
ADD nandersson.ldif /tmp/
RUN debconf-set-selections /tmp/slapd.debconf
RUN apt-get install slapd ldap-utils -y
ADD cn={0}sudo.ldif /tmp/
RUN slapadd -v -F /etc/ldap/slapd.d/ -l /tmp/cn={0}sudo.ldif -b 'cn=config'
RUN slapadd -l /tmp/of.ldif
RUN slapadd -v -l /tmp/nandersson.ldif
RUN chown -R openldap:openldap /etc/ldap/slapd.d/*
ADD ldap.conf /etc/ldap/ldap.conf
CMD /usr/sbin/slapd -d 5 -h "ldap:/// ldapi:///" -g openldap -u openldap -F /etc/ldap/slapd.d
EXPOSE 389 636
