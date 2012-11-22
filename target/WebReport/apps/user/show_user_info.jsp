<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户信息</title>
	<s:head template="jquery"/>
	
	
	<script type="text/javascript">
		$(document).ready(function(){  	
        $(".info tr").mouseover(function(){  
                $(this).addClass("over");}).mouseout(function(){ 
                $(this).removeClass("over");})  	
        $(".info tr:even").addClass("alt");
                	
			});

	</script>
	<style type="text/css">
		td {
		        padding:6px 20px;
		        border-bottom:1px solid #95bce2;
		        vertical-align:top;
		        text-align:left;
		}
		 
		td * {
		        padding:6px 20px;
		}
		 
		tr.alt td {
		        background:#ecf6fc;  
		}
		 
		tr.over td {
		        background:#bcd4ec;  
		}
 
</style>
</head>
<body>
		<s:set name="curUser" value="#session[@com.hanbang.core.utils.Constants@LOGIN_INFO]" scope="page"/>
		<table class="info" width="50%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>用户账号：</td>
			<td>
			<s:property value="#attr.curUser.name" />
			</td>
		</tr>
		
		<tr>
			<td>真实姓名：</td>
			<td><s:property value="%{#attr.curUser.rName}"/></td>
		</tr>
		
		<tr>
			<td>用户角色：</td>
			<td><s:property value="%{#attr.curUser.role.roleName}"/></td>
		</tr>
		
		<tr>
			<td>用户性别：</td>
			<td>
				<s:if test="#attr.curUser.sex == 1">
					男
				<s:else>
					女
				</s:else>	
				</s:if>
			
			</td>
		</tr>
		<tr>
			<td>联系电话：</td>
			<td><s:property value="#attr.curUser.tel"/></td>
		</tr>
		
		<tr>
			<td>出生日期：</td>
			<td>
				<s:date name="%{#attr.curUser.birthday}" format="yyyy-MM-dd"/>
		</tr>
		
		<tr>
			<td></td>
			<td></td>
		</tr>
		</table>
		
</body>
</html>