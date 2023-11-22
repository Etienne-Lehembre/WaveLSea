export OMP_SCHEDULE=dynamic,1
export OMP_NUM_THREADS=4

HOME=eval echo ~${USER}

for DIR in ../datasets/**/
do
  if [ "${DIR}"  != "../datasets/BCR-ABL/" ] ; then
    TMP=${DIR%/*}
    echo SGPEx_Converter -tu  ${DIR}"src/"${TMP##*/}"_graph_labels.txt" ${DIR}"src/"${TMP##*/}".fp" ${DIR}"data/"${TMP##*/}".lat";
    SGPEx_Converter -tu  ${DIR}"src/"${TMP##*/}"_graph_labels.txt" ${DIR}"src/"${TMP##*/}".fp" ${DIR}"data/"${TMP##*/}".lat"
    
    echo SGPEx_Clusterize -s ${DIR}"data/"${TMP##*/}".lat";
    SGPEx_Clusterize -s ${DIR}"data/"${TMP##*/}".lat"
    
    echo SGPEx_WRAcc -c ${DIR}"data/"${TMP##*/}"_SEC.lat";
    SGPEx_WRAcc -c ${DIR}"data/"${TMP##*/}"_SEC.lat"
    
    echo SGPEx_PAD -c ${DIR}"data/"${TMP##*/}"_SEC_WRAcc.lat";
    SGPEx_PAD -c ${DIR}"data/"${TMP##*/}"_SEC_WRAcc.lat"
    
    # Running WaveLSea with absolute oracle.
    
    echo SGPEx_WaveLSea -a ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_absolute-"  3 7 2 1 300 100;
    SGPEx_WaveLSea -a ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_absolute-"  3 7 2 1 300 100;
    
    python3  convergence-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_absolute_convergence.csv" ${DIR}"results/"${TMP##*/}"_trace_absolute-"*"convergence.csv"
    python3  heuristic-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_absolute_heuristic.csv" ${DIR}"results/"${TMP##*/}"_trace_absolute-"*"heuristic.csv"
    
    rm ${DIR}"results/"${TMP##*/}"_trace_absolute-"*"convergence.csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_absolute-"*"heuristic.csv"
    
    python3  compute-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_absolute.csv" ${DIR}"results/"${TMP##*/}"_trace_absolute-"*".csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_absolute-"*".csv"
    
    # Running WaveLSea with probabilistic oracle.
    
    echo SGPEx_WaveLSea -p ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_probabilistic-"  3 7 2 1 300 100;
    SGPEx_WaveLSea -p ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_probabilistic-"  3 7 2 1 300 100;
    
    python3  convergence-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_probabilistic_convergence.csv" ${DIR}"results/"${TMP##*/}"_trace_probabilistic-"*"convergence.csv"
    python3  heuristic-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_probabilistic_heuristic.csv" ${DIR}"results/"${TMP##*/}"_trace_probabilistic-"*"heuristic.csv"
    
    rm ${DIR}"results/"${TMP##*/}"_trace_probabilistic-"*"convergence.csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_probabilistic-"*"heuristic.csv"
    
    python3  compute-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_probabilistic.csv" ${DIR}"results/"${TMP##*/}"_trace_probabilistic-"*".csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_probabilistic-"*".csv"
    
    # Running WaveLSea with biased oracle.
    
    echo SGPEx_WaveLSea -b ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_biased-"  3 7 2 1 300 100;
    SGPEx_WaveLSea -b ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_biased-"  3 7 2 1 300 100;
    
    python3  convergence-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_biased_convergence.csv" ${DIR}"results/"${TMP##*/}"_trace_biased-"*"convergence.csv"
    python3  heuristic-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_biased_heuristic.csv" ${DIR}"results/"${TMP##*/}"_trace_biased-"*"heuristic.csv"
    
    rm ${DIR}"results/"${TMP##*/}"_trace_biased-"*"convergence.csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_biased-"*"heuristic.csv"
    
    python3  compute-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_biased.csv" ${DIR}"results/"${TMP##*/}"_trace_biased-"*".csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_biased-"*".csv"
    
    # Running WaveLSea with local oracle.
    
    echo SGPEx_WaveLSea -l ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_local-"  3 7 2 1 300 100;
    SGPEx_WaveLSea -l ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_local-"  3 7 2 1 300 100;
    
    python3  convergence-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_local_convergence.csv" ${DIR}"results/"${TMP##*/}"_trace_local-"*"convergence.csv"
    python3  heuristic-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_local_heuristic.csv" ${DIR}"results/"${TMP##*/}"_trace_local-"*"heuristic.csv"
    
    rm ${DIR}"results/"${TMP##*/}"_trace_local-"*"convergence.csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_local-"*"heuristic.csv"
    
    python3  compute-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_local.csv" ${DIR}"results/"${TMP##*/}"_trace_local-"*".csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_local-"*".csv"
    
    # Running WaveLSea with surprised oracle.
    
    echo SGPEx_WaveLSea -s ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_surprised-"  3 7 2 1 300 100;
    SGPEx_WaveLSea -s ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_surprised-"  3 7 2 1 300 100;
    
    python3  convergence-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_surprised_convergence.csv" ${DIR}"results/"${TMP##*/}"_trace_surprised-"*"convergence.csv"
    python3  heuristic-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_surprised_heuristic.csv" ${DIR}"results/"${TMP##*/}"_trace_surprised-"*"heuristic.csv"
    
    rm ${DIR}"results/"${TMP##*/}"_trace_surprised-"*"convergence.csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_surprised-"*"heuristic.csv"
    
    python3  compute-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_surprised.csv" ${DIR}"results/"${TMP##*/}"_trace_surprised-"*".csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_surprised-"*".csv"
    
    # Running WaveLSea with neighbor oracle.
    
    echo SGPEx_WaveLSea -n ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_neighbor-"  3 7 2 1 300 100;
    SGPEx_WaveLSea -n ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_neighbor-"  3 7 2 1 300 100;
    
    python3  convergence-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_neighbor_convergence.csv" ${DIR}"results/"${TMP##*/}"_trace_neighbor-"*"convergence.csv"
    python3  heuristic-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_neighbor_heuristic.csv" ${DIR}"results/"${TMP##*/}"_trace_neighbor-"*"heuristic.csv"
    
    rm ${DIR}"results/"${TMP##*/}"_trace_neighbor-"*"convergence.csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_neighbor-"*"heuristic.csv"
    
    python3  compute-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_neighbor.csv" ${DIR}"results/"${TMP##*/}"_trace_neighbor-"*".csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_neighbor-"*".csv"
  fi
  #-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  if [ "${DIR}"  = "../datasets/BCR-ABL/" ]; then
    TMP=${DIR%/*}
    echo /SGPEx_Converter  ${DIR}"src/ABL1_ChEMBL_MW_800_linux.sdf" ${DIR}"src/"*".txt" ${DIR}"data/"${TMP##*/}".lat";
    SGPEx_Converter  ${DIR}"src/ABL1_ChEMBL_MW_800_linux.sdf" ${DIR}"src/"*".txt" ${DIR}"data/"${TMP##*/}".lat";
    
    echo SGPEx_Clusterize -s ${DIR}"data/"${TMP##*/}".lat";
    SGPEx_Clusterize -s ${DIR}"data/"${TMP##*/}".lat"
    
    echo SGPEx_WRAcc -c ${DIR}"data/"${TMP##*/}"_SEC.lat";
    SGPEx_WRAcc -c ${DIR}"data/"${TMP##*/}"_SEC.lat"
    
    echo SGPEx_PAD -c ${DIR}"data/"${TMP##*/}"_SEC_WRAcc.lat";
    SGPEx_PAD -c ${DIR}"data/"${TMP##*/}"_SEC_WRAcc.lat"
    
    # Running WaveLSea with absolute oracle.
    
    echo SGPEx_WaveLSea -a ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_absolute-"  3 7 2 1 300 100;
    SGPEx_WaveLSea -a ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_absolute-"  3 7 2 1 300 100;
    
    python3  convergence-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_absolute_convergence.csv" ${DIR}"results/"${TMP##*/}"_trace_absolute-"*"convergence.csv"
    python3  heuristic-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_absolute_heuristic.csv" ${DIR}"results/"${TMP##*/}"_trace_absolute-"*"heuristic.csv"
    
    rm ${DIR}"results/"${TMP##*/}"_trace_absolute-"*"convergence.csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_absolute-"*"heuristic.csv"
    
    python3  compute-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_absolute.csv" ${DIR}"results/"${TMP##*/}"_trace_absolute-"*".csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_absolute-"*".csv"
    
    # Running WaveLSea with probabilistic oracle.
    
    echo SGPEx_WaveLSea -p ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_probabilistic-"  3 7 2 1 300 100;
    SGPEx_WaveLSea -p ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_probabilistic-"  3 7 2 1 300 100;
    
    python3  convergence-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_probabilistic_convergence.csv" ${DIR}"results/"${TMP##*/}"_trace_probabilistic-"*"convergence.csv"
    python3  heuristic-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_probabilistic_heuristic.csv" ${DIR}"results/"${TMP##*/}"_trace_probabilistic-"*"heuristic.csv"
    
    rm ${DIR}"results/"${TMP##*/}"_trace_probabilistic-"*"convergence.csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_probabilistic-"*"heuristic.csv"
    
    python3  compute-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_probabilistic.csv" ${DIR}"results/"${TMP##*/}"_trace_probabilistic-"*".csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_probabilistic-"*".csv"
    
    # Running WaveLSea with biased oracle.
    
    echo SGPEx_WaveLSea -b ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_biased-"  3 7 2 1 300 100;
    SGPEx_WaveLSea -b ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_biased-"  3 7 2 1 300 100;
    
    python3  convergence-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_biased_convergence.csv" ${DIR}"results/"${TMP##*/}"_trace_biased-"*"convergence.csv"
    python3  heuristic-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_biased_heuristic.csv" ${DIR}"results/"${TMP##*/}"_trace_biased-"*"heuristic.csv"
    
    rm ${DIR}"results/"${TMP##*/}"_trace_biased-"*"convergence.csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_biased-"*"heuristic.csv"
    
    python3  compute-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_biased.csv" ${DIR}"results/"${TMP##*/}"_trace_biased-"*".csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_biased-"*".csv"
    
    # Running WaveLSea with local oracle.
    
    echo SGPEx_WaveLSea -l ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_local-"  3 7 2 1 300 100;
    SGPEx_WaveLSea -l ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_local-"  3 7 2 1 300 100;
    
    python3  convergence-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_local_convergence.csv" ${DIR}"results/"${TMP##*/}"_trace_local-"*"convergence.csv"
    python3  heuristic-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_local_heuristic.csv" ${DIR}"results/"${TMP##*/}"_trace_local-"*"heuristic.csv"
    
    rm ${DIR}"results/"${TMP##*/}"_trace_local-"*"convergence.csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_local-"*"heuristic.csv"
    
    python3  compute-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_local.csv" ${DIR}"results/"${TMP##*/}"_trace_local-"*".csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_local-"*".csv"
    
    # Running WaveLSea with surprised oracle.
    
    echo SGPEx_WaveLSea -s ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_surprised-"  3 7 2 1 300 100;
    SGPEx_WaveLSea -s ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_surprised-"  3 7 2 1 300 100;
    
    python3  convergence-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_surprised_convergence.csv" ${DIR}"results/"${TMP##*/}"_trace_surprised-"*"convergence.csv"
    python3  heuristic-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_surprised_heuristic.csv" ${DIR}"results/"${TMP##*/}"_trace_surprised-"*"heuristic.csv"
    
    rm ${DIR}"results/"${TMP##*/}"_trace_surprised-"*"convergence.csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_surprised-"*"heuristic.csv"
    
    python3  compute-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_surprised.csv" ${DIR}"results/"${TMP##*/}"_trace_surprised-"*".csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_surprised-"*".csv"
    
    # Running WaveLSea with neighbor oracle.
    
    echo SGPEx_WaveLSea -n ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_neighbor-"  3 7 2 1 300 100;
    SGPEx_WaveLSea -n ${DIR}"data/"${TMP##*/}"_SEC_WRAcc_PAD.lat" ${DIR}"results/"${TMP##*/}"_trace_neighbor-"  3 7 2 1 300 100;
    
    python3  convergence-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_neighbor_convergence.csv" ${DIR}"results/"${TMP##*/}"_trace_neighbor-"*"convergence.csv"
    python3  heuristic-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_neighbor_heuristic.csv" ${DIR}"results/"${TMP##*/}"_trace_neighbor-"*"heuristic.csv"
    
    rm ${DIR}"results/"${TMP##*/}"_trace_neighbor-"*"convergence.csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_neighbor-"*"heuristic.csv"
    
    python3  compute-mean-csv.py ${DIR}"results/"${TMP##*/}"_trace_neighbor.csv" ${DIR}"results/"${TMP##*/}"_trace_neighbor-"*".csv"
    rm ${DIR}"results/"${TMP##*/}"_trace_neighbor-"*".csv"
  fi
  echo -e "\n";
done

