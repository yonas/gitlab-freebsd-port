# A GitLab port for FreeBSD

## How to install
```
# Install required packages
pkg install sudo bash icu cmake pkgconf git nginx node go ruby ruby21-gems logrotate redis postgresql94-server postfix krb5

# Download and install this port
git clone https://github.com/yonas/gitlab-freebsd-port
cd gitlab-freebsd-port
make install

# Run the setup script
/usr/local/bin/gitlab-setup

# Go to http://<your server IP address>/ in your browser
```
