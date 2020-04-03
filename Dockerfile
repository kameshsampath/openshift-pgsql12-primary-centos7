# The MIT License (MIT)
#
# Copyright (c) 2019 Jesper Pedersen <jesper.pedersen@redhat.com>
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the Software
# is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
# PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# openshift-pgsql12-primary-centos7
FROM centos/s2i-core-centos7

LABEL maintainer="Jesper Pedersen <jesper.pedersen@redhat.com>"

LABEL summary="PostgreSQL 12 Primary" \
      description="PostgreSQL 12 Primary" \
      io.k8s.description="PostgreSQL 12 Primary" \
      io.k8s.display-name="PostgreSQL 12 Primary" \
      io.openshift.expose-services="5432" \
      io.openshift.tags="postgresql,postgres,database" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i"

ENV PGVERSION="12"
ENV PGROOT="/usr/pgsql-${PGVERSION}"
ENV APP_DATA="/opt/app-root"

# Create root/licenses
COPY root/ /

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
      && rpm -Uvh https://download.postgresql.org/pub/repos/yum/12/redhat/rhel-7-x86_64/pgdg-redhat-repo-42.0-8.noarch.rpm \
      && yum -y update \
      && yum -y install postgresql12 postgresql12-server postgresql12-contrib postgresql12-libs crontabs nss_wrapper gettext bind-utils \
      && yum -y clean all

COPY ./s2i/bin/ /usr/libexec/s2i

RUN mkdir -p /conf /pgdata /pgwal

COPY conf/* /conf/

RUN /usr/libexec/fix-permissions /conf \
      && /usr/libexec/fix-permissions /pgdata \
      && /usr/libexec/fix-permissions /pgwal \
      && /usr/libexec/fix-permissions /var/run/postgresql

VOLUME ["/pgdata", "/pgwal"]

EXPOSE 5432

RUN /usr/libexec/fix-permissions ${APP_DATA}
RUN usermod -a -G root postgres

USER 26

ENTRYPOINT ["container-entrypoint"]
CMD ["/usr/libexec/s2i/run"]
