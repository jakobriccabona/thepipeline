#!/bin/bash

mkdir -p output

for s in {0,5,9,10,13,14,15,16,20,22} #insert the numbers of your 10 best relaxed pdbs
do
	for i in {1..1000}
	do
		$ROSETTA362/main/source/bin/rosetta_scripts.pytorchtensorflow.linuxgccrelease \
		@ design.options \
		-parser:protocol run_mpnn_and_save.xml \
		-s ./input/YOUR_SYM_RELAX_${s}_0001_INPUT.pdb \
		-parser:script_vars weights=${s}_${i}_mpnn_probs.weights \
		-out:path:all output \
		-overwrite

	done
done
