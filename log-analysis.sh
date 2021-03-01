#!/bin/sh
[ -f /etc/init.d/functions ] && . /etc/init.d/functions


logpath(){

read -p "Please input the path of logs(/tmp/logs/):" spath

 pathcheck
}


pathcheck(){

 if [ ! -d $spath ]; then
  echo "This path does not exist!" 
  logpath
else
  path=$(find $spath|tail -n +2)
  key
 fi
}
key(){
read -p "Please input your keyword:" keyword

mkdir ./${keyword}

for file in $path 
do
 eval sed -n '/${keyword}/p' ${file} >> ./${keyword}/${keyword}_log.log
done


cat ./${keyword}/${keyword}_log.log |tr -s ' '|cut -d' ' -f1| sort -r| uniq -c| sort -k1 -nr >>./${keyword}/${keyword}_ip.txt

ip=$(awk '{print $2}' ./${keyword}/${keyword}_ip.txt)
for file in $path 
do
	for i in $ip
	do  
	eval sed -n '/${i}/p' ${file} >> ./${keyword}/${keyword}_ip_log.log
	done
done
}
logpath
