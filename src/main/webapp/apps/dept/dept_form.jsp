<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<title>部门表单</title>
<link rel="stylesheet" href="<s:url value='/css/form.css' includeParams='none' encode='false' />" type="text/css"/>
<style type="text/css">
<!--
BODY{margin:5px;}
-->
</style>
<s:head template="jquery" id="dept_save"/>
</head>
<body>
<s:url id="imgRootUrl" value="/images/" includeParams="none" />
<s:url id="addUrl" action="dept_prepareForAdd" includeParams="none" namespace="/">
	<s:param name="dept.parent" value="dept.id"/>
</s:url>
<s:form action="dept_save" namespace="/" target="deptEndFrm">
<s:token/>
<table width="400px;" cellpadding="0" cellspacing="1" class="form">
	<thead>
		<tr>
			<td colspan="2">
				<s:if test="dept.id != null">修改部门信息</s:if>
				<s:else>添加部门信息</s:else>				
			</td>
			<s:hidden name="dept.id"/>
			<s:hidden name="dept.parent"/>
		</tr>
	</thead>
	<tbody>
		<tr><td>部门名称</td><td><s:textfield name="dept.name" theme="simple" cssClass="required"/></td></tr>
		<tr><td>部门代号</td><td><s:textfield name="dept.alias" theme="simple" maxlength="2" cssClass="required"/></td></tr>
		<tr><td>联系电话</td><td><s:textfield name="dept.tel" theme="simple" cssClass="phone"/></td></tr>
		<s:if test="dept.id != null">
			<tr><td colspan="2" style="text-align:center;"><s:a href="%{addUrl}">点击此处添加子部门</s:a></td></tr>
		</s:if>	
		<s:if test="parentDept != null">
			<tr><td>上级部门</td><td><s:property value="parentDept.name"/></td></tr>
		</s:if>	
	</tbody>
	<tfoot>
		<tr>
			<td colspan="2">
				<s:submit value="保存" theme="simple"/>&nbsp;&nbsp;<s:reset value="重置" theme="simple"/>
				<s:if test="dept.id != null">&nbsp;&nbsp;<input id="delBtn" type="button" value="删除"></s:if>
			</td>
		</tr>
	</tfoot>
</table>
</s:form>
<iframe name="deptEndFrm" src="about:blank" style="display:none"></iframe>
</body>
<script type="text/javascript">
$(function(){
	$("input[name='dept.alias']").blur(function(){
		$(this).val($(this).val().toUpperCase());
	});
	
	$("#delBtn").click(function(){
		if(window.confirm('确定删除【<s:property value="dept.name"/>】吗?')){
	 		$.post('<s:url action="dept_delete" includeParams="none" namespace="/"/>', {"key":$("input[name='dept.id']").val()} ,function(m){
	 			var o = eval('(' + m + ')');
	 			if(o.error){
	 				window.alert(o.error);
	 			}else if(o.del == true){
	 				parent.location.reload();
	 			}
	 		});	
		}
	});
});
</script>
</html>