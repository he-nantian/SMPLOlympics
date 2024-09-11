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

# export OMP_NUM_THREADS=1
python phc/run_hydra.py     project_name=SMPLOlympics num_agents=2   \
        learning=amp_z_self_play exp_name=boxing_pulse   \
        no_virtual_display=True   test=True   epoch=-1    \
        env=env_amp_z env.num_envs=1 env.task=HumanoidBoxingZ env.enableTaskObs=True  \
        env.stateInit=Start    robot=smpl_humanoid_boxing +env.models=["output/HumanoidIm/pulse_vae/Humanoid.pth"]      \
        env.motion_file=./sample_data/video_boxing_afterproc_upright.pkl headless=False env.episode_length=300  learning.params.config.switch_frequency=250 \
        horovod=True  learning.params.config.multi_gpu=True

