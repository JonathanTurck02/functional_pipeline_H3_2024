# functional_pipeline_H3_2024

## Setup
For mus Musculus obtain bowtie2 index buit from GRCm39.
```shell
wget https://genome-idx.s3.amazonaws.com/bt/GRCm39.zip

unzip GRCm39.zip
```
## Download
Download the script
```shell
wget https://raw.githubusercontent.com/JonathanTurck02/functional_pipeline_H3_2024/refs/heads/main/fp_wf_2.0.job
```

## Example Run
Run script on directory of paired end reads
```shell
sbatch fp_wf_2.0.job -i $INPUT_DIR
```
- this will use the GRCm39 as default and trim 20 bp from 5'