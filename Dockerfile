# Use CentOS 5 as the base image
FROM centos:5

# Clear any existing repositories and add new from local file
RUN rm -f /etc/yum.repos.d/* \
    && yum clean all
ADD CentOS-Vault.repo /etc/yum.repos.d/

# Add the flex.i386 RPM package to the container
ADD flex-2.5.4a-41.fc6.i386.rpm /tmp/

# Run clean all and update, then install packages, including flex from local RPM
RUN yum update -y \
    && yum downgrade -y libselinux \
    && yum install -y \
        curl.x86_64 curl-devel.i386 gcc.x86_64 gcc-c++.x86_64 gdb.x86_64 make.x86_64 \
        glibc-devel.x86_64 glibc-devel.i386 libstdc++-devel.x86_64 libstdc++-devel.i386 \
        mysql-devel.i386 zlib-devel.i386 perl.x86_64 \
    && rpm -ivh /tmp/flex-2.5.4a-41.fc6.i386.rpm \
    && rm -f /tmp/flex-2.5.4a-41.fc6.i386.rpm \
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

