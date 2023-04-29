domains="data/targets.txt"
param_spider="ParamSpider/paramspider.py"
ref_params="rsults/reflected-parameters.txt"
n_out="results/nuclei-output-xss.txt"
n_temp="templates/xss/xss-ref.yaml"

# removing the past processes
rm $ref_params
rm $n_out

# Now we are ready to go 
while read domain ; do 
    python3 "$param_spider" -d $domain | kxss > "$ref_params"
    echo "$doman" | gau | gf xss | nuclei -t "$n_temp" -o "$n_out"
done < $domains