import argparse
import pandas as pd

# Dictionary to map one-letter amino acid codes to three-letter codes
one_to_three = {
    'A': 'ALA', 'R': 'ARG', 'N': 'ASN', 'D': 'ASP', 'C': 'CYS',
    'E': 'GLU', 'Q': 'GLN', 'G': 'GLY', 'H': 'HIS', 'I': 'ILE',
    'L': 'LEU', 'K': 'LYS', 'M': 'MET', 'F': 'PHE', 'P': 'PRO',
    'S': 'SER', 'T': 'THR', 'W': 'TRP', 'Y': 'TYR', 'V': 'VAL'
}

# Function to translate one-letter code to three-letter code and add the given number twice
def translate_mutation(mutation, add_number):
    position = int(mutation[1:-1])
    mutated_aa = one_to_three[mutation[-1]]
    
    # Calculate new positions
    pos1 = position + add_number
    pos2 = pos1 + add_number
    
    return f'"{position}_{mutated_aa}" "{pos1}_{mutated_aa}" "{pos2}_{mutated_aa}"'

def main():
    # Set up argument parser
    parser = argparse.ArgumentParser(description="Translate mutations and add a specified number to positions.")
    parser.add_argument('-i', '--input', required=True, help="Input CSV file with mutations.")
    parser.add_argument('-a', '--add', type=int, required=True, help="Number to add to positions.")
    parser.add_argument('-o', '--output', default='output.txt', help="Output TXT file to save results.")
    
    # Parse arguments
    args = parser.parse_args()

    # Read input CSV file
    mutations_df = pd.read_csv(args.input)
    
    # Check if mutations column exists
    if 'mutations' not in mutations_df.columns:
        print("Error: Input file must contain a 'mutations' column.")
        return
    
    # Translate all mutations
    add_number = args.add
    translated_mutations = [translate_mutation(mutation, add_number) for mutation in mutations_df['mutations']]
    
    # Save the results to a TXT file
    with open(args.output, 'w') as f:
        for formatted in translated_mutations:
            f.write(f"{formatted}\n")
    print(f"\nResults saved to {args.output}")

if __name__ == "__main__":
    main()

