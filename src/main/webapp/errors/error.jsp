<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<title><s:text name="login.title"></s:text></title>
</head>
<body>
<h1>出错了！</h1>
<s:property value="exception.message"/>
<s:property value="exceptionStack"/>
</body>
</html>