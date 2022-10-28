# Folding@Home

[Folding@Home](https://foldingathome.org/) (FAH or F@h) is a volunteer computing project aimed to help scientists develop new therapeutics for a variety of diseases by the means of simulating protein dynamics.
This includes the process of protein folding and the movements of proteins, and is reliant on simulations run on volunteers' personal computers.

## Components

This chart does not need any other component.

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release .
```

The command deploys Folding@Home on the Kubernetes cluster in the default configuration.

You may want to define `resources` to limit the maximum resources used for processing.

**NOTE:**: If you want to perform processing with **GPU**, define the following options in `values`:

```yaml
gpu:
  enabled: true

resources:
  limits:
    nvidia.com/gpu: "1"
    # change resource name if needed
```

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.
