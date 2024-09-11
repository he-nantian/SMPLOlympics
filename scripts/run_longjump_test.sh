#!/bin/bash

source ~/.bashrc

cd /root/code/SMPLOlympics

wandb login de8f6c767be345f0647422f38d4ff9d2c34a1c61

echo "Start running codes..."

python phc/hello_world.py

export OMP_NUM_THREADS=1
python phc/run_hydra.py \
    project_name=SMPLOlympics num_agents=1 \
    learning=ppo exp_name=longjump_ppo  \
    env=env_amp_z_longjump env.num_envs=1 env.task=HumanoidLongjump env.enableTaskObs=True \
    no_virtual_display=True   test=True   epoch=-1   \
    robot=smpl_humanoid  robot.has_upright_start=True  \
    env.motion_file=./sample_data/amass_isaac_simple_run_upright_slim.pkl \
    headless=False env.stateInit=Default env.episode_length=600 learning.params.config.max_epochs=100000 \
    horovod=True  learning.params.config.multi_gpu=True

# export OMP_NUM_THREADS=1
# python phc/run_hydra.py \
#     project_name=SMPLOlympics num_agents=1 \
#     learning=amp exp_name=longjump_amp  \
#     env=env_amp_z_longjump env.num_envs=1 env.task=HumanoidLongjumpZ env.enableTaskObs=True \
#     no_virtual_display=True   test=True   epoch=-1   \
#     robot=smpl_humanoid  robot.has_upright_start=True  \
#     env.motion_file=./sample_data/amass_isaac_simple_run_upright_slim.pkl \
#     headless=False env.stateInit=Default env.episode_length=600 learning.params.config.max_epochs=100000 \
#     horovod=True  learning.params.config.multi_gpu=True

# export OMP_NUM_THREADS=1
# python phc/run_hydra.py \
#     project_name=SMPLOlympics num_agents=1 \
#     learning=pulse exp_name=longjump_pulse  \
#     env=env_amp_z_longjump env.num_envs=1 env.task=HumanoidLongjumpZ env.enableTaskObs=True \
#     no_virtual_display=True   test=True   epoch=-1   \
#     robot=smpl_humanoid  robot.has_upright_start=True  \
#     env.motion_file=./sample_data/amass_isaac_simple_run_upright_slim.pkl \
#     headless=False env.stateInit=Default env.episode_length=600 learning.params.config.max_epochs=100000 \
#     horovod=True  learning.params.config.multi_gpu=True

# export OMP_NUM_THREADS=1
# python phc/run_hydra.py \
#     project_name=SMPLOlympics num_agents=1 \
#     learning=pulse_amp exp_name=longjump_pulse_amp  \
#     env=env_amp_z_longjump env.num_envs=1 env.task=HumanoidLongjumpZ env.enableTaskObs=True \
#     no_virtual_display=True   test=True   epoch=-1   \
#     robot=smpl_humanoid  robot.has_upright_start=True  \
#     env.motion_file=./sample_data/amass_isaac_simple_run_upright_slim.pkl \
#     headless=False env.stateInit=Default env.episode_length=600 learning.params.config.max_epochs=100000 \
#     horovod=True  learning.params.config.multi_gpu=True
