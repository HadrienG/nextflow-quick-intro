/* fastp: a ultra-fast FASTQ preprocessor 
homepage: https://github.com/OpenGene/fastp

input:
    tuple: sample name, list of reads in fastq(.gz) format
    bool: is the input single end reads or not
    int: mean quality for the trimming sliding window
    int: mean quality threshold for individual bases
    int: minimum length for keeping a sequence
output:
    tuple: sample name, list of reads in fastq.gz format
*/
process fastp {
    container "quay.io/biocontainers/fastp:0.23.2--h79da9fb_0"
    input:
        tuple val(prefix), path(reads)
        // val(trim)
        // val(filter)
        // val(len)
    output:
        tuple val(prefix), path("${prefix}_trimmed*.fastq.gz"), emit: reads
    script:
        """
        fastp \
            -w "${task.cpus}" \
            -q 30 \
            -l 50 \
            -M 30 \
            -i "${reads[0]}" -I "${reads[1]}" \
            -o "${prefix}_trimmed_R1.fastq.gz" -O "${prefix}_trimmed_R2.fastq.gz"
        """
}


