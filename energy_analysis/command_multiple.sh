#!/bin/bash

# Define the list of mutations
mutations=("194A_ARG" "323A_ASN" "295A_LEU" "52A_ASN" "192A_ASN" "284A_LYS" "49A_SER" "64A_ASN" "190A_ASN" "186A_SER")

# Design or control for protocol
protocol="design"
outdir="output"
nstruct=20

# Create the output directory if it doesn't exist
mkdir -p ${outdir}

# Loop through each mutation
for mut in "${mutations[@]}"; do
    # Split the mutation string into position and amino acid
    mutpos=${mut%_*}
    mutaa=${mut#*_}

    # Run the command
    /home/iwe54/rosetta/main/source/bin/rosetta_scripts.static.linuxgccrelease \
        -parser:protocol design.v02.xml \
        -parser:script_vars mutpos=${mutpos} mut_aa=${mutaa} protocol=${protocol} symfile=input/relax_MACV_ox_INPUT_22_0001.symm \
        -in:file:s input/relax_MACV_ox_INPUT_22_0001_INPUT.pdb \
        -corrections:beta_nov16 \
        -out:path:all ${outdir} \
        -overwrite \
        -out:suffix _design_${mutpos}_${mutaa} \
        -nstruct ${nstruct}
done
