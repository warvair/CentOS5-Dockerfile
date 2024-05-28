FROM centos:5

# clear any existing repos and add new from local file
RUN rm -f /etc/yum.repos.d/*
ADD CentOS-Vault.repo /etc/yum.repos.d/

# run clean all and update
RUN yum clean all && yum update -y

# fix weird clash between selinux libs
RUN yum downgrade -y libselinux

# install our dev set
RUN yum install -y curl.x86_64 curl-devel.i386 gcc.x86_64 gcc-c++.x86_64 gdb.x86_64 make.x86_64 \
    glibc-devel.x86_64 glibc-devel.i386 libstdc++-devel.x86_64 libstdc++-devel.i386 \
    mysql55-mysql-devel.i386 zlib-devel.i386 flex.x86_64 perl.x86_64

# add bjam & p4 to /usr/local/bin & a+x 
ADD bjam /usr/local/bin/
ADD p4 /usr/local/bin/
RUN cd /usr/local/bin ; ln -s bjam jam ; chmod a+x jam p4

# Set the working directory
WORKDIR /mnt/code

CMD ["/bin/bash"]
