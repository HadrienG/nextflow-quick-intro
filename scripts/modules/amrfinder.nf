/* amrfinder: finds antimicrobial resistance
homepage: https://github.com/ncbi/amr/wiki

input:
    tuple: sample name, assembly in fasta format, amrfinder database
output:
    tuple: sample name, path to amrfinder output directory
*/
process amrfinder {
    container "quay.io/biocontainers/ncbi-amrfinderplus:3.12.8--h283d18e_0"
    input:
        tuple val(prefix), path(assembly), path(database)
    output:
        tuple val(prefix), path("${prefix}_amr/")
    script:
        """
        mkdir -p ${prefix}_amr
        amrfinder \
            --threads ${task.cpus} \
            --plus \
            --name ${prefix} \
            --database ${database} \
            --nucleotide ${assembly} \
            -o ${prefix}_amr/${prefix}_amr.tsv
        """                                 
}