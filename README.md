# Atlantis Docker

Atlantis docker image with Terragrunt CLI installed.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Atlantis Docker](#atlantis-docker)
  - [Introduction](#introduction)
  - [Prerequisites](#prerequisites)
  - [Usage](#usage)
  - [Configuration](#configuration)
  - [Contributing](#contributing)
  - [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Introduction

This repository provides a Docker image for
[Atlantis](https://www.runatlantis.io/) with
[Terragrunt](https://terragrunt.gruntwork.io/) CLI installed.

Atlantis is a tool for automating OpenTofu/Terraform workflows and Terragrunt
is a thin wrapper for OpenTofu that provides extra tools for keeping
configurations DRY and managing remote state.

## Prerequisites

- Docker installed on your machine.
- Basic knowledge of OpenTofu and Terragrunt.

## Usage

To use this image, reference it in the following format:

```shell
version=$(
  curl -s https://api.github.com/repos/meysam81/atlantis-docker/releases/latest |
  jq -r .tag_name
)
docker pull ghcr.io/meysam81/atlantis:${version}
```

Run the Docker container with the following command:

```shell
docker run -it ghcr.io/meysam81/atlantis:${version}
```

## Configuration

You can configure the Atlantis server by passing environment variables or
mounting configuration files.

Refer to the
[official documentation](https://www.runatlantis.io/docs/configuring-atlantis.html)
for more details.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## License

This project is licensed under the [Apache License, Version 2.0](LICENSE).
