<h1 align="center">ComfyUI-3D-Pack-troubleshooting_scripts</h1>

  <strong>Includes:</strong>
    <br>
  - A docker image built for Debian/Ubuntu users as well as an accompanying shell script for pre-requisite libraries and a Dockerfile(to be placed in the ComfyUI-3D-Pack directory).


  - A Powershell script for Win10/11 users.


## 04/07/24 Debian/Ubuntu
*Finally finished - I really hope this works for anyone who uses it. If there are issues please let me know. I spent a lot of time tweaking and fixing it so you wouldn't need to do anything after it's built but I've only tested the image on my own machine as of now.*

<details>
<summary>
<b>Debian/Ubuntu Instructions</b>
</summary>

---

### Download and Run the Script
Download and run the script first - you can run the script from wherever just be sure to run with administrative (sudo) access. Place the Dockerfile in your ComfyUI-3D-Pack folder root - backup or replace the original.

- **[bash script](https://github.com/slbillups/ComfyUI-3D-Pack-troubleshooting_scripts/blob/main/ubuntu_build.sh)**
- **[Dockerfile](https://github.com/slbillups/ComfyUI-3D-Pack-troubleshooting_scripts/blob/main/Dockerfile)**

The shell script will ensure you have an up-to-date Docker CLI along with the necessary NVIDIA container/runtime for Docker + relevant OpenGL libraries.

> :warning: **WARNING:**  
> **After the script finishes, LOG OUT** and back in. If you have issues with building the image and I can't help you - you'll likely have to restart by re-running this script.

### Pull and Build the Image

[![Build with Docker](https://img.shields.io/badge/Build%20with-Docker-blue?logo=docker)](https://hub.docker.com/r/sbillups/comfy3d:ubuntu)


```Dockerfile
docker pull sbillups/comfy3d:ubuntu
```
<br>
Use the same command that the source repository uses to build:<br>
<br>

```bash
docker build -t comfy3d . && docker run --rm -it -p 8188:8188 --gpus all comfy3d
```
</details>
</details>

## 04/05/24 Win10/11

<details>
<summary> 
<font size="8"><b>Win10/11 instructions</b></font>
</summary>


***
 

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

<details>
<summary>option 1</summary>installs everything including the Chocolately package manager/git CLI if not already installed.
</details>

<details>
<summary>option 2</summary>assumes you have the necessary MSVC libraries and cuda runtime/cuda-toolkit installed. If the script fails, and its related to xformers, torch, cuda or onnxruntime, its likely due to a missing package - you can either run option 1 or download the missing package below.
</details>

If you have issues using the script, I'll do my best to assist however if you are running it in a newly built environment as I explained at the top; there shouldn't be any issues.

## packages installes via the script


 And then it's just:



+ [MSVC2022 build tools](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022)

+ MSVC Clang + Clang Toolkit - be sure to download those components after installing build tools.

+ [Cuda-toolkit - although in the script I'd recommend getting the latest through their site](https://developer.nvidia.com/cuda-downloads)

+ [If you really need it - Python 3.11.8](https://www.python.org/downloads/release/python-3118/) 

</details>

## Thanks to

https://github.com/MrForExample/ComfyUI-3D-Pack - the source extension

https://github.com/remsky/ComfyUI3D-Assorted-Wheels - pre-built Linux wheel files
