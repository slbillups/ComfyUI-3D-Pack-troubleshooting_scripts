# Menu for user options
Write-Host "What do you need to do?"
Write-Host "1. Everything (dependencies + script)"
Write-Host "2. I have the dependencies, I just need the wheels built"
Write-Host "3. Neither, I can't get this to work"
$userChoice = Read-Host "Enter your choice (1/2/3)"

switch ($userChoice) {
    "1" {
        # Option 1: Install everything
        Write-Host "Installing everything..."
    }
    "2" {
        # Option 2: Only build wheels
        Write-Host "Building wheels only..."
    }
    "3" {
        # Option 3: Open Miniconda download page
        Start-Process "https://docs.conda.io/en/latest/miniconda.html"
        exit
    }
    default {
        Write-Host "Invalid option selected. Exiting..."
        exit
    }
}

# Define the root directory of ComfyUI
$rootDir = Get-Location
Write-Host "Root directory: $rootDir"

#cloning other comfyUI extensions first - probably shouldn't assume the user already has these extensions installed
git clone https://github.com/ltdrdata/ComfyUI-Manager $rootDir/custom_nodes/ComfyUI-Manager
git clone https://github.com/MrForExample/ComfyUI-3D-Pack $rootDir/custom_nodes/ComfyUI-3D-Pack
git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack $rootDir/custom_nodes/ComfyUI-Impact-Pack
git clone https://github.com/kijai/ComfyUI-KJNodes $rootDir/custom_nodes/ComfyUI-KJNodes
git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite $rootDir/custom_nodes/ComfyUI-VideoHelperSuite

if ($userChoice -eq "1") {
    # Install Chocolatey if not already installed
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is not installed. Installing Chocolatey..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    } else {
        Write-Host "Chocolatey is already installed."
    }

    # Import Chocolatey environment variables helper if it exists
    $chocoProfilePath = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
    if (Test-Path $chocoProfilePath) {
        Import-Module $chocoProfilePath
        Update-SessionEnvironment
    } else {
        Write-Host "Chocolatey profile script not found. Please restart the script to refresh environment variables."
    }

    # Install Git if not present
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Host "Git is not installed. Installing Git..."
        choco install git -y
        RefreshEnv.cmd
    }

    # Check for MSBuildTools
    $buildToolsInstalled = $False
    foreach ($year in @("2019", "2022")) {
        if (Test-Path "$env:PROGRAMFILES(x86)\Microsoft Visual Studio\$year\BuildTools\MSBuild\Microsoft\VC") {
            Write-Host "Microsoft Build Tools $year are already installed."
            $buildToolsInstalled = $True
            break
        }
    }
    if (-not $buildToolsInstalled) {
        choco install -y visualstudio2022buildtools
        choco install -y visualstudio2022-workload-vctools --package-parameters "--add Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset --add Microsoft.VisualStudio.Component.VC.Llvm.Clang"
        choco install -y cuda
    }
}

# Create and activate Conda environment
$condaEnvName = "comfy3d"
conda create -n $condaEnvName python=3.11 -y
conda activate $condaEnvName

# Verify Python version
python --version

# Install packages
python -m pip install --upgrade pip
conda install -c "nvidia/label/cuda-12.1.0" cuda-toolkit
pip install torch torchvision --index-url https://download.pytorch.org/whl/cu121
pip install wheel setuptools ninja cmake rembg[gpu]
pip install -r requirements.txt

# Check if wheels are available in the local directory
# Define the local wheel directory relative to the root ComfyUI directory
$localWheelDir = Join-Path $rootDir 'custom_nodes\ComfyUI-3D-Pack\_Pre_Builds\_Wheels_win_py311_cu121'

# Define the list of wheel files
$localWheels = @(
    'torch_scatter-2.1.2-cp311-cp311-win_amd64.whl',
    'torchmcubes-0.1.0-cp311-cp311-win_amd64.whl',
    'simple_knn-0.0.0-cp311-cp311-win_amd64.whl',
    'pytorch3d-0.7.6-cp311-cp311-win_amd64.whl',
    'nvdiffrast-0.3.1-py3-none-any.whl',
    'kiui-0.2.4-py3-none-any.whl',
    'diff_gaussian_rasterization-0.0.0-cp311-cp311-win_amd64.whl'
	'pointnet2_ops-3.0.0-cp311-cp311-win_amd64.whl'
)

# Install wheels from the local directory
Write-Host "Installing wheels from local directory..."
foreach ($wheel in $localWheels) {
    $wheelPath = Join-Path $localWheelDir $wheel
    if (Test-Path $wheelPath) {
        python -m pip install $wheelPath
    } else {
        Write-Host "Wheel file not found: $wheelPath"
    }
}

# Install additional packages
python -m pip install pyhocon omegaconf plyfile trimesh pymeshlab pytorch_msssim torchtyping jaxtyping matplotlib roma opencv-python nerfacc>=0.5.3 PyMCubes scikit-learn diffusers>=0.26.1 open_clip_torch imageio-ffmpeg pygltflib xatlas
python -m pip install xformers

# Start ComfyUI
python -c "import subprocess; subprocess.Popen(['python', 'main.py', '--listen', '0.0.0.0'])"
