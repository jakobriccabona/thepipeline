#!/bin/bash
#SBATCH --job-name=ESM
#SBATCH --time=2-00:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --mem=32G
#SBATCH --gres=gpu:v100:1
#SBATCH --array=1-5
#SBATCH --partition=clara

INPUT_DIR="input"
OUTPUT_DIR="output"

mkdir -p "$OUTPUT_DIR/$1"

export LIBRARY_PATH=$LIBRARY_PATH:/work/mb97hape-rosetta_src/tensorflow_lib/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/work/mb97hape-rosetta_src/tensorflow_lib/lib

module load OpenMPI/4.1.1-GCC-10.3.0
module unload libxml2
#module load Rosetta

mkdir -p "$OUTPUT_DIR/$1"
    
/work/mb97hape-rosetta_src/rosetta/source/bin/rosetta_scripts.mpitensorflowtorch.linuxgccrelease \
    -parser:protocol run_esm_and_save.xml \
    -s "input/$1.pdb" \
    -parser:script_vars filename="esm.weights" \
    -parser:script_vars pssm="$1" \
    -nstruct 200 \
    -out:path:all "$OUTPUT_DIR/$1" \
    -ex1 \
    -ex2 \
    -beta \
    -auto_download \
    -multiple_processes_writing_to_one_directory 
