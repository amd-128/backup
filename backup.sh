#!/bin/bash
SOURCE=0
TARGET=0
source_array=()
target_dir_array=()
for file in $(cat backupfile)
do
	if [ $file == "source:" ]
	then
		SOURCE=1
		TARGET=0
	elif [ $file == "target:" ]
	then
		TARGET=1
		SOURCE=0
	else
		if [ $SOURCE == 1 ]
		then
			source_array[${#source_array[@]}]=$file
		elif [ $TARGET == 1 ]
		then
			target_dir_array[${#target_dir_array[@]}]=$file
		fi
	fi
done
echo "source: ${source_array[@]}"
echo "target: ${target_dir_array[@]}"
for target_dir in ${target_dir_array[@]}
do
	NOWTIME=`date '+%Y-%m-%d_%H:%M:%S'`
	mkdir -pv $target_dir/backup_$NOWTIME
	for source in ${source_array[@]}
	do
		cp -rv $source $target_dir/backup_$NOWTIME/$source
	done
done

echo "主人~请稍等~正在同步磁盘~"
sync
echo "主人~备份完成了呢~"