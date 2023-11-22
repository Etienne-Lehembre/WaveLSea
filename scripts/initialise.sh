ROOT=$(pwd)

for DIR in ../datasets/**
do
  echo "Initialising: "$(realpath ${DIR});
  cd $(realpath ${DIR})
  mkdir data
  mkdir results
  mkdir visualisations
  cd ${ROOT}
done
