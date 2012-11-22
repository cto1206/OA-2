<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<div style="text-align:center;color:red">
		<s:property value="tip"/>
		<br>修改成功，请用重新登录！
		<input type="button" value="重新登录" onclick="relogin()">
	</div>
</body>
<script type="text/javascript">
function relogin(){
	window.top.location.href = '<s:url value="/login.jsp" includeParams="none" />';
}
</script>
</html>