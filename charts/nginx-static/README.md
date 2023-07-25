# Nginx static

This Helm Chart installs [nginx](https://nginx.org/) web server and optionally enables pulling content from Git servers using SSH-keys.

Main purpose of this Helm Chart is to serve a static page, by using upstream base image, or your own custom image with content already bundled.

Please note that default values are enforcing a `digest` to ensure you deploy the same Docker image version.
You can override this by providing another valid digest or removing the value:

```yaml
image:
  digest: null
```

## Persistence

Optionally, you can use `persistence` to store permanent data (suitable for custom images).
Note that this will still use `Deployment` type, so it requires to run as a **single replica**, unless you provide a StorageClass with `ReadWriteMany` support.

## nginx configuration

If you have your own customized image including `server` settings definition, you can disable the mount of default configuration.

```yaml
configNginx: false
```

If you want to keep using default `nginx` application, you can expand the `default.conf` with your own settings - for example, redirect a location to somewhere else.
