# ComfyUI-3D-Pack-troubleshooting_scripts
A powershell script to resolve common issues with the main client with a bash script coming soon - Docker only :C

## Who is this for?

Win10/11 users having trouble setting up the ComfyUI-3D-Pack. You **must build this using conda(miniconda/anaconda)** and it **must be run in administrative mode**. This script will not work correctly if you have conda installed on your path.

While I have gotten this to work on existing containers, you have the best chance of a successful install by creating a new ComfyUI clone to prevent dependencies from clashing.

## step-by-step guide

1. create a new clone of ConfyUI with the 3D Pack extension.

```shell
git clone https://github.com/comfyanonymous/ComfyUI

git clone 

https://github.com/MrForExample/ComfyUI-3D-Pack .\ComfyUI\Custom_Nodes\
```

2. place the .ps1 script into the root directory of ComfyUI however you want.

3. Run the script(via an Administrator Miniconda/Conda Powershell terminal).

4. After completion, the script will launch a ComfyUI instance with --listen 0.0.0.0 at the default port - i.e localhost:8188 

> [!IMPORTANT]
> The extension will break ComfyUI's litegraph web GUI if it isnt run with --listen 0.0.0.0/127.0.0.1/etc, this is a necessity for thr extension to run; and one of the reasons I personally prefer to keep this ComfyUI instance seperated from my other main instance.


## Script breakdown

<details><summary>
option 1</summary>installs everything including the Chocolately package manager/git CLI if not already installed.
</details>

<details><summary>
option 2</summary>assumes you have the necessary MSVC libraries and cuda runtime/cuda-toolkit installed. If the script fails, and its related to xformers, torch, cuda or onnxruntime, its likely due to a missing package - you can either run option 1 or download the missing package below.
</details>

If you have issues using the script, I'll do my best to assist however if you are running it in a newly built environment as I explained at the top; there shouldn't be any issues.

## packages installes via the script


 And then it's just:



+ [MSVC2022 build tools](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022)

+ MSVC Clang + Clang Toolkit - be sure to download those components after installing build tools.

+ [Cuda-toolkit - although in the script I'd recommend getting the latest through their site](https://developer.nvidia.com/cuda-downloads)

+ [If you really need it - Python 3.11.8](https://www.python.org/downloads/release/python-3118/) 
