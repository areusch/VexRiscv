FROM mozilla/sbt:latest
#ubuntu:20.04

ENV SBT_OPTS -Dsbt.ivy.home=/sbt/.ivy2 -Divy.home=/sbt/.ivy2

COPY install.sh /root/install.sh
RUN chmod u+x /root/install.sh
RUN /root/install.sh
