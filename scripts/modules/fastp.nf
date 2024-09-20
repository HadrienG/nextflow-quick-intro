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
        val(single_end)
        val(trim)
        val(filter)
        val(len)
    output:
        tuple val(prefix), path("${prefix}_trimmed*.fastq.gz"), emit: reads
    script:
        """
        fastp \
            ${extra_params} \
            -w "${task.cpus}" \
            -q "${filter}" \
            -l "${len}" \
            -M "${trim}" \
            -i "${reads[0]}" -I "${reads[1]}" \
            -o "${prefix}_trimmed_R1.fastq.gz" -O "${prefix}_trimmed_R2.fastq.gz"
        """
}


