<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<html>
<head>
	<title>经费报销管理</title>
	<s:head template="ecside"/>
</head>
<body>
	<s:include value="/apps/pageHeader.jsp">
		<s:param name="fb_title">系统管理-未审批的经费报销单</s:param>
	</s:include>
	<s:url id="dissent" action="wipe_dissent" includeParams="none" namespace="/"/>
	<s:url id="reject" action="wipe_reject" includeParams="none" namespace="/"/>
	<s:url id="confirm" action="wipe_confirm" includeParams="none" namespace="/"/>
	<s:url id="monitorUrl" action="wipe_monitor" includeParams="none" namespace="/"/>
	<s:url id="prepareJudge" action="wipe_prepareJudge" includeParams="none" namespace="/"/>	
	<s:url id="reApplay" action="wipe_reApply" includeParams="none" namespace="/"/>
	
	<ec:table items="weiTaskList" var="task" action="./wipe_weiShenPiList.action" width="100%" listWidth="100%" resizeColWidth="true" doPreload="false">
	<ec:row>
	<ec:column property="wipe.wCode" title="经费编号" style="text-align:center"/>
	<ec:column property="wipe.wUser.RName" title="作成者" style="text-align:center"/>
	<ec:column property="wipe.wApTime" title="作成日期" style="text-align:center" cell="date"/>
	<ec:column property="wipe.wTotal" title="总金额" style="text-align:center"/> 				
	<ec:column property="task.id" title="操作" width="120" style="text-align:center" >
	<!--  
	<s:if test="%{#attr.task.task.name=='填写经费报销'}">
	  <s:a href="%{reApplay}?wCode=%{#attr.task.wipe.wCode}">重新申请</s:a>
	</s:if>	

	
	<s:if test="%{#attr.task.task.name=='填写经费报销'}">
	  <s:a href="%{reApplay}?key=%{#attr.task.wipe.id}&&taskId=%{#attr.task.task.id}">重新申请</s:a>
	</s:if>	
    <s:else>
     <s:a href="%{prepareJudge}?taskId=%{#attr.task.task.id}&&judge=confirm">批准</s:a>
     <s:a href="%{prepareJudge}?taskId=%{#attr.task.task.id}&&judge=dissent" >不批准</s:a>
     <s:a href="%{prepareJudge}?taskId=%{#attr.task.task.id}&&judge=reject">驳回</s:a>
     </s:else>
   	-->  
     <img src="<s:property value="imgRootUrl"/>find.png" width="16" height="16" /><s:a href="%{prepareJudge}?taskId=%{#attr.task.task.id}">审查</s:a>
    </ec:column>	   	

<ec:column property="task.id" title="追踪" width="80" style="text-align:center">
	 <img src="<s:property value="imgRootUrl"/>camera.png" width="16" height="16" />&nbsp;<s:a href="%{monitorUrl}?wId=%{#attr.task.wipe.id}">追踪</s:a>
</ec:column> 
</ec:row>
</ec:table>
<s:include value="/apps/pageFooter.jsp"/>
</body>
<SCRIPT type="text/javascript">
function sel(url){
	var rev = window.showModalDialog(url, null, "dialogHeight:690px;dialogWidth:830px;help:0;status:0;scroll:0;resizable:1");
}
function check(url)
{
   var rev = window.showModalDialog(url, null, "dialogHeight:650px;dialogWidth:700px;help:0;status:0;scroll:0;resizable:1");
}
</SCRIPT>
</html>