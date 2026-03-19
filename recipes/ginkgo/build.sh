#!/bin/bash
set -ex

mkdir build && cd build

cmake_args=(
    ${CMAKE_ARGS}
    -GNinja
    -DCMAKE_INSTALL_PREFIX="${PREFIX}"
    -DCMAKE_INSTALL_LIBDIR=lib
    -DCMAKE_BUILD_TYPE=Release
    -DBUILD_SHARED_LIBS=ON
    -DGINKGO_BUILD_REFERENCE=ON
    -DGINKGO_BUILD_OMP=ON
    -DGINKGO_BUILD_TESTS=OFF
    -DGINKGO_BUILD_BENCHMARKS=OFF
    -DGINKGO_BUILD_EXAMPLES=OFF
    -DGINKGO_BUILD_DOC=OFF
    -DGINKGO_BUILD_HWLOC=OFF
    -DGINKGO_DEVEL_TOOLS=OFF
    -DGINKGO_BUILD_HIP=OFF
    -DGINKGO_BUILD_SYCL=OFF
)

# MPI support
if [[ "${mpi}" != "nompi" ]]; then
    cmake_args+=(-DGINKGO_BUILD_MPI=ON)
else
    cmake_args+=(-DGINKGO_BUILD_MPI=OFF)
fi

# CUDA support
if [[ "${cuda_compiler_version}" != "None" ]]; then
    cmake_args+=(-DGINKGO_BUILD_CUDA=ON)
else
    cmake_args+=(-DGINKGO_BUILD_CUDA=OFF)
fi

cmake "${cmake_args[@]}" ..
cmake --build .
cmake --install .
