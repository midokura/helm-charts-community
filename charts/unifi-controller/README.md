# Unifi Controller

The [Unifi-controller](https://ui.com/consoles) software is a powerful, enterprise wireless software engine ideal for high-density client deployments requiring low latency and high uptime performance.

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release .
```

The command deploys Unifi-controller and required components on the Kubernetes cluster in the default configuration.

**NOTE:** It is recommended to use `nodeSelector` (or `nodeName`) to deploy to a specific node.
By default the option `hostNetwork` is enabled to expose ports directly from node.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Persistence

The image stores all configuration at the `/config` path of the container.

The chart mounts a [Persistent Volume](https://kubernetes.io/docs/user-guide/persistent-volumes/) volume at this location. The volume is created using dynamic volume provisioning, by default. An existing PersistentVolumeClaim can also be defined.
