# Data processing steps
Trimmed the adaptors in the fastq files using TrimGalore!
```
./trim_galore -a <adapter> --gzip --rrbs --length 15 --stringency 4 FILEINFO
```
