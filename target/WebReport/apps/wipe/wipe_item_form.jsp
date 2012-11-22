<%@ page language="java" pageEncoding="UTF-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.hanbang.core.utils.ActionUtil;"%>
<html>
<head>
	<title>经费报销项目表单</title>
	<link rel="stylesheet" href="<s:url value='/css/form.css' includeParams='none' encode='false' />" type="text/css"/>
	<s:head template="jquery" />
	<s:head template="messager" />
</head>
<body>
	<s:include value="/apps/pageHeader.jsp">
		<s:param name="fb_title">系统管理-经费报销项目表单</s:param>
		<s:param name="fb_add">#</s:param>
		<s:param name="fb_edit">#</s:param>
		<s:param name="fb_del">#</s:param>
	</s:include>
		<s:form action="wipeItem_save" namespace="/" theme="simple">
		<table width="400px;" cellpadding="0" cellspacing="1" class="form">
			<thead>
				<tr>
					<td colspan="4"><s:property value="title"/></td>
					<s:hidden name="wipeItem.id"/>
				</tr>
			</thead>
			<tbody>										
				<tr>
				    <!--  经费报销编号下拉列表,首先应该从action里面，然后再传入这个页面。-->
				    <td>经费报销编号</td><td><s:select name="wipeItem.wipe.id"
					list="wipelist" listKey="id" listValue="wCode" theme="simple"
					cssClass="required" /></td></tr>
				
				<tr><td>经费项目</td><td><s:textfield name="wipeItem.iItem" theme="simple" cssClass="required" maxlength="25"/></td></tr>
				
				<tr><td>项目总金额</td><td><s:textfield name="wipeItem.iMoney" theme="simple" cssClass="required number"/></td></tr>	
				
				<tr><td colspan="2" align="right"><input type="button" value="保存" id="okBtn" ></td></tr>		
				</tbody>

	
		</table>
		</s:form>
	<s:include value="/apps/pageFooter.jsp"/>
</body>
<script type="text/javascript">
	$("#okBtn").click(function(){
		if($("#wipeItem_save").valid()){
			$.messager.prompt('禀议码验证', '请输入禀议码!', function(val){
				if (val){
			 		$.post('<s:url action="ringi_checkCode" includeParams="none" namespace="/"/>', {"ringiShoCode":val} ,function(text){
			 			var obj = eval(text);
			 			if(obj.checked){
			 				$("#wipeItem_save").submit();
			 			}else{
			 				$.messager.alert('提示信息','禀议码错误!','warning');
			 			}
			 		});						
				}
			}); 
		}
	});

</script>
</html>