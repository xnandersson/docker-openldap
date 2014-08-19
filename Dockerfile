FROM ubuntu:trusty
MAINTAINER Niklas Andersson <niklas.andersson@openforce.se>
ENV REFRESHED_AT 2014-08-19-1
RUN apt-get update -yqq
ADD slapd.debconf /tmp/slapd.debconf
ADD of.ldif /tmp/of.ldif
RUN debconf-set-selections /tmp/slapd.debconf
RUN apt-get install slapd ldap-utils -y
RUN slapadd -l /tmp/of.ldif
ADD ldap.conf /etc/ldap/ldap.conf
CMD /usr/sbin/slapd -d 0 -h "ldap:/// ldapi:///" -g openldap -u openldap -F /etc/ldap/slapd.d
EXPOSE 389 636
