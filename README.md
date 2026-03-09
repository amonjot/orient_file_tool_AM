
# **Orient reads from Genoscope data**

[![HTTPS](https://img.shields.io/badge/https://-www.embl.org-9d161b?logo=hackthebox&logoColor=white)](https://www.embl.org)
[![HTTPS](https://img.shields.io/badge/https://-biocean5d.org-941751?logo=hackthebox&logoColor=white)](https://biocean5d.org)
![Static Badge](https://img.shields.io/badge/Code-R-8A2BE2)
[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)

**This is a script to orient reads from Genoscope data (with R1 and R2 in both forwrd and reverse files)**


## **Repository structure:**

        orient_file_tool_AM
        ├── README.md
        ├── rawdata (Here put your rawdata)
        │   ├── SAMEA118106237_clean_R1.fastq.gz (data test from Paleocore project)
        │   ├── SAMEA118106237_clean_R2.fastq.gz (data test from Paleocore project)
        │   ├── SAMEA118106263_clean_R1.fastq.gz (data test from Paleocore project)
        │   └── SAMEA118106263_clean_R2.fastq.gz (data test from Paleocore project)
        └── script
            └── Orient_reads_parallel.sh


## **Dependencies**

    * cutadapt
    * parallel (if you want to parallelize the job)


## **To launch the script**

Before launch, change the primer sequences and the output file in the Orient_reads_parallel.sh script!

FWD="your_forward_primer_sequence"

REV="your_reverse_primer_sequence"

OUTPUT="your_output"

```
# Launch the script using parallel
parallel -j 6 -k 'bash script/Orient_reads_parallel.sh {}' ::: rawdata/*_clean_R1.fastq.gz

# Launch the script in a for loop
for forward in $(ls rawdata/ | grep "_clean_R1.fastq.gz")
do
bash script/Orient_reads_parallel.sh rawdata/${forward}
done

# After launching the job, you can remove the temporary file
rm -r temp/ 
```

## **REFERENCES**

1. Martin M. Cutadapt removes adapter sequences from high-throughput sequencing reads. EMBnet j. 2011; 17(1):10. doi: 10.14806/ej.17.1.200

## **CONTACT**

<div itemscope itemtype="https://schema.org/Person"><a itemprop="sameAs" content="https://orcid.org/0000-0002-6978-4785" href="https://orcid.org/0000-0002-6978-4785" target="orcid.widget" rel="noopener noreferrer" style="vertical-align:top;"><img src="https://orcid.org/sites/default/files/images/orcid_16x16.png" style="width:1em;margin-right:.5em;" alt="ORCID iD icon"> Arthur Monjot</a></div>
Arthur.Monjot.pro[at]gmail.com
