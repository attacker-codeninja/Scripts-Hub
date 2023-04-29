#!/bin/bash

# configure variables
Data_dir="data"
Results_dir="results"
Templates_dir="templates"
targets="data/targets.txt"
hosts="data/hosts.txt"
lfi="results/lfi.txt"
flags="-c 50 -nh -retries 2"

# create input and output directories if they don't exist
if [ ! -d "$Data_dir" ]; then
    mkdir "$Data_dir"
fi

if [ ! -d "$Results_dir" ]; then
    mkdir "$Results_dir"
fi

if [ ! -d "$Templates_dir" ]; then
    mkdir "$Templates_dir"
fi

# remove previous results files
rm -f "$hosts"
rm -f "$lfi"

echo "Getting Live Hosts from targets-domains..."
# extract URLs from the websites using httpx
cat "$targets" | httpx -silent -threads 50 -o "$hosts"

echo "Filtering LFI URLs..."
# filter URLs that may be vulnerable to LFI using gf
cat "$hosts" | gau | gf lfi > "$lfi"

if [ -s "$lfi" ]; then
    echo "Starting LFI scanning..."
    # perform LFI scanning using nuclei
    nuclei -l "$lfi" -t "$Templates_dir/lfi/" $flags
else
    echo "No LFI URLs found."
fi