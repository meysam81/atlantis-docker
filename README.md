# Atlantis Docker

Atlantis docker image with Terragrunt CLI installed.

To use this image, reference it in the following format:

```shell
version=$(
  curl -s https://api.github.com/repos/meysam81/atlantis-docker/releases/latest |
  jq -r .tag_name
)
docker pull ghcr.io/meysam81/atlantis:${version}
```
