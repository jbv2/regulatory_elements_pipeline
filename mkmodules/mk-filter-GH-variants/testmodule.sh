#!/bin/#!/usr/bin/env bash
# borrar resultados de prueba anterior
rm -fr test/results/
# Crear un test/results vacío
mkdir -p test/results
bash runmk.sh && mv test/data/*.filtered.tsv test/results/ \
 && echo "module test successful"
