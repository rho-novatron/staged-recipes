@echo on

mkdir build
cd build

set GINKGO_CUDA=OFF
if not "%cuda_compiler_version%"=="None" set GINKGO_CUDA=ON

cmake -GNinja ^
    %CMAKE_ARGS% ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_INSTALL_LIBDIR=lib ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DBUILD_SHARED_LIBS=ON ^
    -DGINKGO_BUILD_REFERENCE=ON ^
    -DGINKGO_BUILD_OMP=OFF ^
    -DGINKGO_BUILD_MPI=OFF ^
    -DGINKGO_BUILD_HIP=OFF ^
    -DGINKGO_BUILD_SYCL=OFF ^
    -DGINKGO_BUILD_CUDA=%GINKGO_CUDA% ^
    -DGINKGO_BUILD_TESTS=OFF ^
    -DGINKGO_BUILD_BENCHMARKS=OFF ^
    -DGINKGO_BUILD_EXAMPLES=OFF ^
    -DGINKGO_BUILD_DOC=OFF ^
    -DGINKGO_BUILD_HWLOC=OFF ^
    -DGINKGO_DEVEL_TOOLS=OFF ^
    ..
if errorlevel 1 exit 1

cmake --build .
if errorlevel 1 exit 1

cmake --install .
if errorlevel 1 exit 1
