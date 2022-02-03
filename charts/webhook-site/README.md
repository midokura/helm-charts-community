# Webhook.site

[Webhook.site](https://webhook.site/) generates unique, random URL that you can use to test and debug Webhooks and HTTP requests.

## Components

This chart installs the following required components:

- [Redis](https://artifacthub.io/packages/helm/bitnami/redis)

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release .
```

The command deploys Webhook.site and required components on the Kubernetes cluster in the default configuration.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Persistence

As this chart is for debug or testing purposes, Persistence is disabled by default (at Redis component).
