# MatAnyone2 Usage

## Environment

Activate the CUDA env:

```bash
conda activate matanyone2-cu132
```

If the `matanyone2` command is not on your PATH, run it through the env Python:

```bash
/home/zero/.conda/envs/matanyone2-cu132/bin/python -m matanyone2.cli --help
```

## Input Format

MatAnyone2 takes:

1. A video file such as `.mp4`, `.mov`, or `.avi`, or a folder of extracted frames
2. A first-frame segmentation mask image

The mask should match the first frame of the input.

## Basic Commands

Process a folder of frames:

```bash
matanyone2 -i inputs/video/test-sample1 -m inputs/mask/test-sample1.png
```

Process a video file:

```bash
matanyone2 -i inputs/video/test-sample2.mp4 -m inputs/mask/test-sample2.png
```

Use the Python entrypoint directly:

```bash
python inference_matanyone2.py -i inputs/video/test-sample2.mp4 -m inputs/mask/test-sample2.png
```

## Output

The default output directory is `results/`.

You will get:

- `*_fgr.mp4` for the foreground composite
- `*_pha.mp4` for the alpha matte video

If `--save-image` is enabled, per-frame PNGs are also written under:

```text
results/<video_name>/fgr/
results/<video_name>/pha/
```

## Common Settings

```bash
matanyone2 \
  -i inputs/video/test-sample2.mp4 \
  -m inputs/mask/test-sample2.png \
  -o results/ \
  -c pretrained_models/matanyone2.pth \
  -w 10 \
  -e 10 \
  -d 10 \
  --max-size 1080 \
  --save-image
```

Flags:

- `-o, --output-path`: where results are written
- `-c, --ckpt-path`: model checkpoint path
- `-w, --warmup`: number of warmup frames before saving output
- `-e, --erode-kernel`: erosion kernel size for the mask
- `-d, --dilate-kernel`: dilation kernel size for the mask
- `--suffix`: appended to the output name
- `--save-image`: also save per-frame PNGs
- `--max-size`: downsample when the smaller side exceeds this value

## Practical Notes

- The repo will auto-download the checkpoint the first time it runs if `pretrained_models/matanyone2.pth` is missing.
- This is not a single-image matting tool. A still image needs to be treated as a one-frame video/folder input.
- For your GPU, use the `matanyone2-cu132` environment.

## Local Demo

To launch the Gradio app:

```bash
cd hugging_face
python app.py
```

If you are missing demo dependencies, install them with:

```bash
conda activate matanyone2-cu132
python -m pip install -r hugging_face/requirements.txt
```
