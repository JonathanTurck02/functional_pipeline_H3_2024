#!/bin/bash
#SBATCH --export=NONE               # do not export current env to the job
#SBATCH --job-name=deplete_host_bt2 # job name
#SBATCH --time=02:00:00             # max job run time dd-hh:mm:ss
#SBATCH --ntasks-per-node=1         # tasks (commands) per compute node
#SBATCH --cpus-per-task=24          # CPUs (threads) per command
#SBATCH --mem=360G                  # total memory per node
#SBATCH --output=stdout.%x.%j       # save stdout to file
#SBATCH --error=stderr.%x.%j        # save stderr to file

# lets deplete some host reads using bt2

input_dir="trimmed"
host_db="bt2_index/GRCm39/GRCm39"

module load GCC/12.2.0
module load Bowtie2/2.5.1

mkdir -p out_bt2_pt2

for forward in trimmed/*_R1_trimmed.fastq.gz; do
    # Automatically find the matching reverse file
    reverse=${forward/_R1_trimmed.fastq.gz/_R2_trimmed.fastq.gz}

    # Extract the sample name (without the _R1_trimmed.fastq.gz part)
    sample_name=$(basename ${forward} _R1_trimmed.fastq.gz)

    # Run Bowtie2 with the correct input and output
    bowtie2 -x bt2_index/GRCm39/GRCm39 -1 ${forward} -2 ${reverse} --un-conc "out_bt2/${sample_name}_depletedHost_reads.fastq" -S "out_bt2/${sample_name}_Host_reads.sam"

    # Wait for Bowtie2 to finish before moving to the next sample
    wait
done


module purge