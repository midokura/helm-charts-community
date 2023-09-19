# Salt (SaltStack)

[Salt](https://saltproject.io/) is a software to automate the management and configuration of any infrastructure or application at scale.

## Components

This chart does not require any additional component to be installed.

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release .
```

The command deploys Salt and required components on the Kubernetes cluster in the default configuration.

> **Tip**: List all releases using `helm list`

## Advanced installation

You may want to use [git-sync](https://github.com/kubernetes/git-sync) to keep up-to-date in latest changes in your Salt state definition.

You can use the following values as an example:

```yaml
master:
  file_root: /srv/salt/salt-repo-NAME
  service:
    type: LoadBalancer
    loadBalancerIP: 20.0.0.1
  tolerations:
  - effect: NoSchedule
    key: kubernetes.azure.com/scalesetpriority
    operator: Equal
    value: spot
gitsync:
  enabled: true
  envFrom:
  - secretRef:
      name: salt-gitsync
  config:
    repo: https://github.com/organization/salt-repo-NAME
    username: git
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Persistence

The [SaltStack](https://hub.docker.com/r/saltstack/salt) image stores Salt configuration data (states) at `/srv/salt`, and also PKI files at `/etc/salt/pki` in a single Volume.

The chart mounts a [Persistent Volume](https://kubernetes.io/docs/user-guide/persistent-volumes/) volume at this location. The volume is created using dynamic volume provisioning, by default. An existing PersistentVolumeClaim can also be defined.
