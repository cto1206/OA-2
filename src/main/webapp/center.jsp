﻿<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<title>港盛联合禀议系统</title>
<s:head template="jquery"/>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<style> 
.navPoint { 
COLOR: white; CURSOR: hand; FONT-FAMILY: Webdings; FONT-SIZE: 9pt 
} 
</style> 
<script>
function switchSysBar(){ 
var locate=location.href.replace('center.html','');
var ssrc=document.all("img1").src.replace(locate,'');
if (ssrc=="images/main_41.gif")
{ 
document.all("img1").src="images/main_41_1.gif";
document.all("frmTitle").style.display="none" 
} 
else
{ 
document.all("img1").src="images/main_41.gif";
document.all("frmTitle").style.display="" 
} 
} 
</script>
</head>

<body style="overflow:hidden">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="171" id=frmTitle noWrap name="fmTitle" align="center" valign="top">
	<iframe name="I1" height="100%" width="171" src="left.jsp" border="0" frameborder="0" scrolling="no">
	浏览器不支持嵌入式框架，或被配置为不显示嵌入式框架。</iframe>	</td>
    <td width="9" valign="middle"  bgcolor="#0a5c8e" onclick=switchSysBar()><SPAN class=navPoint 
id=switchPoint title=关闭/打开左栏><img src="images/main_41.gif" name="img1" width=9 height=52 id=img1></SPAN></td>
    <td align="center" valign="top"><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" style="table-layout:fixed;">
      <tr>
        <td height="8" style=" line-height:8px;"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="table-layout:fixed;">
          <tr>
            <td width="14"><img src="images/main_24.gif" width="14" height="8"></td>
            <td background="images/main_26.gif" style="line-height:8px;">&nbsp;</td>
            <td width="7"><img src="images/main_28.gif" width="7" height="8"></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" style="table-layout:fixed;">
          <tr>
            <td>
            	<iframe id="contentFrame" name="contentFrame" height="100%" width="100%" src="<s:url action="indexMessage_getIndexMessage" includeParams="none" namespace="/"/>" border="0" frameborder="0" scrolling="no"> 浏览器不支持嵌入式框架，或被配置为不显示嵌入式框架。</iframe>
            </td>
            <td width="3" style="width:3px; background:#0a5c8e;">&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="12" style="line-height:12px;"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="table-layout:fixed;">
          <tr>
            <td width="14" height="12"><img src="images/main_46.gif" width="14" height="12"></td>
            <td background="images/main_48.gif" style="line-height:12px;">&nbsp;</td>
            <td width="7"><img src="images/main_50.gif" width="7" height="12"></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
<script type="text/javascript">
window.onbeforeunload = function(){
	var n = window.event.screenX - window.screenLeft;   
	var b = n > document.documentElement.scrollWidth - 20; 
	if(b && window.event.clientY < 0 || window.event.altKey){   
    	window.event.returnValue = "";
    	$.post('<s:url action="index_unload" includeParams="none" namespace="/"/>');
	}	       
}   
</script>
</html>