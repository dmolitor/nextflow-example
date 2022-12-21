# NextFlow Example
This repo demonstrates a simple ML pipeline built with NextFlow. It performs hyper-parameter
tuning, selects the optimal model, and generates an analysis report.

## Dependencies
This pipeline requires NextFlow and Docker to be installed:
- [x] Install [NextFlow](https://www.nextflow.io/docs/latest/getstarted.html#installation).
- [x] Install [Docker](https://www.docker.com/products/docker-desktop/).

## Build

### Linux
```shell
nextflow run main.nf
```

### macOS
```shell
nextflow -c nextflow-osx.config run main.nf
```

## Github Actions
The report is built and deployed via Github Actions, demonstrating a simple use-case of
NextFlow x Github Actions.
