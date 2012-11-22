<%@ page language="java" pageEncoding="UTF-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<html>
<head>
	<title>经费报销表单</title>
	<s:head template="ecside"/>
	<s:head template="jquery"/>
	<link rel="stylesheet" href="<s:url value='/css/list.css' includeParams='none' encode='false' />" type="text/css"/>
</head>
<body>
<s:include value="/apps/pageHeader.jsp">
	<s:param name="fb_title">系统管理-经费报销列表</s:param>
	<s:param name="fb_add">
		<s:url action="wipe_prepareForAdd" includeParams="none" namespace="/" />
	</s:param>

</s:include>
    <s:url id="edit" action="wipe_prepareForEdit" includeParams="none" namespace="/"/>
    <s:url id="monitorUrl" action="wipe_monitor" includeParams="none" namespace="/"/>
	<s:url id="myPrint" action="wipe_print" includeParams="none" namespace="/"/>
	<s:url id="send" action="wipe_prepareForSend" includeParams="none" namespace="/"/>
	
<ec:table items="page.result" var="wipe" action="./wipe_list.action"  doPreload="false"
	width="100%" listWidth="100%" resizeColWidth="true">
	<ec:row>
		<ec:column property="wCode" title="禀议编号" style="text-align:center" />
		<ec:column property="title" width="15%" title="归属" style="text-align:center">
			<s:if test="%{#attr.wipe.title == 1}">汉邦钢构</s:if>
			<s:elseif test="%{#attr.wipe.title == 2}">港盛涂装</s:elseif>					
			<s:elseif test="%{#attr.wipe.title == 3}">建力设备</s:elseif>					
			<s:elseif test="%{#attr.wipe.title == 4}">港盛联合</s:elseif>					
		</ec:column>	
		<ec:column property="wType" title="类别" style="text-align:center" sortable="false">
		   <s:if test="%{#attr.wipe.WType==1}">部外决裁</s:if>
		   <s:elseif test="%{#attr.wipe.wType==0}">部内决裁</s:elseif>
		</ec:column>
		<ec:column property="wUser.RName" title="作成者" style="text-align:center" sortable="false"/>
		<ec:column property="wApTime" title="作成日期" style="text-align:center" sortable="true"/>
        <ec:column property="wTotal" title="总金额"  style="text-align:center" sortable="true"/>
        
        
		<ec:column property="id" title="操作" style="text-align:center">
			<s:if test="%{#attr.wipe.state == 0}">
				 <img src="<s:property value="imgRootUrl"/>camera.png" width="16" height="16" />&nbsp;  <s:a href="%{monitorUrl}?wId=%{#attr.wipe.id}">追踪</s:a>
			    <img src="<s:property value="imgRootUrl"/>edt.gif" width="16" height="16" /><s:a href="%{edit}?key=%{#attr.wipe.id}">修改</s:a>
			</s:if>
			<s:elseif test="%{#attr.wipe.state == 1}">
				<img src="<s:property value="imgRootUrl"/>clipboard_text.png" width="16" height="16" />&nbsp;<s:a href="javascript:check('%{myPrint}?wCode=%{#attr.wipe.wCode}')">详细</s:a>
			   <img src="<s:property value="imgRootUrl"/>mail.png" width="16" height="16" />&nbsp;<s:a href="javascript:sendReport(%{#attr.wipe.id})">传送</s:a>
			</s:elseif>
		</ec:column>	
		
			
	 </ec:row>

</ec:table>
<s:include value="/apps/pageFooter.jsp" />
</body>
<SCRIPT type="text/javascript">
function check(url)
{
	var width = 800;
	var height = 800;
	var top = (screen.height-height)/2;
	var left = (screen.width-width)/2;
    window.open(url,'wipeDetail','height=' + height + ',width=' + width + ',top=' + top + ',left=' + left + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=yes');
}
function sendReport(key){
	var url = '<s:url action="userSel_depts" includeParams="none" namespace="/"/>';
	var rev = window.showModalDialog(url, null, "dialogHeight:320px;dialogWidth:480px;help:0;status:0;scroll:0;resizable:1");
	if (rev) {
 		$.post('<s:url action="wipe_sendWipe" includeParams="none" namespace="/"/>', {'wipe.id':key,'user.id':rev[0]} ,function(text){
 			if(text == 'true'){
 				window.alert("发送成功！");
 			}
 		});			
	}	
}
</SCRIPT>
</html>