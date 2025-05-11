import sys

def count_kmers(sequence, k):
    """
    Count k-mers in a given sequence.
    :param sequence: DNA sequence (str)
    :param k: Length of the k-mer (int)
    :return: Number of k-mers (int)
    """
    return max(0, len(sequence) - k + 1)

def process_fasta(file_name, k, l):
    """
    Process a FASTA file to count the k-mers associated with each header.
    :param file_name: FASTA file name (str)
    :param k: Length of the k-mer (int)
    :param l: Length of contigs considered; zero for any length (int)
    """
    header_kmer_count = {}

    try:
        with open(file_name, 'r') as fasta_file:
            current_header = ''
            for line in fasta_file:
                line = line.strip()
                if line.startswith('>'):  # It's a header line
                    current_header = line[1:]  # Remove '>' from header
                    if current_header not in header_kmer_count:
                        header_kmer_count[current_header] = 0
                else:
                    # Count and add the k-mers of the current sequence to the current header's count
                    if l == 0 or len(line) == l:
                        if k == 0:
                            header_kmer_count[current_header] += 1
                        else:
                            header_kmer_count[current_header] += count_kmers(line, k)
    except FileNotFoundError:
        print(f"Error: The file '{file_name}' was not found.")
        return
    except Exception as e:
        print(f"An error occurred: {e}")
        return

    # Output the results
    for header, count in header_kmer_count.items():
        print(f"{header}:{count}")

if __name__ == "__main__":
    if len(sys.argv) != 3 and len(sys.argv) != 4:
        print("Usage: python script.py <FASTA file name> <k-mer length> [contig length]")
    else:
        file_name = sys.argv[1]
        k = int(sys.argv[2])
        l = 0
        if len(sys.argv) > 3:
                l = int(sys.argv[3])
        process_fasta(file_name, k, l)
