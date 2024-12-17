#!/bin/bash
#SBATCH --job-name=ESM_Test
#SBATCH --time=2-00:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --mem=32G
#SBATCH --gres=gpu:v100:1
#SBATCH --array=1-1000
#SBATCH --partition=clara

INPUT_DIR="input"
OUTPUT_DIR="output"

mkdir -p "$OUTPUT_DIR/$1"

export LIBRARY_PATH=$LIBRARY_PATH:/work/mb97hape-rosetta_src/tensorflow_lib/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/work/mb97hape-rosetta_src/tensorflow_lib/lib

task=$SLURM_ARRAY_TASK_ID

module load OpenMPI/4.1.1-GCC-10.3.0
module unload libxml2
#module load Rosetta

mkdir -p "$OUTPUT_DIR/$1"
    
/work/mb97hape-rosetta_src/rosetta/source/bin/rosetta_scripts.mpitensorflowtorch.linuxgccrelease \
    -parser:protocol sample_mutations.xml \
    -s "input/r${1}_HA_Widgeon_2024_sym_INPUT.pdb" \
    -parser:script_vars sym="symm/r${1}_HA_Widgeon_2024_sym_INPUT.symm" \
    -out:path:all "$OUTPUT_DIR/$1" \
    -out:prefix esm_${task}_ \
    -ex1 \
    -ex2 \
    -nstruct 1 \
    -beta \
    -overwrite