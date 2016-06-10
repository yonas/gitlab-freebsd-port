# GitLab is now in [ports](http://www.freshports.org/www/gitlab)!
You can now install GitLab using `pkg install gitlab`.

# A GitLab port for FreeBSD

## Install using packages

```
# Download the package
pkg install ca_root_nss
fetch https://github.com/yonas/gitlab-freebsd-port/raw/master/gitlab-8.1.txz

# Install the package
pkg install krb5
pkg install gitlab-8.1.txz

# Enable accept filters for unicorn
echo 'accf_http_load="YES"' >> /boot/loader.conf

# Reboot the server to enable accept filters
reboot

# Run the setup script
/usr/local/bin/gitlab-setup

# Go to http://<your server IP address>/ in your browser
```

## Install using ports

```
# Download and install this port
git clone https://github.com/yonas/gitlab-freebsd-port
cd gitlab-freebsd-port
make install

# Enable accept filters for unicorn
echo 'accf_http_load="YES"' >> /boot/loader.conf

# Reboot the server to enable accept filters
reboot

# Run the setup script
/usr/local/bin/gitlab-setup

# Go to http://<your server IP address>/ in your browser
```

## Running in a jail

If you'd like to run GitLab in a [jail](https://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/jails.html), you'll need to enable sysvipc for Postgres. For example, if you're using [io cage](http://iocage.readthedocs.org/en/latest):
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

All these settings should be configured before running the `gitlab-setup` script.

## Credits
The original setup script was obtained from a [gitlab recipe](https://github.com/gitlabhq/gitlab-recipes/blob/master/install/freebsd/freebsd-10.md) and the very well written [installation instructions](https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/install/installation.md).
