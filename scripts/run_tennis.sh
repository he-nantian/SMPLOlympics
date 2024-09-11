#!/bin/bash

source ~/.bashrc

cd /root/code/SMPLOlympics

export http_proxy=https://henantian:SpcVuBE1CmviLaCybSiQwq5ec7KcEJcghp8f6CE9Yf2I6KfGc15CPVXkxm7J@blsc-proxy.pjlab.org.cn:13128
export https_proxy=https://henantian:SpcVuBE1CmviLaCybSiQwq5ec7KcEJcghp8f6CE9Yf2I6KfGc15CPVXkxm7J@blsc-proxy.pjlab.org.cn:13128
export HTTP_PROXY=https://henantian:SpcVuBE1CmviLaCybSiQwq5ec7KcEJcghp8f6CE9Yf2I6KfGc15CPVXkxm7J@blsc-proxy.pjlab.org.cn:13128
export HTTPS_PROXY=https://henantian:SpcVuBE1CmviLaCybSiQwq5ec7KcEJcghp8f6CE9Yf2I6KfGc15CPVXkxm7J@blsc-proxy.pjlab.org.cn:13128

wandb login de8f6c767be345f0647422f38d4ff9d2c34a1c61

echo "Start running codes..."

python phc/hello_world.py

export OMP_NUM_THREADS=1
python phc/run_hydra.py \
    project_name=SMPLOlympics num_agents=1 \
    learning=ppo exp_name=tennis_ppo  \
    env=env_amp env.num_envs=2048 env.task=HumanoidTennis env.enableTaskObs=True env.plane.restitution=0.6 +env.contact_bodies=["R_Ankle","L_Ankle","R_Toe","L_Toe","R_Hand"] \
    robot=smpl_humanoid_tennis_righthand  robot.has_upright_start=True  robot.real_weight_porpotion_boxes=False env.shape_resampling_interval=500000 \
    env.motion_file=./sample_data/amass_isaac_simple_run_upright_slim.pkl headless=True env.episode_length=600 \
    headless=True env.stateInit=Default  \
    learning.params.config.max_epochs=30000 \
    horovod=True  learning.params.config.multi_gpu=True

export OMP_NUM_THREADS=1
python phc/run_hydra.py \
    project_name=SMPLOlympics num_agents=1 \
    learning=amp exp_name=tennis_amp  \
    env=env_amp env.num_envs=2048 env.task=HumanoidTennis env.enableTaskObs=True env.plane.restitution=0.6 +env.contact_bodies=["R_Ankle","L_Ankle","R_Toe","L_Toe","R_Hand"] \
    robot=smpl_humanoid_tennis_righthand  robot.has_upright_start=True  robot.real_weight_porpotion_boxes=False env.shape_resampling_interval=500000 \
    env.motion_file=./sample_data/video_tennis_afterproc_upright.pkl headless=True env.episode_length=600 \
    headless=True env.stateInit=Default env.numAMPObsSteps=10  \
    learning.params.config.max_epochs=30000 \
    horovod=True  learning.params.config.multi_gpu=True

export OMP_NUM_THREADS=1
python phc/run_hydra.py \
    project_name=SMPLOlympics num_agents=1 \
    learning=pulse exp_name=tennis_pulse \
    env=env_amp_z env.num_envs=2048 env.task=HumanoidTennisZ env.enableTaskObs=True env.plane.restitution=0.6 +env.contact_bodies=["R_Ankle","L_Ankle","R_Toe","L_Toe","R_Hand"] \
    robot=smpl_humanoid_tennis_righthand  robot.has_upright_start=True  robot.real_weight_porpotion_boxes=False env.shape_resampling_interval=500000 \
    env.motion_file=./sample_data/video_tennis_afterproc_upright.pkl headless=True env.episode_length=600 \
    headless=True env.stateInit=Default env.numAMPObsSteps=10  \
    learning.params.config.max_epochs=30000 \
    horovod=True  learning.params.config.multi_gpu=True

export OMP_NUM_THREADS=1
python phc/run_hydra.py \
    project_name=SMPLOlympics num_agents=1 \
    learning=pulse_amp exp_name=tennis_pulse_amp \
    env=env_amp_z env.num_envs=2048 env.task=HumanoidTennisZ env.enableTaskObs=True env.plane.restitution=0.6 +env.contact_bodies=["R_Ankle","L_Ankle","R_Toe","L_Toe","R_Hand"] \
    robot=smpl_humanoid_tennis_righthand  robot.has_upright_start=True  robot.real_weight_porpotion_boxes=False env.shape_resampling_interval=500000 \
    env.motion_file=./sample_data/video_tennis_afterproc_upright.pkl headless=True env.episode_length=600 \
    headless=True env.stateInit=Default env.numAMPObsSteps=10  \
    learning.params.config.max_epochs=30000 \
    horovod=True  learning.params.config.multi_gpu=True

#### two person finetune 
export OMP_NUM_THREADS=1
python phc/run_hydra.py \
    project_name=SMPLOlympics num_agents=2 \
    learning=pulse exp_name=tennis2_pulse  \
    env=env_amp_z env.task=HumanoidTennis2Z env.enableTaskObs=True env.plane.restitution=0.6 +env.contact_bodies=["R_Ankle","L_Ankle","R_Toe","L_Toe","R_Hand"] \
    robot=smpl_humanoid_tennis_righthand  robot.has_upright_start=True  robot.real_weight_porpotion_boxes=False \
    env.motion_file=./sample_data/amass_isaac_simple_run_upright_slim.pkl env.shape_resampling_interval=500000 \
    env.episode_length=2000 epoch=30000 env.stateInit=Default  \
    env.num_envs=512  headless=True env.numAMPObsSteps=10 \
    horovod=True  learning.params.config.multi_gpu=True