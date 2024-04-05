# static-page

This Helm Chart installs a manual-specified Docker image which exposes a web server (like `nginx`) and optionally enables auto-updating with Flux `ImageUpdatePolicy`.

Main purpose of this Helm Chart is to serve a static page, with your own custom image with content already bundled.

## Auto-update

By using Flux [Image Update Automations](https://fluxcd.io/flux/components/image/imageupdateautomations/), you can pull new versions for your Docker image,
and automatically update your git repository with the latest value.

## Persistence

No persistence is expected or enabled at the moment.
