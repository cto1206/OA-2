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
		<s:param name="fb_title">系统管理-驳回禀议列表</s:param>
	</s:include>
	<s:url id="editUrl" action="ringi_edit" includeParams="none" namespace="/"/>
	<s:url id="delUrl" action="ringi_delete" includeParams="none" namespace="/"/>
		<ec:table items="ringiShoTaskList" var="rt" action="./ringi_rejectTasks.action" toolbarContent="navigation|refresh|status" sortable="false" width="100%" listWidth="100%" resizeColWidth="true">
			<ec:row>
				<ec:column property="ringiSho.title" width="15%" title="归属" style="text-align:center">
					<s:if test="%{#attr.rt.ringiSho.title == 1}">汉邦钢构</s:if>
					<s:elseif test="%{#attr.rt.ringiSho.title == 2}">港盛涂装</s:elseif>					
					<s:elseif test="%{#attr.rt.ringiSho.title == 3}">建力设备</s:elseif>					
					<s:elseif test="%{#attr.rt.ringiSho.title == 4}">港盛联合</s:elseif>					
				</ec:column>
				<ec:column property="ringiSho.sub" title="禀议主题" ellipsis="true"/>
				<ec:column property="ringiSho.user.RName" width="13%" title="作成者" style="text-align:center"/> 
				<ec:column property="ringiSho.date" width="15%" title="作成日期" cell="date" style="text-align:center"/> 
				<ec:column property="ringiSho.needDate" width="15%" title="需求日期" cell="date" style="text-align:center"/>
				<ec:column property="task.id" title="操作" width="12%" style="text-align:center">
					<img src="<s:property value="imgRootUrl"/>edt.gif" width="16" height="16" /><s:a href="%{editUrl}?taskId=%{#attr.rt.task.id}">修改</s:a>
					<img src="<s:property value="imgRootUrl"/>del.gif" width="16" height="16" /><s:a href="javascript:del(%{#attr.rt.task.id})">撤销</s:a>
				</ec:column>				
			</ec:row>
		</ec:table>
	<s:include value="/apps/pageFooter.jsp"/>
</body>
<script type="text/javascript">
function del(taskId){
	if(window.confirm("确定撤销这条禀议吗？")){
		window.location = '<s:property value="%{delUrl}"/>?taskId=' + taskId; 
	}
}
</script>
</html>