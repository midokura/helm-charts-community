# Allure

[Allure](https://docs.qameta.io/allure/) Report is a flexible, lightweight multi-language test reporting tool. It provides clear graphical reports and allows everyone involved in the development process to extract the maximum of information from the everyday testing process.

## Components

This chart installs the following required components:

- [Allure Docker Service](https://github.com/fescobar/allure-docker-service)
- [Allure Docker Service UI](https://github.com/fescobar/allure-docker-service-ui)

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release .
```

The command deploys the Allure reporting service and the required components on the Kubernetes cluster in the default configuration.

## Users Credentials

Create a secret:

```yaml
apiVersion: v1
kind: Secret
metadata:
    name: api-credentials
type: Opaque
data:
  #echo -n 'my_username' | base64
  SECURITY_USER: bXlfdXNlcm5hbWU=
  #echo -n 'my_password' | base64
  SECURITY_PASS: bXlfcGFzc3dvcmQ=
  #echo -n 'view_user' | base64
  SECURITY_VIEWER_USER: dmlld191c2Vy
  #echo -n 'view_pass' | base64
  SECURITY_VIEWER_PASS: dmlld19wYXNz
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.