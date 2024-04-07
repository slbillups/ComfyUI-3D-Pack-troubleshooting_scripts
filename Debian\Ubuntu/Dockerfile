ARG CUDA_VERSION=12.1.0-devel

FROM docker.io/nvidia/cuda:${CUDA_VERSION}-ubuntu22.04

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        build-essential \
        curl \
        ffmpeg \
        git \
        libegl1 \
        libegl1-mesa-dev \
        libgl1 \
        libglib2.0-0 \
        libgl1-mesa-dev \
        libgl1-mesa-glx \
        libgles2 \
        libgles2-mesa-dev \
        libglib2.0-0 \
        libglvnd-dev \
        libglvnd0 \
        libglx0 \
        libsm6 \
        libxext6 \
        libxrender1 \
        ninja-build \
        python3.11 \
        python3.11-dev \
        wget && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11 && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/bin/python3.11 /usr/bin/python && \
    ln -s /usr/bin/pip3.11 /usr/bin/pip

RUN adduser --uid 1001 -q user && \
    mkdir /app && chown user /app
USER user

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    LD_LIBRARY_PATH=/usr/lib64:$LD_LIBRARY_PATH \
    NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility,graphics \
    PYOPENGL_PLATFORM=egl

RUN pip install --no-cache --index-url https://download.pytorch.org/whl/cu121 \
    torch==2.2.0 torchvision==0.17.0 xformers==0.0.24

WORKDIR /app
RUN git clone "https://github.com/comfyanonymous/ComfyUI.git" ./ && \
    git reset --hard 05cd00695a84cebd5603a31f665eb7301fba2beb && \
    pip install --no-cache -r requirements.txt

WORKDIR /app/custom_nodes/ComfyUI-3D-Pack/
COPY --chown=user:user requirements.txt requirements_post.txt ./
COPY --chown=user:user simple-knn/ simple-knn/
COPY --chown=user:user tgs/ tgs/
RUN pip install --no-cache -r requirements.txt && \
    pip install --no-cache -r requirements_post.txt && \
    pip install --no-cache ninja scikit-learn rembg[gpu] open_clip_torch

# Clone the ComfyUI3D-Assorted-Wheels repository and install the wheel files
RUN git clone https://github.com/remsky/ComfyUI3D-Assorted-Wheels.git /app/wheels && \
    pip install --no-cache /app/wheels/*.whl

WORKDIR /app/custom_nodes/
RUN git clone "https://github.com/ltdrdata/ComfyUI-Impact-Pack" && \
    cd ComfyUI-Impact-Pack && \
    git reset --hard e1570e76799049fb0038f6232fd89800ab4565eb && \
    pip install --no-cache -r requirements.txt
RUN git clone "https://github.com/kijai/ComfyUI-KJNodes" && \
    cd ComfyUI-KJNodes && \
    git reset --hard 95ae8b067a8aa5825471189954579ffa02aa9256 && \
    pip install --no-cache -r requirements.txt
RUN git clone "https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite" && \
    cd ComfyUI-VideoHelperSuite && \
    git reset --hard f94597739f20dac331f9918a245149b6b00a60f2 && \
    pip install --no-cache -r requirements.txt

COPY --chown=user:user ./ ComfyUI-3D-Pack/

# Install kiui and torchmcubes wheels
WORKDIR /app/custom_nodes/ComfyUI-3D-Pack/_Pre_Builds/_Wheels_linux_py311_cu121/
RUN pip install --no-cache kiui-0.2.7-py3-none-any.whl
RUN pip install --no-cache torchmcubes-0.1.0-cp311-cp311-linux_x86_64.whl

WORKDIR /app
ENTRYPOINT [ "python", "main.py", "--listen", "0.0.0.0" ]

