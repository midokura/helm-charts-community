# LibreNMS

[LibreNMS](https://www.librenms.org/) is a fully featured network monitoring system that provides multiple functions for networking devices, such as automatic discovery, billing, alerting, and more.

## Components

This chart installs the following required components:

- [MariaDB](https://artifacthub.io/packages/helm/bitnami/mariadb)
- [Redis](https://artifacthub.io/packages/helm/bitnami/redis)
- [Memcached](https://artifacthub.io/packages/helm/bitnami/memcached)
- [RRDcached](https://github.com/crazy-max/docker-rrdcached)

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release .
```

The command deploys LibreNMS and required components on the Kubernetes cluster in the default configuration.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Persistence

The [LibreNMS](https://github.com/librenms/docker) image stores LibreNMS data, RRD graph and configurations at the `/data` path of the container.

The chart mounts a [Persistent Volume](https://kubernetes.io/docs/user-guide/persistent-volumes/) volume at this location. The volume is created using dynamic volume provisioning, by default. An existing PersistentVolumeClaim can also be defined.
