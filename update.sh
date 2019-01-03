#!/bin/bash

pydir=/home/lgx/py
gitdir=/usr/bin

cd ${pydir}
${gitdir}/python3 ${pydir}/sjget.py >${pydir}/today.tmp
#mdf=`/usr/bin/git status|grep zhikong|wc -l`
mdf=`cat today.tmp|wc -l`
if [ $mdf -gt 0 ];then
	new=`cat today.tmp`
	/usr/bin/git add .
	/usr/bin/git commit -m "$new"
	${gitdir}/git push >/dev/null
fi
