# NextFlow Example
[![NF Pipeline](https://github.com/dmolitor/nextflow-example/actions/workflows/nf-pipeline.yml/badge.svg)](https://github.com/dmolitor/nextflow-example/actions/workflows/nf-pipeline.yml)

This repo demonstrates a simple ML pipeline built with NextFlow. It performs hyper-parameter
tuning, selects the optimal model, and generates an analysis report.

## Dependencies
This pipeline requires NextFlow and Docker to be installed:
- [x] Install [NextFlow](https://www.nextflow.io/docs/latest/getstarted.html#installation).
- [x] Install [Docker](https://www.docker.com/products/docker-desktop/).

## Build

For the respective execution environment, you most likely will have to create an additional
`nextflow.config` file that mounts the environment's root directory in the Docker container.
For instance, the two examples below mount the necessary root directories for executing the
pipeline on macOS and Github Actions runners.

### macOS
```shell
nextflow -c nextflow-macos.config run main.nf
```

### Github Actions
```shell
nextflow -c nextflow-gh.config run main.nf
```

## Github Actions
The report is built and deployed via Github Actions, demonstrating a simple use-case of
NextFlow x Github Actions.
