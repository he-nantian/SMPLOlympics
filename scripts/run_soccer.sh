#!/bin/bash

source ~/.bashrc

cd /root/code/SMPLOlympics

wandb login de8f6c767be345f0647422f38d4ff9d2c34a1c61

echo "Start running codes..."

python phc/hello_world.py

# 1v1
export OMP_NUM_THREADS=1
python phc/run_hydra.py project_name=SMPLOlympics num_agents=2 learning=no_amp_z exp_name=soccer_pulse env=env_amp_z env.num_envs=1024 \
    env.task=HumanoidSoccerZ env.plane.restitution=0.8 +env.push_robot=True robot=smpl_humanoid \
    robot=smpl_humanoid robot.real_weight_porpotion_boxes=False env.motion_file=./sample_data/amass_isaac_simple_run_upright_slim.pkl \
    headless=True env.episode_length=3000 \
    horovod=True  learning.params.config.multi_gpu=True

export OMP_NUM_THREADS=1
# 2v2
python phc/run_hydra.py project_name=SMPLOlympics num_agents=4 learning=no_amp_z exp_name=soccer_pulse env=env_amp_z env.num_envs=1024 \
    env.task=HumanoidSoccerZ env.plane.restitution=0.8 +env.push_robot=True robot=smpl_humanoid \
    robot=smpl_humanoid robot.real_weight_porpotion_boxes=False env.motion_file=./sample_data/amass_isaac_simple_run_upright_slim.pkl \
    headless=True env.episode_length=3000 \
    horovod=True  learning.params.config.multi_gpu=True
