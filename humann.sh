#!/bin/bash
#SBATCH --export=NONE               # do not export current env to the job
#SBATCH --job-name=humann3_seq01    # job name
#SBATCH --time=05:00:00             # max job run time dd-hh:mm:ss
#SBATCH --ntasks-per-node=1         # tasks (commands) per compute node
#SBATCH --cpus-per-task=24          # CPUs (threads) per command
#SBATCH --mem=360G                  # total memory per node
#SBATCH --output=stdout.%x.%j       # save stdout to file
#SBATCH --error=stderr.%x.%j        # save stderr to file

module load GCC/11.2.0  OpenMPI/4.1.1
module load HUMAnN/3.8



humann --input SEQ01_cb.fastq --output out_hummann --threads ${SLURM_CPUS_PER_TASK}