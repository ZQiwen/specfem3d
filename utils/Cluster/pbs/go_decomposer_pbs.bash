#!/bin/bash
#PBS -S /bin/bash

## job name and output file
#PBS -N go_decomposer
#PBS -j oe
#PBS -o in_out_files/OUTPUT_FILES/$PBS_JOBID.o

###########################################################
# USER PARAMETERS

## 1 CPU, walltime 1 hour
#PBS -l nodes=1:ppn=1,walltime=1:00:00

###########################################################

cd $PBS_O_WORKDIR

# script to run the mesher and the solver
# read Par_file to get information about the run
# compute total number of nodes needed
NPROC=`grep NPROC in_data_files/Par_file | cut -d = -f 2 `

# total number of nodes is the product of the values read
numnodes=$NPROC

echo starting decomposer for $numnodes partitions
echo " "

# USER CHANGE MESH DIRECTORY
./bin/xdecompose_mesh_SCOTCH $numnodes examples/homogeneous_halfspace/MESH/ in_out_files/DATABASES_MPI/

echo "done "