#!/usr/bin/env nextflow

include { fastp } from './modules/fastp.nf'
include { amrfinder } from './modules/amrfinder.nf'
include { spades } from './modules/assembly.nf'

params.input = "../data/reads_R{1,2}.fastq.gz"

workflow {
    reads = Channel.fromFilePairs(params.input)
    fastp(reads)
    spades(fastp.out.reads)
    amrfinder(spades.out.assembly)
}