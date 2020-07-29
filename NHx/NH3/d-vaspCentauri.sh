#!/bin/bash
### Number of nodes - 1 nodes using 12 cores per node
#PBS -l nodes=2:ppn=40
### Example: to request 2 VPs on each of 3 nodes and 1 VPs on 2 more nodes
## #PBS -l nodes=10:ppn=4+2:ppn=1
### Output files. If not specified PBS uses the job name and ID.
#PBS -j oe
### Mail to user
#PBS -m eb
#PBS -q default
#PBS -l walltime=206:00:00
### Job cluster
#PBS -N Ceria_NHx 
### Job Accounting Name
#PBS -A Testing
### Declare job-non-rerunable
#PBS -r n

PBS_PWD="$(pwd)"
cd "${PBS_O_WORKDIR}"
THIS_HOST="$(hostname)"

#Standard
MYMPIPROG="/opt/vasp_neb/bin/vasp_std"
#Gamma Point
#MYMPIPROG="/opt/vasp_neb/bin/vasp_gam"
#Non-colinear
#MYMPIPROG="/opt/vasp_neb/bin/vasp_ncl"

NPROCS="$(wc -l < ${PBS_NODEFILE} | tr -d '[:blank:]')"

run_mpirun()
{
	OPENMPI_CMD="mpiexec -np ${NPROCS} ${MYMPIPROG}";
	printf "%s\n\n" "${OPENMPI_CMD}";
	time ${OPENMPI_CMD};
	#sleep 10;
}

main()
{
	print_job_info;
	run_mpirun | tee JOB_OUTPUT.txt;
	hr;
}

time main;
