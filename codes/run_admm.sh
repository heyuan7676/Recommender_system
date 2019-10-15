#!/bin/bash -l
#SBATCH --time 100:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --no-requeue

# =============================

cd /scratch1/battle-fs1/heyuan/MCSC_Proj


tau="$1"
lambda="$2"
fn=Prediction_error_tau${tau}_lambda${lambda}

matlab -r "run_admm('$tau', '$lambda', '$fn'); exit;"
