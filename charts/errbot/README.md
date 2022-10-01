# Errbot

[Errbot](https://errbot.readthedocs.io/en/latest/) is a chatbot, a daemon that connects to your favorite chat service and brings your tools into the conversation.

## Components

This chart installs the following required components:

- [Redis](https://artifacthub.io/packages/helm/bitnami/redis) (optional)

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release .
```

The command deploys Errbot on the Kubernetes cluster in the default configuration.

**NOTE:** To successfully run Errbot, you will need to provide a custom image (for missing dependencies) and configuration to connect to your Chat backend.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Persistence

The Errbot image stores data and plugin downloads at the `/home/errbot` path of the container.

The chart mounts a [Persistent Volume](https://kubernetes.io/docs/user-guide/persistent-volumes/) volume at this location. The volume is created using dynamic volume provisioning, by default. An existing PersistentVolumeClaim can also be defined.
