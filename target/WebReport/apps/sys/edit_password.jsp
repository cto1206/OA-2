<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<s:set name="curUser" value="#session[@com.hanbang.core.utils.Constants@LOGIN_INFO]" scope="page"/>
<html>
	<head>
		<title>口令维护</title>
		
	<link rel="stylesheet" type="text/css" href="/csslib/style.css">
	<!-- 
		<script Language="JavaScript" src="/common/jslib/function.js"></script>
	 -->
	
		<script language="javascript">
		function trim(str){
			return str.replace(/(^\s*)|(\s*$)/g, "");
		}
		
		function ignoreSpaces(string) {
		  var temp = "";
		  string = '' + string;
		  splitstring = string.split(" "); //双引号之间是个空格；
		  for(i = 0; i < splitstring.length; i++)
		     temp += splitstring[i];
		  return temp;
		}
		
		function init(){
  			if(form1.message.value != ""){
   				 alert(form1.message.value);
  			}
  			form1.oldPwd.focus();
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
		
		
		function sslogin(field, event) {
  			var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
  			if (keyCode == 13) { rtnSubmit();}
  		return true;
		}
		
		
		
		function rtnSubmit() {
    		form1.oldPwd.value=ignoreSpaces(form1.oldPwd.value);
   			form1.newPwd.value=ignoreSpaces(form1.newPwd.value);
   			form1.newPwd2.value=ignoreSpaces(form1.newPwd2.value);
    		if(trim(form1.oldPwd.value)=="") {
      			alert("请输入旧口令");
      			form1.oldPwd.focus();
      			return false ;
    		}
    		
    		if(trim(form1.newPwd.value)=="") {
      			alert("请输入新口令");
		      	form1.newPwd.value="";
		      	form1.newPwd2.value="";
		      	form1.newPwd.focus();
		      	return false;
    		}
    		
		    if(form1.newPwd.value!=form1.newPwd2.value){
			  alert("新口令输入不一致，请重新输入");
		          form1.newPwd2.value="";
			  form1.newPwd2.focus();
			  return false ;
		   }
		   
		   if (trim(form1.newPwd.value).length=0 || trim(form1.newPwd.value).length<5){
		    alert("为了确保安全，您的口令位数应该在五位以上，请重输！");
		    form1.newPwd.focus();
		    return false;
		  }
		  
		   var tj=form1.newPwd.value;
		   form1.submit();
 	}
 	
	function reset1(){
	   form1.oldPwd.value="";
	   form1.newPwd.value="";
	   form1.newPwd2.value="";
	   form1.oldPwd.focus();
	}
</script>
</head>
<!--  

	 form1.action = "";
	'<s:property value="%{editPwd}"/>?key=%{#attr.user.id}' 
	<s:url id="editPwd" action="user_modifyPwd" includeParams="none" namespace="/"/>
	
-->

	<body onload="init()">
		<br><br><br><br><br><br>
		
		<s:form name="form1" action="index_savepwd">
 			<s:hidden  name="message" />
  			<table  width="35%" border="0" align="center">
   				<tr>
      				<td align=left>修改口令 </td>
  			   </tr>
  			</table>
  		<p align=center><hr width="35%" size="1" color=black>
  		
	  <table width="35%" border="0" align="center">
	  	 <s:fielderror/>
	    <tr height=25>
	      <td nowrap>请输入旧口令：</td>
	      <td><s:password name="oldPwd"   maxlength="10" size="20" onkeypress="return handleEnter(this, event)" theme="simple"/></td>	 
	    </tr>
	    <tr height=25>
	      <td nowrap>请输入新口令：</td>
	      <td><s:password name="newPwd"   maxlength="10" size="20" onkeypress="return handleEnter(this, event)" theme="simple"/></td>
	    </tr>
	    <tr height=25>
	      <td nowrap>请确认新口令：</td>
	      <td><s:password name="newPwd2"  maxlength="10" size="20" onkeypress="return sslogin(this, event)" theme="simple"/> </td>
	    </tr>
	  </table>
  	
  		<p align=center><hr width="35%" size="1" color=black>
  	
	  	
	  <table width="35%" border="0" align="center">
	     <tr height=25 align=center>
	      <td align=center>
	          <input name="BtnSave" type="button" style="cursor:hand" class="button1" id="BtnSave" value="确&nbsp;定" onclick="rtnSubmit()">&nbsp;&nbsp;
	          <input type="reset" style="cursor:hand" class="button1" name="Submit2" value="重&nbsp;填" onclick="reset1()">
	      </td>
	    </tr>
	 </table>
</s:form>
</body>
</html>

