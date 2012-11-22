<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="<s:url value='/common/dtree/dtree.css' includeParams='none' encode='false' />" type="text/css"/>
<script type="text/javascript" src="<s:url value='/common/dtree/dtree.js' includeParams='none' encode='false'/>"></script>
</head>
<body>
	<script type="text/javascript">
		d = new dTree('d');
		d.add(0,-1,'港盛联合');
        <s:iterator value="deptList">
        	d.add(<s:property value="id"/>,<s:property value="parent"/>,'<s:property value="name"/>','<s:url action="dept_prepareForEdit" includeParams="none" namespace="/"><s:param name="key" value="id" /></s:url>','','','<s:url value="/images/" includeParams="none" />list_users.gif');
        </s:iterator>
		d.config.target = 'deptContentFrame';
		document.write(d);
	</script>
</body>
</html>