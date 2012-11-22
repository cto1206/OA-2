<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<html>
<head>
<title>经费报销管理</title>
<s:head template="ecside" />
</head>
<body>
<s:include value="/apps/pageHeader.jsp">
	<s:param name="fb_title">系统管理-已审批的经费报销单</s:param>

</s:include>
<s:url id="monitorUrl" action="wipe_monitor" includeParams="none" namespace="/"/>
<ec:table items="wipeList" var="wipe"
	action="./wipe_yiShenPiList.action" width="100%" listWidth="100%"
	resizeColWidth="true" doPreload="false">
	<ec:row>
		<ec:column property="wCode" title="禀议编号" style="text-align:center" />		
		<ec:column property="title" width="15%" title="归属" style="text-align:center">
			<s:if test="%{#attr.wipe.title == 1}">汉邦钢构</s:if>
			<s:elseif test="%{#attr.wipe.title == 2}">港盛涂装</s:elseif>					
			<s:elseif test="%{#attr.wipe.title == 3}">建力设备</s:elseif>					
			<s:elseif test="%{#attr.wipe.title == 4}">港盛联合</s:elseif>					
		</ec:column>				
		<ec:column property="wType" title="类别" style="text-align:center">
		   <s:if test="%{#attr.wipe.wType==1}">部外决裁</s:if>
		   <s:elseif test="%{#attr.wipe.wType==0}">部内决裁</s:elseif>
		</ec:column>
		<ec:column property="wUser.RName" title="作成者" style="text-align:center" />
		<ec:column property="wApTime" title="作成日期" cell="date" style="text-align:center"/>
		<ec:column property="wTotal" title="总金额" style="text-align:center"/>
	   <ec:column property="id" title="追踪" width="80" style="text-align:center">
		    <img src="<s:property value="imgRootUrl"/>camera.png" width="16" height="16" />&nbsp; <s:a href="%{monitorUrl}?wId=%{#attr.wipe.id}">追踪</s:a>
	  </ec:column>  
	</ec:row>
</ec:table>
<s:include value="/apps/pageFooter.jsp" />
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