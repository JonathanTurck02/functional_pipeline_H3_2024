for forward in input_sample/*_R1.fastq.gz; do
    # Automatically find the matching reverse file
    reverse=${forward/_R1.fastq.gz/_R2.fastq.gz}

    # Extract the sample name (without the _R1.fastq.gz part)
    sample_name=$(basename ${forward} _R1.fastq.gz)

    # Run cutadapt with threading (-j for threads)
    cutadapt -u 10 -U 10 -o "trimmed/${sample_name}_R1_trimmed.fastq.gz" -p "trimmed/${sample_name}_R2_trimmed.fastq.gz" ${forward} ${reverse}

done