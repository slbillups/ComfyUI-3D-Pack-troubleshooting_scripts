# ComfyUI-3D-Pack-troubleshooting_scripts
A powershell script to resolve common issues with the main client with a bash script coming soon - Docker only :C

#Place the script in ComfyUI's root directory and ensure you have ComfyUI-3D-Pack installed and updated before running.

## Who is this for?

<details>
<summary> Anyone struggling with building the ComfyUI-3D-Pack, I haven't tested this thoroughly but I've at least been able to build a brand new ComfyUI instance, only installing the ComfyUI-3D-Pack, ran this script and was able to get it working. Then again, I already had the necessary software and drivers *which you should check out at the bottom of this readme*.</summary>

I've been trying to reproduce what I did to get this to work on Windows, which was a lot easier than what I've done so far on Ubuntu. The shell script for Ubuntu/Debian-based distros is pretty shite, It'll likely just end up just being my customized docker-compose.yml that I finagled into working with the help of some libraries, mostly nvidia-docker2 and libnvidia-container.</summary>
</details>


## Prerequisites

- [Miniconda](https://docs.anaconda.com/free/miniconda/) or [conda](https://docs.conda.io/projects/conda/) - I tried finding a way around this mostly as I'm just not as familiar with using conda, but it works, and while I attempted to include the installer in the script it just kept adding more issues on top of what I was trying to fix.

- A general understanding of what this script is doing and why - I would highly recommend using this on a new clone of ComfyUI rather than your main ComfyUI instance just in case. This script is really just to give you the resources to build the *.whl files in ComfyUI-3D-Pack\_Pre_Builds\_Wheels_win_py311_cu121 without a bunch of gcc/C++/openGL and PIP errors assaulting you when you try to run one without the necessary software.

- Remembering and repeating the following whenever you have issues - you must add the arguments --listen x.x.x.x(0.0.0.0/127.0.0.1); if you don't you'll get something that looks ![like this](![image](https://github.com/slbillups/ComfyUI-3D-Pack-troubleshooting_scripts/assets/112226699/de708d05-205a-4fcb-b53c-5b7a836449ee))
 AFAIK you MUST use python 3.11.x, I would assume >=3.11.8 - xformers explodes when using >=3.12.0 at least in my testing and 3.10 just ends up giving me a fair deal of dependency issues with other packages.

## What's in the script? 

Not a lot honestly, Chocolatey and Git for those that didn't already have them. And then it's just:

+ [MSVC2022 build tools](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022)

+ MSVC Clang + Clang Toolkit - be sure to download those components after installing build tools.

+ [Cuda-toolkit - although in the script I'd recommend getting the latest through their site](https://developer.nvidia.com/cuda-downloads)

+ [If you really need it - Python 3.11.8](https://www.python.org/downloads/release/python-3118/) 
