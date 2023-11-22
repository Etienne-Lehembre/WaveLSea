# --- Descrption of the SGPEx debian package  ----------------------------------

Sub-Graph Pattern Explorer (SGPEx) is a program treating data from Norns and
TUData. It builds a Partially Ordered Graph (POG) based on the given sub-graph
patterns and the sub-graph partial order. Once the POG is constructed (with
SGPEx_Converter) you can build equivalence classes by using SGPEx Clusterize if
you want to minimize redondant informations. Then you can use the .lat produced
to compute quality measures (GR, WRAcc, ChiSquare, Confidence). After adding a
quality measure to the structure you can either run the Outstanding Pattern
Selector (OPS) or the Wave k-Top d-Random Family Search (WaveLSea). Be aware 
that the WTRFS ALgorithm only runs with equivalence classes.


# --- Installation of openbabel 3.1.1 and SGPEx packages on ubuntu 20.04  ------

## Openbabel 3.1.1

Before installing this openbabel package, you have to remove the previous packages:

* openbabel (3.0.0)
* libopenbabel6
* libopenbabel-dev

We remove them sequentially with apt.

```
$ sudo apt remove --purge openbabel
$ sudo apt remove --purge libopenbabel6
$ sudo apt remove --purge libopenbabel-dev
```

Unzip the archive.

```
$ tar xvf openbabel-ubuntu-20.04.tar.bz2
```

To install the package, you can use gdebi.

If it is not installed, we install it.

```
$ sudo apt-get install gdebi

$ sudo gdebi openbabel_3.1.1-1_amd64.deb
```

## SGPEx

The package dependencies are as follows:

libboost-serialization1.71.0, libc6 (>= 2.29), libgcc-s1 (>= 3.0), libgomp1 (>= 6), libstdc++6 (>= 5.2), openbabel (>= 3.1.1)


# ---  Excecutables description  -----------------------------------------------


SGPEx_Add adds data from source pharmacophores_src.txt having activities in
receptor_molecules_src.sdf with receptor computed with threshold acitvity cut 
to my_archive.lat.
  - input: [-receptor=receptor] [-activity-cut=threshold] receptor_molecules_src.sdf ([list] pharmacophores_src.txt) my_archive.lat
  - output: my_archive.lat
  
     
SGPEx_ChiSquare takes in input a context Partial Ordered Graph (POG) with Norns
data if no option are specified. It computes the ChiSquare for each receptor
contained in the POG.
  - input: [-c] my_archive.lat
  - output: my_archive_ChiSquare.lat
  - option: -c for clustered data
  - default: compute ChiSquare on the context POG
  
  
SGPEx_CLusterize takes a Partial Ordered Graph in input and clusterize it with
the specified Equivalence Classes. If no option is specified, SEC Equivalence
CLasses are created.
  - input: [-g ; -d ; -s] my_archive.lat
  - output: my_archive[_GEC;_DEC;_SEC].lat
  - option: -g for GEC, -d for DEC, -s for SEC
  - default: creates SEC equivalence classes


SGPEx_Confidence takes in input a context Partial Ordered Graph (POG) with
Norns data if no option are specified. It computes the Confidence for each
receptor contained in the POG.
  - input: [-c] my_archive.lat
  - output: my_archive_Confidence.lat
  - option: -c for clustered data
  - default: computes confidence on the context POG


SGPEx_Converter convert sub-graphs into a Partial Ordered Graph. Default data
is from Norns, receptor, activity-cut, receptor_molecules_src.sdf, and
pharmacophores_src.txt is needed if using Norns data. Creates data from source
.txt or .fp having activities in .sdf or .txt with receptor into my_archive.lat.
  - input: [-tu] [-receptor=receptor] [-activity-cut=threshold] [graph_labels.txt ; receptor_molecules_src.sdf] [sub_graphs_src.fp ; ([list] pharmacophores_src.txt)] my_archive.lat
  - output: my_archive.lat
  - option: -tu if the input is from TUData with graph_labels.txt and src.fp.
  - default: convert Norns pharmacophores
                
                
SGPEx_GR takes in input a context Partial Ordered Graph (POG) with Norns data
if no option are specified. It computes the Growth Rate, Normalized Growth Rate
and Negative Growth rate for each receptor contained in the POG.
  - input: [-c] my_archive.lat
  - output: my_archive_GRClassic.lat, my_archive_InactiveGR.lat, and my_archive_NormalizedGR.lat
  - option: -c for clustered data
  - default: computes Growth Rate, Inactive Growth Rate and Normalized Growth Rate on the context POG


SGPEx_PAD takes in input a context Partial Ordered Graph (POG) with Norns data
if no option are specified. It applies the Outstanding Pattern Selector (or
Pharmacophore Activity Delta) for each receptor contained in the POG for the
applied quality measure.
  - input: [-c ; -tu] my_archive.lat
  - output: my_archive_PAD.lat or my_archive_OPS.lat
  - option: -c for clustered data ; -tu for TUData
  - default: applies OPS to Norns Pharmacophores


SGPEx_ToCSV prints the Partial Ordered Graph (POG) through three CSVs. One for
the vertices data, one to map the edges between the vertices, and one with a
summary of the POG data.
  - input: [-c, -tu] my_archive.lat
  - output: my_archive_vertices.csv my_archive_edges.csv my_archive_infos.csv
  - options: -c if my_archive.lat contains clustered nodes ; -tu if my_archive.lat contains TUData data.
  - default: process a context POG and Norns data.


SGPEx_WRAcc takes in input a context Partial Ordered Graph (POG) with Norns
data if no option are specified. It computes the Weighted Relative Accuracy
for each receptor contained in the POG.
  - input: [-c] molecules.sdf my_archive.lat
  - output: my_archive_WRAcc.lat
  - option: -c for clustered data
  - default: computes WRAcc on a context POG


SGPEx_WaveLSea takes in input a Clustered Partial Ordered Graph (POG) with Norns
data. It applies the Wave k-Top d-Random Family Search for one receptor
contained in the POG for the applied quality measure.
  - input: [-a;-p;-b;-l;-s;-n] my_archive.lat trace.csv first_order last_order k d number_of_samples
  - output: my_archive_WaveLSea.lat
  - option: [-a: for absolute oracle] ; [-p for probabilistic oracle] ; [-b for biased oracle] ; [-l for local oracle] ; [-s for surprised oracle] ; [-n for neighbor oracle]
    

SGPEx_MCMC takes in input a Clustered Partial Ordered Graph (POG) with Norns
data. It applies a Monte Carlo Markovian Chain Search for one receptor
contained in the POG for the applied quality measure.
  - input: [-a;-p;-b;-l;-s;-n] my_archive.lat trace.csv first_order last_order number_of_samples
  - output: my_archive_WTRFS.lat
  - option: [-a: for absolute oracle] ; [-p for probabilistic oracle] ; [-b for biased oracle] ; [-l for local oracle] ; [-s for surprised oracle] ; [-n for neighbor oracle]


 
# ---  Usefull command lines  --------------------------------------------------

Needed to configure multi-thread:
- export OMP_SCHEDULE=dynamic,1
- export OMP_NUM_THREADS=4

# --- Extracting results  ------------------------------------------------------
Run the scripts in the eponym directory in the following order:
1. *initialise.sh*
2. *data_to_results.sh*
3. *results_to_visualisations.sh*

The *clean.sh* script **erases** the following directories: data, results, and visualisation.
