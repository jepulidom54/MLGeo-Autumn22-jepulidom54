#! /bin/bash
#concat miniseed files of the same day
for x in *__003
do 
	echo $x
	cat $x >> new_miniseed2-"x3"
done

