<%@ page language="java" pageEncoding="UTF-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.hanbang.core.utils.ActionUtil;"%>
<html>
<head>
	<title>经费报销项目明细表单</title>
	<link rel="stylesheet" href="<s:url value='/css/form.css' includeParams='none' encode='false' />" type="text/css"/>
	<s:head template="jquery" />
	<s:head template="messager" />
</head>

<body>
<s:include value="/apps/pageHeader.jsp">
	<s:param name="fb_title">系统管理-经费报销项目明细表单</s:param>
	<s:param name="fb_add">#</s:param>
	<s:param name="fb_edit">#</s:param>
	<s:param name="fb_del">#</s:param>
</s:include>
<s:form action="wipeItemDetail_save" namespace="/" theme="simple">
	<table width="400px;" cellpadding="0" cellspacing="1" class="form">
		<thead>
			<tr>
				<td colspan="4"><s:property value="title" /></td>
				<s:hidden name="wipeItemDetail.id" />
			</tr>
		</thead>
		<tbody>

			<tr>
				<td colspan="4" align="left">费用报销项目明细表单</td>
			</tr>

			<tr>
				<td>经费项目</td>
				<td><s:select name="wipeItemDetail.wipeItem.id"
					list="wipeItemList" listKey="id" listValue="iItem"
					cssClass="required" theme="simple" /></td>

			</tr>

			<tr>
				<td>日期</td>
				<td><s:textfield name="wipeItemDetail.itemDetailDate"
					theme="simple"
					onfocus="WdatePicker({isShowClear:false,readOnly:true})"
					cssClass="required Wdate dateISO" /></td>
			</tr>
			<tr>
				<td>报销金额</td>
				<td><s:textfield name="wipeItemDetail.itemDetailMoney"
					cssClass="required number" maxlength="25" /></td>

			</tr>

			<tr>
				<td>摘要</td>
				<td><s:textfield name="wipeItemDetail.itemDetailBrief" /></td>
			</tr>

			<tr>
				<td>备注</td>
				<td colspan="3"><s:textarea
					name="wipeItemDetail.itemDetailRemark" theme="simple" rows="3" /></td>
			</tr>
		<tfoot>
			<tr>
				<td colspan="4" align="right"><input type="button" value="保存" id="okBtn" ></td>
			</tr>
		</tfoot>

	</table>
</s:form>
<s:include value="/apps/pageFooter.jsp" />
</body>
<script type="text/javascript">
	$("#okBtn").click(function(){
		if($("#wipeItemDetail_save").valid()){
			$.messager.prompt('禀议码验证', '请输入禀议码!', function(val){
				if (val){
			 		$.post('<s:url action="ringi_checkCode" includeParams="none" namespace="/"/>', {"ringiShoCode":val} ,function(text){
			 			var obj = eval(text);
			 			if(obj.checked){
			 				$("#wipeItemDetail_save").submit();
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