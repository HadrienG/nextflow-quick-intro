#!/usr/bin/env nextflow

params.input = "../data/reads_R1.fastq.gz"

input_ch = Channel.fromPath(params.input)

workflow {
    count_lines(input_ch)
    count_lines.out.view()    
}

process count_lines {
    input:
        path(reads)
    output:
        stdout
    script:
    """
    # Print file name
    printf '${reads}\\t'
    # Unzip file and count number of lines
    gunzip -c ${reads} | wc -l
    """

}
