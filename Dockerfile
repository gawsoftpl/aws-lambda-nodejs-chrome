FROM public.ecr.aws/lambda/nodejs:16 AS build-chrome

# Install yarn
RUN npm install --global yarn

# Install chrome
RUN echo -e '\
[google-chrome]\n\
name=google-chrome - 64-bit\n\
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64\n\
enabled=1\n\
gpgcheck=1\n\
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub\n\
' > /etc/yum.repos.d/google-chrome.repo 


RUN yum update -y  \
    && yum install google-chrome-stable python3 make g++ -y \
    && yum clean all \
    && rm -rf /var/cache/yum \
    && rm -rf /opt/google/chrome/google-chrome \
    && rm -rf /etc/alternatives/google-chrome

# Create chrome user
RUN mkdir -p /tmp/app \
    && /usr/sbin/useradd chrome -d /tmp/app \
    && chown -R chrome:chrome /tmp/app
