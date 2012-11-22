<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<html>
<head>
	<title>禀议报告表单</title>
	<s:head template="ecside"/>
	<s:head template="jquery"/>
	<link rel="stylesheet" href="<s:url value='/css/list.css' includeParams='none' encode='false' />" type="text/css"/>
</head>
<body>
	<s:include value="/apps/pageHeader.jsp">
		<s:param name="fb_title">系统管理-禀议列表</s:param>
	</s:include>
	<s:url id="monitorUrl" action="ringi_monitor" includeParams="none" namespace="/"/>
	<s:url id="detailsUrl" action="ringi_details" includeParams="none" namespace="/"/>
		<ec:table items="page.result" var="ringi" doPreload="false" action="./ringi_list.action" width="100%" listWidth="100%" resizeColWidth="true">
			<ec:row>
				<ec:column property="title" width="15%" title="归属" style="text-align:center">
					<s:if test="%{#attr.ringi.title == 1}">汉邦钢构</s:if>
					<s:elseif test="%{#attr.ringi.title == 2}">港盛涂装</s:elseif>					
					<s:elseif test="%{#attr.ringi.title == 3}">建力设备</s:elseif>					
					<s:elseif test="%{#attr.ringi.title == 4}">港盛联合</s:elseif>					
				</ec:column>
				<ec:column property="sub" title="禀议主题" ellipsis="true"/>
				<ec:column property="user.RName" width="15%" title="作成者" style="text-align:center"/> 
				<ec:column property="date" width="15%" title="作成日期" cell="date" style="text-align:center"/> 
				<ec:column property="needDate" width="15%" title="需求日期" cell="date" style="text-align:center"/>
				<ec:column property="id" title="操作" width="15%" style="text-align:center">
					<s:if test="%{#attr.ringi.state == 0}">
						<img src="<s:property value="imgRootUrl"/>camera.png" width="16" height="16" />&nbsp;<s:a href="%{monitorUrl}?key=%{#attr.ringi.id}">跟踪</s:a>
					</s:if>
					<s:elseif test="%{#attr.ringi.state == 1}">
						<img src="<s:property value="imgRootUrl"/>clipboard_text.png" width="16" height="16" />&nbsp;<s:a href="javascript:showDetail(%{#attr.ringi.id})">详细</s:a>
						&nbsp;
						<img src="<s:property value="imgRootUrl"/>mail.png" width="16" height="16" />&nbsp;<s:a href="javascript:sendReport(%{#attr.ringi.id})">传送</s:a>
					</s:elseif>
				</ec:column>				
			</ec:row>
		</ec:table>

	<s:include value="/apps/pageFooter.jsp"/>
</body>
<script type="text/javascript">
function showDetail(key){
	var width = 800;
	var height = 600;
	var top = (screen.height-height)/2;
	var left = (screen.width-width)/2;
	var url = '<s:property value="detailsUrl"/>?key=' + key;   
	window.open(url,'ringiDetail','height=' + height + ',width=' + width + ',top=' + top + ',left=' + left + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=yes');
}


function sendReport(key){
	var url = '<s:url action="userSel_depts" includeParams="none" namespace="/"/>';
	var rev = window.showModalDialog(url, null, "dialogHeight:320px;dialogWidth:480px;help:0;status:0;scroll:0;resizable:1");
	if (rev) {
 		$.post('<s:url action="report_save" includeParams="none" namespace="/"/>', {'ringiSho.id':key,'user.id':rev[0]} ,function(text){
 			if(text == 'true'){
 				window.alert("发送成功！");
 			}
 		});			
	}	
}
</script>
</html>