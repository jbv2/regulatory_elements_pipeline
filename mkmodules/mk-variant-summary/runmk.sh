#!/bin/bash

find -L . \
        -type f \
        -name "*.filtered.tsv" \
        ! -name "*.summary.tsv" \
| sed "s#.tsv#.summary.tsv#" \
| xargs mk $@
