#!/usr/bin/env bash
set -euo pipefail

ENV_NAME="${1:-matanyone2-cu132}"

if ! conda env list | awk '{print $1}' | grep -qx "${ENV_NAME}"; then
  conda create -n "${ENV_NAME}" python=3.10 pip -y --override-channels -c conda-forge
fi

conda install -n "${ENV_NAME}" pip -y --override-channels -c conda-forge

conda run -n "${ENV_NAME}" python -m pip install --upgrade pip
conda run -n "${ENV_NAME}" python -m pip install torch torchvision --index-url https://download.pytorch.org/whl/cu132
conda run -n "${ENV_NAME}" python -m pip install -e .
conda run -n "${ENV_NAME}" python -m pip install -r hugging_face/requirements.txt

mkdir -p pretrained_models
curl -L https://github.com/pq-yang/MatAnyone2/releases/download/v1.0.0/matanyone2.pth -o pretrained_models/matanyone2.pth

echo "Setup complete for ${ENV_NAME}"
