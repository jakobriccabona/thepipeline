import sys

import os
from Bio import SeqIO
from Bio import BiopythonWarning
import warnings

def extract_protein_sequences(folder_path, output_file):
    with warnings.catch_warnings():
        warnings.simplefilter('ignore', BiopythonWarning)
        with open(os.path.join(folder_path, output_file), 'w') as fasta_file:
            for filename in os.listdir(folder_path):
                if filename.endswith(".pdb"):
                    pdb_file = os.path.join(folder_path, filename)
                    for record in SeqIO.parse(pdb_file, 'pdb-atom'):
                        sequence = str(record.seq)
                        fasta_file.write(f">{filename[:-4]}\n")
                        fasta_file.write(f"{sequence}\n")

# Specify the folder path and output file name
folder_path = sys.argv[1]
output_file = sys.argv[2]

# Extract protein sequences from PDB files in the folder and write to a fasta file
extract_protein_sequences(folder_path, output_file)

def modify_fasta_names(input_file, output_file, patterns_to_remove):
    sequences = []
    current_sequence = None
    with open(input_file, 'r') as f:
        for line in f:
            line = line.strip()
            if line.startswith('>'):
                if current_sequence is not None:
                    sequences.append(current_sequence)
                current_sequence = {'name': line, 'sequence': ''}
            else:
                current_sequence['sequence'] += line
    
    if current_sequence is not None:
        sequences.append(current_sequence)
    
    with open(output_file, 'w') as f:
        for sequence in sequences:
            modified_name = sequence['name']
            for pattern in patterns_to_remove:
                modified_name = modified_name.replace(pattern, '')
            f.write(f"{modified_name}\n{sequence['sequence']}\n")

#input_file = sys.argv[2]
#output_file = sys.argv[3]
#patterns_to_remove = [sys.argv[4]]

#modify_fasta_names(input_file, output_file, patterns_to_remove)
#print(f"Modified FASTA sequences written to {output_file}")
