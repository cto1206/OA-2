<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<title>禀议报告表单</title>
	<link rel="stylesheet" href="<s:url value='/css/form.css' includeParams='none' encode='false' />" type="text/css"/>
	<s:head template="jquery"/>
</head>
<body>
	<s:include value="/apps/pageHeader.jsp">
		<s:param name="fb_title">禀议转送</s:param>
	</s:include>
	<center>
		<s:form action="ringi_draft" namespace="/" theme="simple" method="post" enctype="multipart/form-data">
		<table width="380px;" cellpadding="0" cellspacing="1" class="form">
			<tbody>
				<tr>
					<td style="width:90px;">收 件 人</td>
					<td>
						<s:hidden name="ringiSho.flowMan1.id"/>
						<s:textfield name="ringiSho.flowMan1.rName" theme="simple" cssClass="required UserSel" onclick="selUser('ringiSho.flowMan1.id','ringiSho.flowMan1.rName')"/>
					</td>
				</tr>													
			</tbody>
			<tfoot>
				<tr><td colspan="4"><input type="button" value="增加">&nbsp;&nbsp;<input type="button" value="发送" id="saveBtn"></td></tr>
			</tfoot>
		</table>
		</s:form>
	</center>
	<s:include value="/apps/pageFooter.jsp"/>
</body>
<script type="text/javascript">
$(function(){
	$('input.UserSel').each(function(){
		$(this).css('background','#fff url(<s:property value="imgRootUrl"/>users.png) no-repeat right');   
		$(this).css('border','#999 1px solid');
		$(this).css('cursor','pointer');
		$(this).attr('readOnly',true);
	});
});

//人员选择
function selUser(id,name){
	var idField = document.getElementsByName(id)[0];
	var nameField = document.getElementsByName(name)[0];
	var url = '<s:url action="userSel_depts" includeParams="none" namespace="/"/>';
	
	var rev = window.showModalDialog(url, null, "dialogHeight:320px;dialogWidth:480px;help:0;status:0;scroll:0;resizable:1");
	if (rev) {
		idField.value = rev[0];
		nameField.value = rev[1];
	}
}
</script>
</html>