<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<html>
<head>
	<title>用户表单</title>
	<link rel="stylesheet" href="<s:url value='/css/list.css' includeParams='none' encode='false' />" type="text/css"/>
	<base target="deptContentFrame">
</head>
<body>
<s:url id="imgRootUrl" value="/images/" includeParams="none" />
<s:url id="addUrl" action="dept_prepareForAdd" includeParams="none" namespace="/">
	<s:param name="dept.parent" value="0"/>
</s:url> 
<s:url id="editUrl" action="dept_prepareForEdit" includeParams="none" namespace="/"/> 
	<s:include value="/apps/pageHeader.jsp">
		<s:param name="fb_title">系统管理-部门列表</s:param>
		<s:param name="fb_add"><s:property value='addUrl'/></s:param>
	</s:include>
		<table width="100%" height="600" cellspacing="0" cellpadding="0">
			<tr>
				<td style="width:200px;">
					<div class="tree">	
						<iframe name="deptLeft" src="<s:url action='dept_list' includeParams='none' namespace='/'/> " frameborder="0" scrolling="no" style="width:100%;height:100%;"></iframe>
					</div>
				</td>
				<td style="padding:5px;border-left:1px gray solid;"><iframe name="deptContentFrame" src="<s:property value='addUrl'/>" frameborder="0" scrolling="no" style="width:100%;height:100%;"></iframe></td>
			</tr>
		</table>
	<s:include value="/apps/pageFooter.jsp"/>
</body>
</html>