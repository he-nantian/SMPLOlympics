#!/bin/bash

#SBATCH --gres=gpu:4

module load apptainer/1.3.1
chmod +x ~/life/ubuntu_life.sandbox ./code/SMPLOlympics/scripts/run_penalty_kick.sh
apptainer exec --nv --fakeroot --writable ~/life/ubuntu_life.sandbox ./code/SMPLOlympics/scripts/run_penalty_kick.sh
