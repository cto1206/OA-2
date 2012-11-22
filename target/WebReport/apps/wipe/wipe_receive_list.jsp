<%@ page language="java" pageEncoding="UTF-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<html>
<head>
	<title>接收经费报销表单</title>
	<s:head template="ecside"/>
	<s:head template="jquery"/>
</head>
<body>
<s:include value="/apps/pageHeader.jsp">
	<s:param name="fb_title">系统管理-接收经费报销列表</s:param>
</s:include>
    <s:url id="edit" action="wipe_prepareForEdit" includeParams="none" namespace="/"/>
    <s:url id="monitorUrl" action="wipe_monitor" includeParams="none" namespace="/"/>
	<s:url id="myPrint" action="wipe_print" includeParams="none" namespace="/"/>
	<s:url id="send" action="wipe_prepareForSend" includeParams="none" namespace="/"/>
	<s:url id="recycleUrl" action="wipe_recycle" includeParams="none" namespace="/"/>
	
<ec:table items="receiveWipeList" var="receiveWipe" action="./wipe_receiveWipe.action"
	width="100%" listWidth="100%" resizeColWidth="true" doPreload="false">
	<ec:row>
	
		<ec:column property="wipe.title"  title="归属" style="text-align:center" width="10%">
			<s:if test="%{#attr.receiveWipe.wipe.title == 1}">汉邦钢构</s:if>
			<s:elseif test="%{#attr.receiveWipe.wipe.title == 2}">港盛涂装</s:elseif>					
			<s:elseif test="%{#attr.receiveWipe.wipe.title == 3}">建力设备</s:elseif>					
			<s:elseif test="%{#attr.receiveWipe.wipe.title == 4}">港盛联合</s:elseif>					
		</ec:column>	
		<ec:column property="wipe.wType" title="类别" style="text-align:center" sortable="false" width="10%">
		   <s:if test="%{#attr.receiveWipe.wipe.WType==1}">部外决裁</s:if>
		   <s:elseif test="%{#attr.receiveWipe.wipe.wType==0}">部内决裁</s:elseif>
		</ec:column>
		<ec:column property="wipe.wUser.RName" title="作成者" style="text-align:center" sortable="false" width="10%"/>
		
		<ec:column property="wipe.wApTime" title="作成日期" style="text-align:center" sortable="true" width="10%"/>
		
		<ec:column property="sentTime" title="传送日期" style="text-align:center" sortable="true" width="10%"/>
		
        <ec:column property="wipe.wTotal" title="总金额"  style="text-align:center" sortable="true" width="10%"/>       
		
		<ec:column property="id" title="操作" style="text-align:center" width="17%">
			<img src="<s:property value="imgRootUrl"/>camera.png" width="16" height="16" />&nbsp;  <s:a href="%{monitorUrl}?wId=%{#attr.receiveWipe.wipe.id}&&rId=%{#attr.receiveWipe.id}">追踪</s:a>							
	        <img src="<s:property value="imgRootUrl"/>clipboard_text.png" width="16" height=";16" />&nbsp;<s:a href="javascript:check('%{myPrint}?wCode=%{#attr.receiveWipe.wipe.wCode}')">打印</s:a>	
		    <s:if test="%{#attr.receiveWipe.state!=2}">	
		      <img src="<s:property value="imgRootUrl"/>clipboard_text.png" width="16" height="16" />&nbsp;<s:a href="javascript:sendRecycle('%{#attr.receiveWipe.id}')">回收站</s:a>
		    </s:if>		
		</ec:column>		

		
			
	 </ec:row>

</ec:table>
<s:include value="/apps/pageFooter.jsp" />
</body>
<SCRIPT type="text/javascript">
function check(url)
{
alert(url);
	var width = 800;
	var height = 800;
	var top = (screen.height-height)/2;
	var left = (screen.width-width)/2;
    window.open(url,'wipeDetail','height=' + height + ',width=' + width + ',top=' + top + ',left=' + left + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=yes');
}

function sendRecycle(key){
	$.post('<s:url action="wipe_recycle" includeParams="none" namespace="/"/>', {'rId':key} ,function(text){
		if(text == 'true'){
			window.alert("已放入回收站！");
		}
		else
		   alert("本次操作未成功！");
	});			
}

</SCRIPT>
</html>