#!/bin/bash

source ~/.bashrc

cd /root/code/SMPLOlympics

export http_proxy=https://henantian:SpcVuBE1CmviLaCybSiQwq5ec7KcEJcghp8f6CE9Yf2I6KfGc15CPVXkxm7J@blsc-proxy.pjlab.org.cn:13128
export https_proxy=https://henantian:SpcVuBE1CmviLaCybSiQwq5ec7KcEJcghp8f6CE9Yf2I6KfGc15CPVXkxm7J@blsc-proxy.pjlab.org.cn:13128
export HTTP_PROXY=https://henantian:SpcVuBE1CmviLaCybSiQwq5ec7KcEJcghp8f6CE9Yf2I6KfGc15CPVXkxm7J@blsc-proxy.pjlab.org.cn:13128
export HTTPS_PROXY=https://henantian:SpcVuBE1CmviLaCybSiQwq5ec7KcEJcghp8f6CE9Yf2I6KfGc15CPVXkxm7J@blsc-proxy.pjlab.org.cn:13128

wandb login de8f6c767be345f0647422f38d4ff9d2c34a1c61

wait

echo "Start running codes..."

python phc/hello_world.py

# export OMP_NUM_THREADS=1
python phc/run_hydra.py \
    project_name=SMPLOlympics num_agents=1  \
    learning=ppo exp_name=hurdle_ppo \
    env=env_amp env.num_envs=2048 env.task=HumanoidHurdle env.enableTaskObs=True env.shape_resampling_interval=1000 \
    robot=smpl_humanoid  robot.has_upright_start=True learning.params.config.max_epochs=10000 \
    env.motion_file=./sample_data/amass_isaac_simple_run_upright_slim.pkl headless=True env.stateInit=Default env.episode_length=600 \
    horovod=True  learning.params.config.multi_gpu=True  im_eval=True  render_o3d=True

wait

export OMP_NUM_THREADS=1
python phc/run_hydra.py \
    project_name=SMPLOlympics num_agents=1  \
    learning=amp exp_name=hurdle_amp  \
    env=env_amp env.num_envs=2048 env.task=HumanoidHurdle env.enableTaskObs=True env.shape_resampling_interval=1000 \
    robot=smpl_humanoid  robot.has_upright_start=True learning.params.config.max_epochs=10000 \
    env.motion_file=./sample_data/amass_isaac_simple_run_upright_slim.pkl headless=True env.stateInit=Default env.episode_length=600 \
    horovod=True  learning.params.config.multi_gpu=True  im_eval=True  render_o3d=True

wait

export OMP_NUM_THREADS=1
python phc/run_hydra.py \
    project_name=SMPLOlympics num_agents=1  \
    learning=pulse exp_name=hurdle_pulse  \
    env=env_amp_z env.num_envs=2048 env.task=HumanoidHurdleZ env.enableTaskObs=True env.shape_resampling_interval=1000 \
    robot=smpl_humanoid  robot.has_upright_start=True learning.params.config.max_epochs=10000 \
    env.motion_file=./sample_data/amass_isaac_simple_run_upright_slim.pkl headless=True env.stateInit=Default env.episode_length=600 \
    horovod=True  learning.params.config.multi_gpu=True  im_eval=True  render_o3d=True

wait

echo "Finished!"