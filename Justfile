set shell := ["bash", "-lc"]

env := "matanyone2-cu132"
py := "/home/zero/.conda/envs/matanyone2-cu132/bin/python"

default:
	@just --list

video INPUT MASK:
	{{py}} inference_matanyone2.py -i "{{INPUT}}" -m "{{MASK}}"

video-save INPUT MASK OUT="results" WARMUP="10" ERODE="10" DILATE="10" MAX_SIZE="-1" SUFFIX="":
	{{py}} inference_matanyone2.py \
		-i "{{INPUT}}" \
		-m "{{MASK}}" \
		-o "{{OUT}}" \
		-w "{{WARMUP}}" \
		-e "{{ERODE}}" \
		-d "{{DILATE}}" \
		--max_size "{{MAX_SIZE}}" \
		--suffix "{{SUFFIX}}" \
		--save_image

demo:
	cd hugging_face && {{py}} app.py

gradio:
	cd hugging_face && {{py}} app.py

help:
	@just --list
