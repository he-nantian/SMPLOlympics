#!/bin/bash

#SBATCH --gres=gpu:2

module load apptainer/1.3.1
module load cuda/12.1
chmod +x ~/life/ubuntu_life.sandbox ./code/SMPLOlympics/scripts/run_tabletennis.sh
apptainer exec --nv --fakeroot --writable ~/life/ubuntu_life.sandbox ./code/SMPLOlympics/scripts/run_tabletennis.sh
