### 备忘
#### 加编号(数字+'.'+空格)
`cat zhikong.txt |sed 's/ |/|/g'|awk '{print NR. -bash}' >qc.md`
#### 短网址自定义
`curl -i https://git.io -F url=https://github.com/lgxnas/getqcpy/blob/master/qc.md -F code=lgxqc`
