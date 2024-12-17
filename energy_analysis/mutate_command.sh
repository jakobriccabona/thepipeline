#!/bin/bash

# design or control for protocol
protocol="design"
outdir="output"
mutpos="204A"
mutaa="ALA"
nstruct=20

# Command
mkdir -p ${outdir}
rosetta/main/source/bin/rosetta_scripts.static.linuxgccrelease \
	-parser:protocol design.v02.xml \
	-parser:script_vars mutpos=${mutpos} mut_aa=${mutaa} protocol=${protocol} symfile=input/input.symm \
	-in:file:s input/input.pdb \
	-corrections:beta_nov16 \
	-out:path:all ${outdir} \
	-overwrite \
	-out:suffix _design \
	-nstruct ${nstruct}
	

