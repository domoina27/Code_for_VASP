#!/bin/bash

#SBATCH -J Test               # Job name
#SBATCH -o job.%j.out         # Name of stdout output file (%j expands to jobId)
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=20
#SBATCH --cpus-per-task=1
#SBATCH --mail-type=ALL       # send email when job status change (start, end, abortion and etc.)
#SBATCH --mail-user=domoina.holiharimanana@siu.edu
#SBATCH --mail-type=ALL       # send email when job status change (start, end, abortion and etc.)
#SBATCH --mail-user=domoina.holiharimanana@siu.edu
#SBATCH -w compute[12]

# Launch MPI-based executable
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/ohpc/pub/libs/gnu7/openmpi3/fftw/3.3.6/lib:/opt/ohpc/pub/libs/gnu7/openmpi3/scalapack/2.0.2/lib:/opt/ohpc/pub/libs/gnu7/openblas/0.2.20/lib
export OMP_NUM_THREADS=1
#srun -n $SLURM_NTASKS
/opt/ohpc/pub/mpi/openmpi3-gnu7/3.0.0/bin/mpirun  vasp_gfortran_neb > output
