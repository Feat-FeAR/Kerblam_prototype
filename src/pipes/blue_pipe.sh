#!/bin/bash

#? basic pipeline with BLUE dots

# kerblam runs pipelines from the project root
Rscript "./src/getStats.R" \
	"./data/in/Roughness Adhesion Replicates.txt" \
	"./data/out/" \
	"blue"
