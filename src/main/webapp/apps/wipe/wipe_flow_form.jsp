<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<html>
<head>
<title>经费报销项目表单</title>
<link rel="stylesheet"
	href="<s:url value='/css/form.css' includeParams='none' encode='false' />"
	type="text/css" />
<s:head template="jquery" />
</head>
<body>
	
		<s:form action="wipe_deployWithImage" namespace="/" theme="simple" enctype="multipart/form-data" method="post">
			<table width="500px;" cellpadding="0" cellspacing="1" class="form" >
				<thead>
					<tr>
						<td colspan="2">流程发布</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td nowrap style="vertical-align:top;padding-top:8px;">流程详细</td>
						<td><s:file name="myFile"></s:file>
					</tr>	
				</tbody>
				<tfoot>
					<tr><td colspan="2"><s:submit value="发布" theme="simple"/></td></tr>
				</tfoot>
			</table>
		</s:form>
	    
<s:include value="/apps/pageFooter.jsp" />
</body>

</html>