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
    # Limit CUDA architectures to avoid relocation overflow from too many archs.
    # 80=A100, 86=RTX30xx, 89=RTX40xx, 90=H100, 100=B100/B200, 120=RTX50xx
    cmake_args+=(
        -DGINKGO_BUILD_CUDA=ON
        -DCMAKE_CUDA_ARCHITECTURES="80;86;89;90;100;120"
    )
else
    cmake_args+=(-DGINKGO_BUILD_CUDA=OFF)
fi

cmake "${cmake_args[@]}" ..
cmake --build .
cmake --install .
