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

## Running in a jail

If you'd like to run GitLab in a jail, you'll need to enable sysvipc for Postgres. For example, if you're using io cage:
```
iocage stop gitlab
iocage set allow_sysvipc=1 gitlab
iocage start gitlab
```

You should also set the IP address and hostname:
```
iocage stop gitlab
iocage set ip4_addr="igb0|192.168.2.10/24" gitlab
iocage set hostname="gitlab.server" gitlab
iocage start gitlab
```
