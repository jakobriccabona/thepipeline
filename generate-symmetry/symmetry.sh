#!/bin/bash
#generate symmetric files with Rosetta
/home/iwe54/rosetta/main/source/src/apps/public/symmetry/make_symmdef_file.pl -p $1".pdb" -a A -i B > $1".symm"
