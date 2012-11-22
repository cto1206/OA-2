
function changeNumberDisplay(num){
  var rtn = "";
  if(num < 10){
    rtn = "0" + num;
  }else{
    rtn = num;
  }
  return rtn;
}
/*
	函数名称：trim
	函数功能: 去除字符串头部和尾部的空格
	传入参数：字符串变量
	传出结果：处理后的子串
*/
function trim(str){
	return str.replace(/(^\s*)|(\s*$)/g, "");
}

function isIncludePoint(string){
   if(string.indexOf(".")!=-1){
      return true;
  }
   else{
      return false;
  }
}

function ignoreSpaces(string) {
  var temp = "";
  string = '' + string;
  splitstring = string.split(" "); //双引号之间是个空格；
  for(i = 0; i < splitstring.length; i++)
     temp += splitstring[i];
  return temp;
}

function isChn(d) {
 actlen=d.length;
 for(i=0;i<d.length;i++)
 if (d.substr(i,1)>"~")
    actlen+=1;
 if( actlen>d.length )
   return true;
 return false;
}


function isBirthDate(d) {
	var first,second,yy,mm,dd;
	var today = new Date();
	if(d.indexOf("/")!=-1)
	{
		first=d.indexOf("/");
		second=d.lastIndexOf("/");
		if(second==first) return false;
		yy=parseInt(d.substring(0,first));
		if ( d.substr(first + 1, 1) == '0' )
			mm=parseInt(d.substring(first+2,second));
		else
			mm=parseInt(d.substring(first+1,second));
		if ( d.substr(second + 1, 1) == '0' )
			dd=parseInt(d.substring(second+2,d.length));
		else
			dd=parseInt(d.substring(second+1,d.length));
		if (isNaN(yy)) { //Error Year Format
			return false;
		}
		if (yy<30)
			yy += 2000;
		else if (yy <100 && yy >= 30)
			yy += 1900;
		if( yy < 1900 || yy>2069) return false;
		if (isNaN(mm) || mm < 1 || mm > 12) { //Error Month Format
			return false;
		}
		if (isNaN(dd) || dd < 1 || dd > 31) { //Error Month Format
			return false;
		}
		d = new Date(yy, mm - 1, dd); //Test the Date
		if (isNaN(d)) { //Error Date Format
			return false;
		}
		if (d.getMonth() != mm - 1 || d.getDate() != dd) { //invalid date such as '1999/02/29' and '1999/04/31'
			return false;
		}
		if ( yy + 16 > today.getFullYear() ) return false;
		return d.toLocaleString();  //Return the Date in parsed format
	}
	else if(d.indexOf("-")!=-1)
	{
		first=d.indexOf("-");
		second=d.lastIndexOf("-");
		if(second==first) return false;
		yy=parseInt(d.substring(0,first));
		if ( d.substr(first + 1, 1) == '0' )
			mm=parseInt(d.substring(first+2,second));
		else
			mm=parseInt(d.substring(first+1,second));
		if ( d.substr(second + 1, 1) == '0' )
			dd=parseInt(d.substring(second+2,d.length));
		else
			dd=parseInt(d.substring(second+1,d.length));
		if (isNaN(yy)) { //Error Year Format
			return false;
		}
		if (yy<30)
			yy += 2000;
		else if (yy <100 && yy >= 30)
			yy += 1900;
		if( yy < 1950 || yy>2069) return false;
		if (isNaN(mm) || mm < 1 || mm > 12) { //Error Month Format
			return false;
		}
		if (isNaN(dd) || dd < 1 || dd > 31) { //Error Month Format
			return false;
		}
		d = new Date(yy, mm - 1, dd); //Test the Date
		if (isNaN(d)) { //Error Date Format
			return false;
		}
		if (d.getMonth() != mm - 1 || d.getDate() != dd) { //invalid date such as '1999/02/29' and '1999/04/31'
			return false;
		}
		if ( yy + 16 > today.getFullYear() ) return false;
		return d.toLocaleString();  //Return the Date in parsed format
	}
	else
		return false;
}

function isInt(n) {
	var i = parseInt(n*1);
	if (i == NaN) {
		return false;
	}
	if (i != n){
		return false;
	}
	return true;
}


function isMail(str) {
	if (trim(str) == ""){
		return true;
	}
    var a=str.indexOf("@")+1;
    var p=str.indexOf(".")+1;
    if(str.indexOf("'") > 0)
		return false;
	if(str.indexOf('"') > 0)
		return false;
    if (a<2)
       return false;
    if (p<1)
       return false;
    if (p<a+2)
       return false;
    if (str.length==p)
       return false;
    return true;
}

function isFloat(str) {
	var ch=str.charAt(0);
	if( ch == "." ) return false;
    for (var i=0; i < str.length; i++)
	{	ch=str.charAt(i);
		if ((ch != ".") && (ch != "0") && (ch != "1") && (ch != "2") && (ch != "3") && (ch != "4") && (ch != "5") && (ch != "6") && (ch != "7") && (ch != "8") && (ch != "9"))
			return false;
	}
    return true;
}

function isNumber(str) {
    for (var i=0; i < str.length; i++)
	{	var ch=str.charAt(i);
		if ((ch != "0") && (ch != "1") && (ch != "2") && (ch != "3") && (ch != "4") && (ch != "5") && (ch != "6") && (ch != "7") && (ch != "8") && (ch != "9"))
			return false;
	}
    return true;
}

function CheckUserInput(vstrInput) {
	var intIndex;
	var intCharCount;
	for(intIndex = 0; intIndex < vstrInput.length; intIndex++){
		if (vstrInput.charCodeAt(intIndex) < 48)
			return false;
		if ((vstrInput.charCodeAt(intIndex) > 57) && (vstrInput.charCodeAt(intIndex) < 64))
			return false;
		if ((vstrInput.charCodeAt(intIndex) > 90) && (vstrInput.charCodeAt(intIndex) < 97))
			return false;
		if (vstrInput.charCodeAt(intIndex) > 122)
			return false;
	}
	return true;
}
function isPhone(str){
	var intIndex;
	var intCharCount;
	for(intIndex = 0; intIndex < str.length; intIndex++){
		if(str.charCodeAt(intIndex) < 32)
			return false;
		if(str.charCodeAt(intIndex) == 34)
			return false;
		if(str.charCodeAt(intIndex) == 39)
			return false;
		if(str.charCodeAt(intIndex) > 126)
			return false;
	}
	return true;
}

/*
	函数名称：checkString()
	函数功能: 不能包含&、’、”、<、>、:、;等特殊字符;
		合法字符：32（空格）、48~57（数字）、65~90（大写字符）、95（下划线）、97~122（小写字符）、>127（汉字）。
	传入参数：字符串变量
	传出结果：处理后的子串
*/
function checkString(str){
	var strChar = str;
	var isValid = true;
	for (var i = 0; i < str.length; i++){
		if ( (str.charCodeAt(i) == 32) || ((str.charCodeAt(i) >= 48) && (str.charCodeAt(i) <= 57)) || ((str.charCodeAt(i) >= 65) && (str.charCodeAt(i) <= 90)) || (str.charCodeAt(i) == 95) || ((str.charCodeAt(i) >= 97) && (str.charCodeAt(i) <= 122)) || (str.charCodeAt(i) > 127) ) {
			// do nothing
		} else {
			isValid = false;
			break;
		}
	}
	return isValid;
}

/*
	函数名称：CheckPostCode(str)
	函数功能: 检查邮编的合法性
	传入参数：str——输入字符
	传出结果：true or false
*/
function CheckPostCode(str){
	if (trim(str) == ""){
		return true;
	}
	for (var i=0; i < str.length; i++){
		var ch=str.charAt(i);
		if ((ch != "0") && (ch != "1") && (ch != "2") && (ch != "3") && (ch != "4") && (ch != "5") && (ch != "6") && (ch != "7") && (ch != "8") && (ch != "9"))
			return false;
		else
			return true;
	}
}

function maxwin(){
     var larg=screen.availWidth;
     var altez=screen.availHeight;
     self.resizeTo(larg,altez);
     self.moveTo(0,0);
}
function handleEnter (field, event) {
  var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
  if (keyCode == 13) {
  var i;
  for (i = 0; i < field.form.elements.length; i++)
    if (field == field.form.elements[i])
      break;
      i = (i + 1) % field.form.elements.length;
      field.form.elements[i].focus();
      return false;
    }
    else
  return true;
}

function  passwordcheck(val){
  if(val=="88888888"){
    return true ;
  }
  else
  {
    return false ;
  }
}
//用于控制鼠标进出
function rollIn(el)
{
  var ms = navigator.appVersion.indexOf("MSIE");
  ie4 = (ms>0) && (parseInt(navigator.appVersion.substring(ms+5, ms+6)) >= 4)
  if(ie4)
  {
    //el.initstyle=el.style.cssText;
    el.style.cssText=el.fprolloverstyle;
  }
}
function rollOut(el)
{
  var ms = navigator.appVersion.indexOf("MSIE");
  ie4 = (ms>0) && (parseInt(navigator.appVersion.substring(ms+5, ms+6)) >= 4)
  if(ie4){
     el.style.cssText=el.fprolloverstyle2;
  }
}

//判断客户显示器分辨率
function  screen_check(){
   var correctwidth=1024;
   var correctheight=768;
   if (screen.width!=correctwidth||screen.height!=correctheight){
      alert("本系统最佳分辨率: "+correctwidth+"*"+correctheight+". 您当前的分辨率是:"+screen.width+"*"+screen.height+"。设置合适的分辨率才能取得最佳的显示效果！")
      return ;
   }
}


function ajaxMethod(url)
{
	if(window.XMLHttpRequest){
		req=new XMLHttpRequest();
	}else if(window.ActiveXObject){
		req=new ActiveXObject("Microsoft.XMLHTTP");
	}
	if(req){
		req.open("GET",url,true);
		req.onreadystatechange=callback;
		req.send(null);
		}
	}
			
function callback(){
	if(req.readyState == 4){
		if(req.status == 200){
			document.getElementById("results").innerHTML=req.responseText;
		}else{
			alert("Not able to retrieve description"+req.statusText);
		}
	}
}

function DoCal(elTarget) {
  if (!window.showModalDialog)	return;
  var sRtn;
  //指定起始、结束年份以及缺省日期
  var defaultValue = elTarget.value;
  if(defaultValue == "")
  {
    var mydate=new Date();
    var year = mydate.getYear();
    var month = mydate.getMonth()+1;
    var date = mydate.getDate();
    var time=year+"-"+month+"-"+date;
    var defaultValue=time;
  }
  sRtn = showModalDialog("../include/calendar.jsp?beginYear=1920&endYear=2020&defaultDate=" + defaultValue, "", "help=no;status=no;center=yes;dialogWidth=190pt;dialogHeight=175pt");
  if (sRtn!="")
	elTarget.value = sRtn;
}
