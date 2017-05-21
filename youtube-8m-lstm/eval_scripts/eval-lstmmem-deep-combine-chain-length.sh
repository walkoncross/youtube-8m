
GPU_ID="0"
EVERY=1000
MODEL=LstmMemoryModel
MODEL_DIR="../model/lstmmem1024_deep_combine_chain_length" \

start=$1
DIR="$(pwd)"

for checkpoint in $(cd $MODEL_DIR && python ${DIR}/training_utils/select.py $EVERY); do
	echo $checkpoint;
	if [ $checkpoint -gt $start ]; then
		echo $checkpoint;
		CUDA_VISIBLE_DEVICES=$GPU_ID python eval.py \
			--train_dir="$MODEL_DIR" \
			--model_checkpoint_path="${MODEL_DIR}/model.ckpt-${checkpoint}" \
			--eval_data_pattern="/Youtube-8M/data/frame/validate/validatea*" \
			--frame_features=True \
			--feature_names="rgb,audio" \
			--feature_sizes="1024,128" \
			--model=LstmMemoryModel \
			--video_level_classifier_model=DeepCombineChainModel \
			--moe_num_mixtures=4 \
			--deep_chain_relu_cells=256 \
			--deep_chain_layers=1 \
			--deep_chain_use_length=True \
			--label_loss=MultiTaskCrossEntropyLoss \
			--multitask=True \
			--support_type="label" \
			--num_supports=4716 \
			--support_loss_percent=0.05 \
			--batch_size=128 \
			--model=$MODEL \
			--lstm_layers=2 \
			--rnn_swap_memory=True \
			--run_once=True
	fi
done

