HOME=eval echo ~${USER}

for DIR in ../datasets/**/
do
  TMP=${DIR%/*}
  
  FILES=($(ls ${DIR}"results/" | grep -v 'convergence' | grep -v 'heuristic' | grep '.csv'))
  Rscript labels_visualisation.R ${FILES[@]/#/${DIR}"results/"} ${DIR}"visualisations/"${TMP##*/}; # --- ${ARRAY[@]/#/prefix_} ---
  
  FILES=($(ls ${DIR}"results/" | grep 'heuristic' | grep '.csv'))
  Rscript heuristic_visualisation.R ${FILES[@]/#/${DIR}"results/"} ${DIR}"visualisations/"${TMP##*/};
  
  echo -e "\n";
done

