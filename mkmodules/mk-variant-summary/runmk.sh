#!/bin/bash

find -L . \
        -type f \
        -name "*.filtered.tsv" \
        -o -name "*.summary.tsv" \
| sed "s#.tsv#.summary.tsv#" \
| xargs mk $@
