FROM openjdk:11.0.5-jre-stretch

MAINTAINER wu.nan@sye-info.com

WORKDIR /opt/

RUN set -x && \
  wget -O openoffice.tar.gz https://udomain.dl.sourceforge.net/project/openofficeorg.mirror/4.1.9/binaries/zh-CN/Apache_OpenOffice_4.1.9_Linux_x86-64_install-rpm_zh-CN.tar.gz && \
  tar -xzvf openoffice.tar.gz && \
  cd zh-CN/RPMS/ && \
  rpm -ivh *.rpm && \
  rpm -ivh desktop-integration/*redhat*.rpm && \
  cd /opt/ && \
  rm -rf openoffice.tar.gz && \
  rm -rf zh-CN/RPMS && \
  echo "#!/bin/bash" > entrypoint.sh && \
  echo "exec /opt/openoffice4/program/soffice -headless -accept=\"socket,host=0.0.0.0,port=2002;urp;\" -nofirststartwizard" >> entrypoint.sh && \
  chmod +x entrypoint.sh

EXPOSE 2002

ENTRYPOINT ["./entrypoint.sh"]
