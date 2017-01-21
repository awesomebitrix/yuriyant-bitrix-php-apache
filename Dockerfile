FROM centos:7
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RuN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
RUN yum -y install httpd; yum clean all; systemctl enable httpd.service
RUN yum -y install \
    epel-release \
    mysql-devel \
    mysql-libs \
    mod_ssl \
    php \
    php-cli \
    php-ldap \
    php-mbstring \
    php-mcrypt \
    php-mysql \
    php-pear-MDB2-Driver-mysqli \
    php-pecl-memcached \
    php-xml \
    php-gd \
    msmtp \
    && yum -y update bash \
    && rm -rf /var/cache/yum/* \
    && yum clean all
COPY .dockerconf/httpd.conf /etc/httpd/conf/httpd.conf
COPY .dockerconf/php.ini /etc/php.ini
EXPOSE 80
CMD /usr/sbin/httpd -c "ErrorLog /dev/stdout" -DFOREGROUND