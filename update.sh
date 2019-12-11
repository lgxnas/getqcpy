#!/bin/bash

pydir=/root/project/getqcpy
gitdir=/usr/bin

cd ${pydir}
${gitdir}/python3 ${pydir}/sjget.py >${pydir}/today.tmp
#mdf=`/usr/bin/git status|grep zhikong|wc -l`
mdf=`cat today.tmp|wc -l`
function ft()
{
	title="密码样更新"
        key=`cat ftsckey`
        ftdesp="GCP-La by Lgx"
        for((i=1;i<=$mdf;i++))
        do
		id=`sed -n $i"p" today.tmp`
		ftdesp=$ftdesp"
	      	"$i". "`grep $id zhikong.txt|awk -F "|" '{print $1"|"$2"|"$4}'`"


	      	"
	done
	curl -s "http://sc.ftqq.com/$key.send?text=$title" -d "&desp=$ftdesp" >>./ft.log
	echo `date +%F' '%T` >>./ft.log
}
if [ $mdf -gt 0 ];then
	new=`cat today.tmp`
	date +%s >/home/lgx/py/version
	ft
	/usr/bin/git add .
	/usr/bin/git commit -m "$new"
	${gitdir}/git push origin master>/dev/null
	${gitdir}/git push gitee master>/dev/null
fi
