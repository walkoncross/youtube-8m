
CUDA_VISIBLE_DEVICES="0" python train.py \
	--train_dir="../model/mmlstmmemory1024_moe8" \
	--train_data_pattern="/Youtube-8M/data/frame/train/train*" \
	--feature_names="rgb,audio" \
	--feature_sizes="1024,128" \
	--model=MatchingMatrixLstmMemoryModel \
	--batch_size=128 \
	--base_learning_rate=0.0005 \
	--num_epochs=5 \
	--lstm_cells=1024 \
	--lstm_layers=2 \
	--mm_label_embedding=256 \
	--frame_features=True \
	--moe_num_mixtures=8 \
	--rnn_swap_memory=True
