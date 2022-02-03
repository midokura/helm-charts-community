# Nginx static

This Helm Chart installs [nginx](https://nginx.org/) web server and optionally enables pulling content from Git servers using SSH-keys.

Main purpose of this Helm Chart is to serve a static page, by using upstream base image, or your own custom image with content already bundled.

Please note that default values are enforcing a `digest` to ensure you deploy the same Docker image version.
You can override this by providing another valid digest or removing the value:

```yaml
image:
  digest: null
```
