# Atlantis Docker

Atlantis docker image with Terragrunt CLI installed.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Atlantis Docker](#atlantis-docker)
  - [🌟 Overview](#-overview)
  - [🚀 Key Features](#-key-features)
  - [Usage](#usage)
  - [Configuration](#configuration)
  - [Contributing](#contributing)
  - [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 🌟 Overview

This Docker image provides a comprehensive, lightweight, and secure solution
for running Atlantis with additional infrastructure-as-code (IaC) tools.

It combines Atlantis, OpenTofu, Terragrunt, and Terragrunt Atlantis Config into
a single, streamlined container, making infrastructure management and
automation seamless.

## 🚀 Key Features

- **Multi-Tool Integration**: Includes:

  - Atlantis (Terraform Pull Request Automation)
  - OpenTofu (Open Source Terraform Alternative)
  - Terragrunt (Terraform Wrapper)
  - Terragrunt Atlantis Config (Terragrunt Configuration Generator)

- **Architecture Support**:

  - Compatible with `arm64` and `amd64` architectures
  - Dynamically detects and configures based on system architecture

- **Security-Focused**:

  - Uses distroless base image for minimal attack surface
  - Implements SHA256 checksum verification for all downloaded binaries
  - Runs with non-root permissions

- **Version Flexibility**:
  - Configurable versions for each tool via build arguments
  - Easy to upgrade or pin to specific versions

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
