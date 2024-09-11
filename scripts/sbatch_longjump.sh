#!/bin/bash

#SBATCH --gres=gpu:4

module load apptainer/1.3.1
module load cuda/12.1
chmod +x ~/life/ubuntu_life.sandbox ./code/SMPLOlympics/scripts/run_longjump.sh
apptainer exec --nv --fakeroot --writable ~/life/ubuntu_life.sandbox ./code/SMPLOlympics/scripts/run_longjump.sh
