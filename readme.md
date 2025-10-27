# 🧠 Dynamic Brain Network Modeling Pipeline

This repository presents a complete workflow for **large-scale brain network modeling** based on **BOLD signals**.
 The pipeline covers preprocessing, optimal frequency-band selection, dynamic mean-field (DMF) simulations, effective connectivity (EC) optimization, network-level analysis, and virtual stimulation experiments.

------

## 🧩 Input Data

The input is a **BOLD signal** matrix with dimensions:
 `timepoints × brain areas × subjects`.

------

## 🌳 a_data Preprocessing

**Goal:** preprocess raw BOLD signals and compute functional connectivity (FC) matrices.

- **`cell_bold_p.m`**
   Loads the BOLD signals of three subject groups and organizes them into a cell array.
   Each cell corresponds to one subject’s matrix of `brain areas × timepoints`.
- **`fc_cal.m`**
   Calculates the functional connectivity (FC) matrix for each subject.

------

## 🌳 b_best Band

**Goal:** determine the optimal frequency-band combination for dynamic brain state clustering.

- **`traverse_fre_city.m`**
   Traverses all possible frequency-band combinations and performs LEiDA clustering using **cityblock (Manhattan)** distance.
- **`findBestBand.m`**
   Identifies the optimal frequency band combination by selecting the one that maximizes the PMS difference between patient and control groups.
- **`recalBestBand.m`**
   Recomputes the PMS clustering using the optimal band combination and saves the result as `bestRes.mat`.

------

## 🌳 c_iter0And1000

**Goal:** perform DMF model simulations and iterative optimization of the effective connectivity matrix.

> **Note:** *Prisma* and *Trio* refer to different acquisition platforms with different TR values.
>  The example below uses **TRIO-HC** data.

- **`T_sim_hc0102.m`**
   Loads `bestRes.mat` along with the HC structural (SC) and functional (FC) matrices.
   Searches for the optimal global coupling parameter **G** within a defined range.
   The optimal G is chosen where the **FCCORR** curve shows an inverted-U shape and the **KLD** curve shows a U shape, selecting the minimum KLD point.
- **`T_sim_hc_iter200_0102.m`**
   Performs **1000 iterations** of EC matrix optimization using the optimal G value.

------

## 🌳 d_bestEcAnalysis

**Goal:** identify and analyze the best effective connectivity (EC) matrices across subject groups.

- **`findBestEc.m`**
   Loads all iteration results and selects the EC with the smallest empirical–simulated FC distance under a given KLD threshold.
- **`analysis_network_sparGroup3.m`**
   Calculates eigenvector centrality (EVC) at multiple sparsity levels and extracts the top 10 nodes for each group.
- **`plotEVCnodes.m`**
   Converts EVC results into `.node` files for visualization in **BrainNet Viewer**.
- **`starMotifvsRandom.m`**, **`mulNodesStar345.m`**, and **`mulNodesStar345NetAndLobe.m`**
   Analyze the statistical significance and anatomical distribution (network/lobe level) of 3-, 4-, and 5-node star motifs.
- **`MotifTrio0818.m`**
   Visualizes motif structures and group-level differences.

------

## 🌳 e_fcAndScale

**Goal:** compute network-level metrics and infer pathological patterns.

- **`calFcCCandEloc.m`**
   Calculates network metrics such as clustering coefficient (CC) and local efficiency (Eloc).
- **`plot_subarea_eloc_c.c`** and **`plot_subarea_global_meanss.m`**
   Aggregate and visualize network properties across brain lobes or functional networks.
- **`groupIndexVisualize.m`**
   Visualizes group-wise differences in network metrics.
- **`netPropertScale.m`**
   Computes correlations between network metrics and brain lobe/network scales.
- **`pathology0821.m`**
   Visualizes pathological alterations in network connectivity.

------

## 🌳 f_stiResAnalysis

**Goal:** perform virtual stimulation experiments and evaluate the modulation of negative ECs.

> Example: **TRIO-MCI** group.

- **`GSP_Laplacian.m`**
   Computes the **Structural Decoupling Index (SDI)** based on negative EC values for each group.
- **`mci_stimulus_allfunction.m`**
   Executes eight different virtual stimulation strategies, integrates pathological data, and analyzes simulated outcomes.

------

## 🌳 z_allSubFunctions

Contains all helper and sub-functions used throughout the entire pipeline.



## ⚙️ Environment Requirements

- MATLAB R2022b or later
- SPM12 toolbox
- BrainNet Viewer 1.7 or later
- Statistics and Machine Learning Toolbox (for clustering, correlation, etc.)