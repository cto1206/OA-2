<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<html>
<head>
	<title>流程列表</title>
	<s:head template="ecside"/>
</head>
<body>
	<s:include value="/apps/pageHeader.jsp">
		<s:param name="fb_title">系统管理-流程列表</s:param>
		<s:param name="fb_add"><s:url action="flow_prepare" includeParams="none" namespace="/"/></s:param>
		<s:param name="fb_edit">#</s:param>
		<s:param name="fb_del">#</s:param>
	</s:include>
	<s:url id="delUrl" action="flow_remove" includeParams="none" namespace="/"/>
		<ec:table items="pdList" var="pd" action="./flow_list.action" sortable="false" width="100%" listWidth="100%" resizeColWidth="true">
			<ec:row>
				<ec:column property="id" title="ID" style="text-align:center"/>
				<ec:column property="key" title="主键" style="text-align:center"/>
				<ec:column property="name" title="名称" style="text-align:center"/>
				<ec:column property="version" title="版本" style="text-align:center"/>
				<ec:column title="操作" property="deploymentId" style="text-align:center">
					<s:a href="%{delUrl}?key=%{#attr.pd.deploymentId}">删除</s:a>
				</ec:column>				
			</ec:row>
		</ec:table>
	<s:include value="/apps/pageFooter.jsp"/>
</body>
</html>