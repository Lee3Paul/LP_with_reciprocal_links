# Source codes for a submitted manuscript
Codes for IRW- and DRW- indices proposed in our manuscript "Link prediction in directed networks utilizing the role of reciprocal links", submitted to "IEEE Access".
See the manuscript for more details of the algorithms. NOTICE that: 
1) RUN "./main.m" to utilize all link prediction methods in eight networks. Results are saved as "temp_results.mat" and "temp_results_ratio.mat". The latter contains all performances under different partition ratios. 
2) RUN "./analysis/Calc_Zscore.m" to calculate the Z-scores of original network and null models. The null models are generated maintaining the number of reciprocal links, as described in our manuscript. 
3) All datasets we use for empirical test and validation are downloaded from "http://konect.uni-koblenz.de/networks/".

The codes are also uploaded to CodeOcean for reproducible validation, with the provisional DOI: 10.24433/CO.3576288.v1
