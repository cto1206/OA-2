<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<html>
<head>
<title>角色管理</title>
<s:head template="ecside"/>


</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<s:include value="/apps/pageHeader.jsp">
		<s:param name="fb_title">系统管理-角色管理</s:param>
		<s:param name="fb_add"><s:url action="role_prepareForAdd" includeParams="none" namespace="/"/></s:param>
	</s:include>
		<ec:table var="role" items="page.result" doPreload="false" action="./role_list.action" width="100%" listWidth="100%" resizeColWidth="true">
			<ec:row >
				<ec:column property="roleId" title="编号" style="text-align:center" width="10%"/>
				<ec:column property="roleName" title="角色名称" width="20%"/>
				<ec:column property="memo" title="描述" sortable="false"/> 
		       	<ec:column title="操作" width="12%" property="id" sortable="false" style="text-align:center">
			    	<img src="<s:property value="imgRootUrl"/>edt.gif" width="16" height="16" /><a href="role_prepareForEdit.action?key=<s:property value='%{#attr.role.roleId}'/>">修改</a>           
                 	<img src="<s:property value="imgRootUrl"/>del.gif" width="16" height="16" /><a href="role_delete.action?key=<s:property value='%{#attr.role.roleId}'/>">删除</a>
		        </ec:column>
			 </ec:row>
	  </ec:table>
<s:include value="/apps/pageFooter.jsp"/>
</table>
</body>

</html>