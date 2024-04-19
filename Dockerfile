FROM centos:5
RUN rm -f /etc/yum.repos.d/*
ADD CentOS-Vault.repo /etc/yum.repos.d/
# fix weird clash between selinux libs
RUN yum downgrade -y libselinux
# install our dev set (still needs looking at)
RUN yum install -y curl.x86_64 curl-devel.i386 gcc.x86_64 gcc-c++.x86_64 gdb.x86_64 \
      glibc-devel.i386 libstdc++-devel.i386 mysql55-mysql-devel.i386 zlib-devel.i386 \
      && yum clean all \
      && yum update -y
