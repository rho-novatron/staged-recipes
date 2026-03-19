# Ginkgo conda-forge recipe

## Local build verification

### Prerequisites

Install [pixi](https://pixi.sh):

```sh
curl -fsSL https://pixi.sh/install.sh | sh
```

### macOS (native, tested on arm64)

```sh
pixi run -e osx python build-locally.py osx_arm64
```

### Linux (uses Docker)

```sh
pixi run build-linux
```

When prompted, select the `linux_64` config (typically option 1).

Alternatively, pass the config directly:

```sh
pixi run -e linux python build-locally.py linux_64
```

### Build output

Successful builds produce `.conda` packages in `miniforge3/conda-bld/<platform>/`.
Three variants are built: `nompi`, `mpi_mpich`, and `mpi_openmpi`.
