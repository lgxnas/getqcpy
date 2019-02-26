### 备忘
#### 加编号(数字+'.'+空格)
`cat zhikong.txt |sed 's/ |/|/g'|awk '{print NR. -bash}' >qc.md`
#### 短网址自定义
`curl -i https://git.io -F url=https://github.com/lgxnas/getqcpy/blob/master/qc.md -F code=lgxqc`
#### 方糖微信推送
2019.2.26
方糖SCKEY保存在./ftsckey中
`curl -s "http://sc.ftqq.com/$key.send?text=$title" -d "&desp=$content" >>./ft.log` 
