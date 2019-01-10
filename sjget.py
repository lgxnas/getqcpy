#!/usr/bin/python3
# -*- coding: utf-8 -*-

import requests
import time

def selstr(a):
    b=0
    with open('./list.txt','r') as foo:
        for line in foo.readlines():
            if a in line:
                b=b+1
        if b==0:
            return False
        else:
            return True

def get_url(url):
	headers={'user-agent':'Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'}
	res=requests.get(url,headers=headers)
	return res
	
def save_info(name,bianhao,guobiaohao,nongdu,youxiaoqi):
	save_time=time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
	s= name + '|' + bianhao + '|' + guobiaohao + '|' + nongdu + '|' + youxiaoqi + '|' + save_time + '\n'
	f = open('./zhikong.txt','a',encoding='utf-8')
	f.write(s)
	f.close()
	slist= bianhao + '|'
	f = open('./list.txt','a',encoding='utf-8')
	f.write(slist)
	f.close()
	print(name+'|'+bianhao)
	
def format1(res,istart):
	iend=res.text.find('</td><td>现货',istart)
	temp=res.text[istart+4:iend]
	wd_rep=[' 20ml 水质标样</a>',' 30ml 水质标样</a>',' 10ml 有机物监测标样</a>',' 20ml 质量控制用标准样品</a>',' 有机物监测标样</a>',' 20mL 空气监测标样 (水剂)</a>']
	temp=temp.replace('</td><td>','|')
	for i_wd_rep in range(len(wd_rep)):
		temp=temp.replace(wd_rep[i_wd_rep],'')
	temp=temp.replace('l','L')
	i=temp.find('|')
	name=temp[0:i].strip()
	bianhao=temp[i+1:temp.find('|',i+1)].strip()
	i=temp.find('|',i+1)
	guobiaohao=temp[i+1:temp.find('|',i+1)].strip()
	i=temp.find('|',i+1)
	nongdu=temp[i+1:temp.find('|',i+1)].strip()
	i=temp.find('|',i+1)
	youxiaoqi=temp[i+1:temp.find('|',i+1)].strip()
	bianhao=str(bianhao)
	if selstr(bianhao)==False:
            save_info(name,bianhao,guobiaohao,nongdu,youxiaoqi)
	return iend

def find_head(res,i):
	istart = res.text.find('标样所 ',i)
	return istart
	
def while_error(res,istart):
	while(find_head(res,istart)!=-1):
		iend=format1(res,find_head(res,istart))
		istart=iend
	
	
def main():
	temp_url=["cu","pb","zn","cd","fe","mn","ni","k","na","ca","mg","六价铬","总铬","油","ph","电导","总磷","氨氮","阴离子","挥发酚","总氮","COD","氮氧化物","硝酸盐"]
	for i in range(len(temp_url)):
		url='http://www.hb-erm.com/?key='+temp_url[i]+'&cate=334&m=goods&a=search'
		#print(url)
		res = get_url(url)
		while_error(res,5000)
	
if __name__ =="__main__":
	main()
