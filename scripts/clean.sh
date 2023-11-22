ROOT=$(pwd)

for DIR in ../datasets/**
do
  echo "Cleaning: "$(realpath ${DIR});
  cd $(realpath ${DIR})
  rm -r data
  rm -r results
  rm -r visualisations
  cd ${ROOT}
done

