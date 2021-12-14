#!/bin/bash
#SBATCH --time=03:10:00
#SBATCH --partition=regular
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=snevo_simulation
#SBATCH --cpus-per-task=8
#SBATCH --array=1-n_array
#SBATCH --output=/home/p284074/patho-move-evol/data/output/snevo_output_%a.log
#SBATCH --mem=500

pwd
ml load R/4.1.0-foss-2021a
cd patho-move-evol
echo "now in" 
pwd
Rscript some rscript here ${SLURM_ARRAY_TASK_ID}
