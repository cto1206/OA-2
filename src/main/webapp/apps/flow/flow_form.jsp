<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<html>
<head>
	<title>流程发布表单</title>
	<link rel="stylesheet" href="<s:url value='/css/form.css' includeParams='none' encode='false' />" type="text/css"/>
	<s:head template="jquery" />
</head>
<body>
	<s:include value="/apps/pageHeader.jsp">
		<s:param name="fb_title">系统管理-流程发布</s:param>
		<s:param name="fb_add">#</s:param>
		<s:param name="fb_edit">#</s:param>
		<s:param name="fb_del">#</s:param>
	</s:include> 
		<s:form action="flow_deploy" namespace="/" theme="simple">
			<table width="500px;" cellpadding="0" cellspacing="1" class="form">
				<thead>
					<tr>
						<td colspan="2">流程发布</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td nowrap style="vertical-align:top;padding-top:8px;">流程详细</td>
						<td><s:textarea name="xml" cols="50" rows="15" cssClass="required"/></td>
					</tr>	
				</tbody>
				<tfoot>
					<tr><td colspan="2"><s:submit value="发布" theme="simple"/>&nbsp;&nbsp;<s:reset value="重置" theme="simple"/></td></tr>
				</tfoot>
			</table>
		</s:form>
	<s:include value="/apps/pageFooter.jsp"/>
</body>
</html>