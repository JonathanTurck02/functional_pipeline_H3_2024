#!/bin/bash
#SBATCH --export=NONE               # do not export current env to the job
#SBATCH --job-name=single_deplete   # job name
#SBATCH --time=02:00:00             # max job run time dd-hh:mm:ss
#SBATCH --ntasks-per-node=1         # tasks (commands) per compute node
#SBATCH --cpus-per-task=24          # CPUs (threads) per command
#SBATCH --mem=360G                  # total memory per node
#SBATCH --output=stdout.%x.%j       # save stdout to file
#SBATCH --error=stderr.%x.%j        # save stderr to file

module load GCC/12.2.0
module load Bowtie2/2.5.1


bowtie2 -x bt2_index/GRCm39/GRCm39 -1 trimmed/MICE_SEQ01_R1_trimmed.fastq.gz -2 trimmed/MICE_SEQ01_R2_trimmed.fastq.gz --un-conc "out_bt2/SEQ01_depletedHost_reads.fastq.gz" -S "out_bt2/SEQ01_Host_reads.sam"

ACAGGTGAAAAGCAATATTCAGTTAAAACACAGTAACTATGTGGCTTTCAGCCACTTTCATGGCTGTGCCGTGAAT
ACAGGTGAAAAGCAATATTCAGTTAAAACACAGTAACTATGTGGCTTTCAGCCACTTTCATGGCTGTGCCGTGAAT
