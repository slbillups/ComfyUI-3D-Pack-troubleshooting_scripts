<b>Debian/Ubuntu Instructions</b>


---

### Download and Run the Script
Download and run the script first - you can run the script from wherever just be sure to run with administrative (sudo) access. Place the Dockerfile in your ComfyUI-3D-Pack folder root - backup or replace the original.

- **[bash script](https://github.com/slbillups/ComfyUI-3D-Pack-troubleshooting_scripts/blob/main/ubuntu_build.sh)**
- **[Dockerfile](https://github.com/slbillups/ComfyUI-3D-Pack-troubleshooting_scripts/blob/main/Dockerfile)**

The shell script will ensure you have an up-to-date Docker CLI along with the necessary NVIDIA container/runtime for Docker + relevant OpenGL libraries.

> :warning: **WARNING:**  
> **After the script finishes, LOG OUT** and back in. If you have issues with building the image and I can't help you - you'll likely have to restart by re-running this script.

### Pull and Build the Image

[![Build with Docker](https://img.shields.io/badge/Build%20with-Docker-blue?logo=docker)](https://hub.docker.com/r/sbillups/comfy3d)


```Dockerfile
Docker pull sbillups:comfy3d
```
<br>
Use the same command that the source repository uses to build:<br>
<br>

```bash
docker build -t comfy3d . && docker run --rm -it -p 8188:8188 --gpus all comfy3d
```
</details>
