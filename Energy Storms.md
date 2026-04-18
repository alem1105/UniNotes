*Storms of high-energy particles
EduHPC'18 Peachy Assignment*

# Introduction
In this problem, we are provided with a surface (layer) on which cycles occur, consisting of two phases:
1. **Storm**
2. **Relaxation**

During the **storm** phase, particles fall onto the layer at specific positions. Energy is released into the cell where the particle lands, as well as into its adjacent cells.

This energy is then stabilized during the **relaxation** phase. In this second phase, the value of each cell becomes the average of the cell itself and its two adjacent cells (if they exist).

After each relaxation phase, the value and position of the layer's current relative maximum must be identified.

At the end of the execution, the program will return two arrays with a size equal to the number of storm cycles:
- The first array will contain the maximum value of storm _i_ at position _i_.
- The second array will contain the position of that maximum.

# Test

For the **MPI / OpenMP** implementation, the project is divided into two main files:
- `energy_storms_mpi_omp.c`
- `energy_storms_mpi_omp_core.c`

For the **CUDA** implementation:
- `energy_storms_cuda.cpp`
- `energy_storms_cuda_core.cu`

In both cases, we recommend using `make` to run the tests. You can check the configuration in the `Makefile` and modify the compilation and execution flags in `student.mk`.

You can run the commands defined in the `Makefile`, such as `make run_mpi` or `make run_cuda`, to execute Test \#2 with MPI / OpenMP or CUDA, respectively.

Regarding MPI / OpenMP, we needed more flexibility for testing, so we created a `test.sh` script. This script allows us to run the executable and specify exactly which tests to launch each time.

Inside the script, you can change the `DEFAULT_PROCS` variable to set the number of processes. Then, you can use the following command:

```bash
./test.sh [test numbers]
```

For example, running `./test.sh 6 7` will execute Test \#6 and Test \#7 using the same number of processes.
