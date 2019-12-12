#!/bin/bash

pydir=/root/getqcpy
gitdir=/usr/bin

cd ${pydir}
${gitdir}/python3 ${pydir}/sjget.py >${pydir}/today.tmp
#mdf=`/usr/bin/git status|grep zhikong|wc -l`
mdf=`cat today.tmp|wc -l`
function ft()
{
	title="密码样更新"
        key=`cat ftsckey`
        ftdesp="TCS by Lgx"
        for((i=1;i<=$mdf;i++))
        do
		id=`sed -n $i"p" today.tmp`
		ftdesp=$ftdesp"
	      	"$i". "`grep $id zhikong.txt|awk -F "|" '{print $1"|"$2"|"$4}'`"


	      	"
	done
	FT_JSON=$(curl -s "http://sc.ftqq.com/$key.send?text=$title" -d "&desp=$ftdesp")
# >>./ft.log
#	echo `date +%F' '%T` >>./ft.log
	if [ $(echo ${FT_JSON}|grep success|wc -l) -eq 0 ];then
        	echo -e "$(date +%F' '%T)\n${FT_JSON}\n" >> ${pydir}/ft.log
        	exit
	fi
}

if [ $mdf -gt 0 ];then
	new=`cat today.tmp`
	date +%s >${pydir}/version
	ft
	/usr/bin/git add .
	/usr/bin/git commit -m "$new"
	${gitdir}/git push origin master>/dev/null
	${gitdir}/git push gitee master>/dev/null
fi
