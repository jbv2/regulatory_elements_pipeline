#!/bin/bash

find -L . \
	-type f \
	-name "*.tsv.gz" \
	-o -name "*.tsv" \
| sed "s#.tsv.gz#.filtered.tsv#" \
| xargs mk $@
