FROM ubuntu:trusty
MAINTAINER Niklas Andersson <niklas.andersson@openforce.se>
ENV REFRESHED_AT 2014-08-19-1
RUN apt-get update -yqq
ADD slapd.debconf /tmp/slapd.debconf
ADD openforce.ldif /tmp/openforce.ldif
ADD of.ldif /tmp/of.ldif
RUN debconf-set-selections /tmp/slapd.debconf
RUN apt-get install slapd ldap-utils -y
RUN slapadd -l /tmp/of.ldif
ADD ldap.conf /etc/ldap/ldap.conf
