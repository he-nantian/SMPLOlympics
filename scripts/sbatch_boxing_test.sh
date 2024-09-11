#!/bin/bash

#SBATCH --gres=gpu:4

module load cuda/12.1
module load apptainer/1.3.1
chmod +x ./code/SMPLOlympics/scripts/run_boxing_test.sh
apptainer exec --nv --fakeroot --writable ~/life/ubuntu_life.sandbox ./code/SMPLOlympics/scripts/run_boxing_test.sh
