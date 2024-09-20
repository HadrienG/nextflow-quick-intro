/* spades: a small genomes assembler
homepage: http://cab.spbu.ru/software/spades/

input:
    tuple: sample name, list of reads in fastq(.gz) format
output:
    tuple: sample name, assembly in fasta format
*/
process spades {
    container "quay.io/biocontainers/spades:3.15.5--h95f258a_1"
    input:
        tuple val(prefix), path(reads)
    output:
        tuple val(prefix), path("${prefix}_assembly.fasta"), emit: assembly
    script:
        def mem = "${task.memory.toString().replaceAll(/[\sGB]/,'')}"
        mem = Integer.parseInt(mem)
        mem = Math.round(mem * 0.9 )
        // set parameters depending on paired or single
        def paired_end = "${reads instanceof List}".toBoolean()
        def input_reads = paired_end ? "-1 \"${reads[0]}\" -2 \"${reads[1]}\"" : "-s \"${reads}\" --careful"
        """
        spades.py \
            --threads "${task.cpus}" \
            --mem "${mem}" \
            -k 21,33,55,77,99,127 \
            $input_reads \
            -o assembly

        mv assembly/scaffolds.fasta "${prefix}_assembly.fasta"
        # the spades docker seems to have permission issues
        # sometimes the folder can't be remove outside of docker
        rm -r assembly
        """
}

