# Use CentOS 5 as the base image
FROM centos:5

# Clear any existing repositories and add new from local file
RUN rm -f /etc/yum.repos.d/* \
    && yum clean all
ADD CentOS-Vault.repo /etc/yum.repos.d/

# Run clean all and update
RUN yum update -y \
    && yum downgrade -y libselinux \
    && yum install -y \
        curl.x86_64 curl-devel.i386 gcc.x86_64 gcc-c++.x86_64 gdb.x86_64 make.x86_64 \
        glibc-devel.x86_64 glibc-devel.i386 libstdc++-devel.x86_64 libstdc++-devel.i386 \
        mysql55-mysql-devel.i386 zlib-devel.i386 flex.x86_64 perl.x86_64 \
    && yum clean all

# Add bjam & p4 to /usr/local/bin & set executable permissions
ADD bjam /usr/local/bin/
ADD p4 /usr/local/bin/
RUN cd /usr/local/bin \
    && ln -s bjam jam \
    && chmod a+x jam p4

# Set the working directory
WORKDIR /mnt/code

CMD ["/bin/bash"]

