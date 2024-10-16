#!/bin/bash
#SBATCH --export=NONE               # do not export current env to the job
#SBATCH --job-name=humannqc_trime   # job name
#SBATCH --time=02:00:00             # max job run time dd-hh:mm:ss
#SBATCH --ntasks-per-node=1         # tasks (commands) per compute node
#SBATCH --cpus-per-task=24          # CPUs (threads) per command
#SBATCH --mem=360G                  # total memory per node
#SBATCH --output=stdout.%x.%j       # save stdout to file
#SBATCH --error=stderr.%x.%j        # save stderr to file


# working with a pair of seqeunces from deepa's data

# TODO run fastqc
# TODO trim if necessary
# OPTIONAL Use TRF
# TODO deplete host reads with bt2

#### FASTQC on hprc ####

# the input dataset contains to paired end sequences (4 fastqs total)
input_dir="input_sample"

############

module load FastQC/0.12.1-Java-11

mkdir -p out_fastqc

for x in ${input_dir}/*.fastq.gz ; do fastqc -o out_fastqc "$x" ; done

echo "Initial FASTQC reports finished"

##### Generate multiqc report ####
module load GCC/12.2.0  OpenMPI/4.1.4
module load MultiQC/1.14

mkdir -p out_fastqc/out_multiqc

multiqc out_fastqc/ --outdir out_fastqc/out_multiqc

module purge

echo "Initial MULTIQC report finished"

######################

module load GCCcore/11.3.0
module load cutadapt/4.2

mkdir -p trimmed

for forward in input_sample/*_R1.fastq.gz; do
    # Automatically find the matching reverse file
    reverse=${forward/_R1.fastq.gz/_R2.fastq.gz}

    # Extract the sample name (without the _R1.fastq.gz part)
    sample_name=$(basename ${forward} _R1.fastq.gz)

    # Run cutadapt with threading (-j for threads)
    cutadapt -j ${SLURM_CPUS_PER_TASK} -u 20 -U 20 -o "trimmed/${sample_name}_R1_trimmed.fastq.gz" -p "trimmed/${sample_name}_R2_trimmed.fastq.gz" ${forward} ${reverse}

done

module purge

echo "Trimming Complete"

################

module load FastQC/0.12.1-Java-11

mkdir -p out_fastqc_trimmed

for x in trimmed/* ; do fastqc -o out_fastqc_trimmed "$x" ; done

module load GCC/12.2.0  OpenMPI/4.1.4
module load MultiQC/1.14

mkdir -p out_fastqc_trimmed/out_multiqc_trimmed

multiqc out_fastqc_trimmed/ --outdir out_fastqc_trimmed/out_multiqc_trimmed

module purge

echo "QC and Trim Complete"