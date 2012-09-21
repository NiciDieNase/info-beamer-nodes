#! /bin/bash
cd `dirname $(readlink -f ${0})`

i=0

touch ./tmpimgs.txt

while read line; do
	wget -q -O tmpimg.jpg ${line}
	mv tmpimg.jpg img${i}.jpg
	echo img${i}.jpg >> ./tmpimgs.txt
	let "i += 1"
done < ./cams.txt

mv ./tmpimgs.txt ./imgs.txt
