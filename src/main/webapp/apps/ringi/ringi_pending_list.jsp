<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<html>
<head>
	<title>禀议报告表单</title>
	<s:head template="ecside"/>
	<link rel="stylesheet" href="<s:url value='/css/list.css' includeParams='none' encode='false' />" type="text/css"/>
</head>
<body>
	<s:include value="/apps/pageHeader.jsp">
		<s:param name="fb_title">系统管理-待办禀议列表</s:param>
	</s:include>
	<s:url id="checkUrl" action="ringi_prepareForEdit" includeParams="none" namespace="/"/>
	<s:url id="viewUrl" action="ringi_review" includeParams="none" namespace="/"/>
		<ec:table items="ringiShoTaskList" var="rt" action="./ringi_pendingTasks.action" toolbarContent="navigation|refresh|status" sortable="true" width="100%" listWidth="100%" resizeColWidth="true">
			<ec:row>
				<ec:column property="ringiSho.title" width="15%" title="归属" style="text-align:center">
					<s:if test="%{#attr.rt.ringiSho.title == 1}">汉邦钢构</s:if>
					<s:elseif test="%{#attr.rt.ringiSho.title == 2}">港盛涂装</s:elseif>					
					<s:elseif test="%{#attr.rt.ringiSho.title == 3}">建力设备</s:elseif>					
					<s:elseif test="%{#attr.rt.ringiSho.title == 4}">港盛联合</s:elseif>					
				</ec:column>
				<ec:column property="ringiSho.sub" title="禀议主题" ellipsis="true"/>
				<ec:column property="ringiSho.user.RName" width="15%" title="作成者" style="text-align:center" sortable="false"/> 
				<ec:column property="ringiSho.date" width="15%" title="作成日期" cell="date" style="text-align:center"/> 
				<ec:column property="ringiSho.needDate" width="15%" title="需求日期" cell="date" style="text-align:center"/>
				<ec:column property="task.id" title="操作" width="10%" style="text-align:center">
					<img src="<s:property value="imgRootUrl"/>find.png" width="16" height="16" /><s:a href="%{viewUrl}?taskId=%{#attr.rt.task.id}">审查</s:a>
				</ec:column>				
			</ec:row>
		</ec:table>
	<s:include value="/apps/pageFooter.jsp"/>
</body>
</html>