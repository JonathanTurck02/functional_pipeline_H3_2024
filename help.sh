


for forward in trimmed/*_R1_trimmed.fastq.gz; do
    # Automatically find the matching reverse file
    reverse=${forward/_R1_trimmed.fastq.gz/_R2_trimmed.fastq.gz}

    # Extract the sample name (without the _R1.fastq.gz part)
    sample_name=$(basename ${forward} _R1_trimmed.fastq.gz)

    bowtie2 -x bt2_index/GRCm39/GRCm39 -1 ${forward} -2 ${reverse} --un-conc "out_bt2/${sample_name}_depletedHost_reads.fastq.gz" -S "out_bt2/${sample_name}_Host_reads.sam"

done


bowtie2 -x /scratch/data/bio/genome_indexes/ncbi/Mus_musculus/bowtie2 -1 trimmed/MICE_SEQ01_R1_trimmed.fastq.gz -2 trimmed/MICE_SEQ01_R2_trimmed.fastq.gz} --un-conc "out_bt2/01_depletedHost_reads.fastq.gz" -S "out_bt2/01_Host_reads.sam"
bowtie2 -x mm10/mm10 -1 trimmed/MICE_SEQ01_R1_trimmed.fastq.gz -2 trimmed/MICE_SEQ01_R2_trimmed.fastq.gz} --un-conc "out_bt2/01_depletedHost_reads.fastq.gz" -S "out_bt2/01_Host_reads.sam"

bowtie2 -x bt2_index/GRCm39/GRCm39 -1 trimmed/MICE_SEQ01_R1_trimmed.fastq -2 trimmed/MICE_SEQ01_R2_trimmed.fastq --un-conc "out_bt2/01_depletedHost_reads.fastq" -S "out_bt2/01_Host_reads.sam"


module load GCC/11.3.0 Bowtie2/2.4.5
