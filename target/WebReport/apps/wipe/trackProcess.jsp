<%@page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>

<%@page import="java.io.OutputStream"%>
<html>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<%
String divString=(String)request.getAttribute("divString");
out.print("<font size='12'>"+divString+"</font>");
%>
</body>
</html>