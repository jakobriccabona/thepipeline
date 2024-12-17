#!/bin/bash

module purge
module load Rosetta

mkdir -p /work/usename-workspace/folder/"$1"

relax.mpi.linuxgccrelease -s /work/usename-workspace/folder/"$1".pdb -constrain_relax_to_start_coords -nstruct 1 -out:suffix _"$2" -multiple_processes_writing_to_one_directory -out:prefix relax_ -out:path:all /work/usename-workspace/folder/"$1" -scorefile /work/usename-workspace/folder/"$1"/"$1"_relax_"$2".fasc -symmetry_definition /work/usename-workspace/folder/filename.symm
