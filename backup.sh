#!/bin/bash
src=
tgt=
source_array=()
target_dir_array=()
zip_program=
if [ $1 == "J" ]
then
	zip_program=".xz"
elif [ $1 == "j" ]
then
	zip_program=".bz2"
elif [ $1 == "z" ]
then
	zip_program=".gz"
fi
for file in $(cat backupfile)
do
	if [ $file == "source:" ]
	then
		src=1
		tgt=0
	elif [ $file == "target:" ]
	then
		tgt=1
		src=0
	else
		if [ $src == 1 ]
		then
			source_array[${#source_array[@]}]=$file
		elif [ $tgt == 1 ]
		then
			target_dir_array[${#target_dir_array[@]}]=$file
		fi
	fi
done
echo "source: ${source_array[@]}"
echo "target: ${target_dir_array[@]}"
for target_dir in ${target_dir_array[@]}
do
	NOWTIME=`date '+%Y%m%d_%H%M%S'`
	mkdir -pv $target_dir
	tar -c$1vf $target_dir/backup_$NOWTIME.tar$zip_program ${source_array[@]}
done

echo "主人~请稍等~正在同步磁盘~"
sync
echo "主人~备份完成了呢~"
