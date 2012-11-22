<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<title>首页</title>
<link rel="stylesheet"
	href="<s:url value='/css/list.css' includeParams='none' encode='false' />"
	type="text/css" />
<style type="text/css">
<!--
.STYLE1 {
	font-family: "新宋体";
	font-size: 18mm;
}

.STYLE3 {
	font-family: "Courier New", Courier, monospace;
	font-size: 18mm;
	color: #FF0000;
	font-weight: bold;
}
-->
</style>
</head>

<body>
<s:include value="/apps/pageHeader.jsp">
	<s:param name="fb_title">首页</s:param>
</s:include>
<table width="883" border="0" align="center">
<tr><td colspan="3"><FONT size="5px"><s:property value="display" escape="false"/></FONT></td></tr>
	<tr>
		<td height="435" colspan="2" bgcolor="#FFFFFF"><span
			class="STYLE1"><img src="<s:property value="imgRootUrl"/>gsbz.png" width="269"
			height="300" /></span></td>
		<td width="585" height="435" bgcolor="#FFFFFF"><span
			class="STYLE3">港盛联合禀议系统</span></td>
	</tr>
</table>
<s:include value="/apps/pageFooter.jsp" />
</body>
</html>