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

python phc/run_hydra.py \
    project_name=SMPLOlympics num_agents=1 \
    learning=ppo exp_name=tabletennis__ppo  \
    env=env_amp env.num_envs=2048 env.task=HumanoidPP env.enableTaskObs=True +env.contact_bodies=["R_Ankle","L_Ankle","R_Toe","L_Toe","R_Hand"] \
    robot=smpl_humanoid_pp  robot.has_upright_start=True env.shape_resampling_interval=500000 \
    env.motion_file=./sample_data/amass_isaac_simple_run_upright_slim.pkl \
    headless=True env.stateInit=Default no_log=True \
    learning.params.config.max_epochs=100000  \
    horovod=True  learning.params.config.multi_gpu=True

python phc/run_hydra.py \
    project_name=SMPLOlympics num_agents=1 \
    learning=amp exp_name=tabletennis_amp  \
    env=env_amp env.num_envs=2048 env.task=HumanoidPP env.enableTaskObs=True +env.contact_bodies=["R_Ankle","L_Ankle","R_Toe","L_Toe","R_Hand"] \
    robot=smpl_humanoid_pp  robot.has_upright_start=True env.shape_resampling_interval=500000 \
    env.motion_file=./sample_data/pingpong1after_upright.pkl \
    headless=True env.stateInit=Default env.numAMPObsSteps=10 no_log=True \
    learning.params.config.max_epochs=100000  \
    horovod=True  learning.params.config.multi_gpu=True


python phc/run_hydra.py \
    project_name=SMPLOlympics num_agents=1  \
    learning=pulse exp_name=tabletennis_pulse  \
    env=env_amp_z env.num_envs=2048 env.task=HumanoidPPZ env.enableTaskObs=True +env.contact_bodies=["R_Ankle","L_Ankle","R_Toe","L_Toe","R_Hand"] \
    robot=smpl_humanoid_pp  robot.has_upright_start=True env.shape_resampling_interval=500000 \
    env.motion_file=./sample_data/amass_isaac_simple_run_upright_slim.pkl \
    headless=True env.stateInit=Default no_log=True \
    learning.params.config.max_epochs=100000  \
    horovod=True  learning.params.config.multi_gpu=True


python phc/run_hydra.py \
    project_name=SMPLOlympics num_agents=1 \
    learning=pulse_amp exp_name=tabletennis_pulse_amp  \
    env=env_amp_z env.num_envs=2048 env.task=HumanoidPPZ env.enableTaskObs=True +env.contact_bodies=["R_Ankle","L_Ankle","R_Toe","L_Toe","R_Hand"] \
    robot=smpl_humanoid_pp  robot.has_upright_start=True env.shape_resampling_interval=500000 \
    env.motion_file=./sample_data/pingpong1after_upright.pkl \
    headless=True env.stateInit=Default env.numAMPObsSteps=10 no_log=True \
    learning.params.config.max_epochs=100000  \
    horovod=True  learning.params.config.multi_gpu=True


# Finetuning two-person play
python phc/run_hydra.py \
    project_name=SMPLOlympics num_agents=2  \
    learning=pulse_amp exp_name=tabletennis_pulse_amp  \
    env=env_amp_z env.num_envs=512 env.task=HumanoidPP2Z env.enableTaskObs=True +env.contact_bodies=["R_Ankle","L_Ankle","R_Toe","L_Toe","R_Hand"] \
    robot=smpl_humanoid_pp  robot.has_upright_start=True env.numAMPObsSteps=10 env.shape_resampling_interval=500000 \
    env.motion_file=./sample_data/pingpong1after_upright.pkl headless=True env.stateInit=Default epoch=70000 no_log=True \
    horovod=True  learning.params.config.multi_gpu=True