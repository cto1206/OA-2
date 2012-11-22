<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<html>
<head>
	<title>用户列表</title>
	<s:head template="ecside"/>
	<link rel="stylesheet" href="<s:url value='/css/list.css' includeParams='none' encode='false' />" type="text/css"/>
</head>
<body>
	<s:include value="/apps/pageHeader.jsp">
		<s:param name="fb_title">系统管理-人员列表</s:param>
		<s:param name="fb_add"><s:url action="user_prepareForAdd" includeParams="none" namespace="/"/></s:param>
	</s:include>
	<s:url id="editUrl" action="user_prepareForEdit" includeParams="none" namespace="/"/>
	<s:url id="delUrl" action="user_delete" includeParams="none" namespace="/"/>
		<ec:table items="page.result" doPreload="false" var="user" action="./user_list.action" sortable="false" width="100%" listWidth="100%" resizeColWidth="true">
			<ec:row>
				<ec:column property="name" title="用户名" width="15%" style="text-align:center"/>
				<ec:column property="RName" title="真实姓名" width="20%" style="text-align:center"/>
				<ec:column property="sex" title="性别" width="10%" style="text-align:center">
					<s:if test="%{#attr.user.sex == 1}">男</s:if>
					<s:elseif test="%{#attr.user.sex == 2}">女</s:elseif>
				</ec:column>
				<ec:column property="tel" width="20%" title="联系电话"/>
				<ec:column property="birthday" width="20%" title="出生日期" cell="date" sortable="true" style="text-align:center"/>
				<ec:column title="操作" width="15%" property="id" style="text-align:center">
					<img src="<s:property value="imgRootUrl"/>edt.gif" width="16" height="16" /><s:a href="%{editUrl}?key=%{#attr.user.id}">编辑</s:a>
					<img src="<s:property value="imgRootUrl"/>del.gif" width="16" height="16" /><s:a href="javascript:del(%{#attr.user.id})">删除</s:a>
				</ec:column>				
			</ec:row>
		</ec:table>
	<s:include value="/apps/pageFooter.jsp"/>
</body>
<script type="text/javascript">
function del(key){
	if(window.confirm("确定删除这条记录吗？")){
		window.location = '<s:property value="%{delUrl}"/>?key=' + key; 
	}
}
</script>
</html>