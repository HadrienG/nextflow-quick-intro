#!/usr/bin/env nextflow

process foo {
    input:
        path(reads)
    output:
        path("${reads.baseName}.foo.txt"),
    script:
    """
    echo "Hello from foo"
    """

}
