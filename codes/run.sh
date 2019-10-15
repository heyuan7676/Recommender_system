#!/bin/bash -l
#SBATCH --time 100:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --no-requeue

# =============================

cd /scratch1/battle-fs1/heyuan/MCSC_Proj

for tau in {2..5}
do
    echo $tau
    for lambda in {1..2}
    do
        echo $lambda
        sbatch run_admm.sh ${tau} ${lambda}
    done
done
