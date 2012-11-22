<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<html>
<head>
<title>人员列表</title>
<s:head template="ecside"/>
</head>
<body>
	<ec:table items="userList" var="user" action="./userSel_users.action" width="100%" sortable="false" toolbarContent="navigation|refresh|status" listWidth="100%" resizeColWidth="true">
		<ec:row>
			<ec:column property="id" title="选择" width="50" style="text-align:center">
				<input type="radio" name="radio" value="<s:property value='%{#attr.user.id}'/>,<s:property value='%{#attr.user.rName}'/>">
			</ec:column>		
			<ec:column property="RName" title="真实姓名" style="text-align:center"/>
			<ec:column property="sex" title="性别" width="50" style="text-align:center">
				<s:if test="%{#attr.user.sex == 1}">男</s:if>
				<s:elseif test="%{#attr.user.sex == 2}">女</s:elseif>
			</ec:column>			
			<ec:column property="tel" title="联系电话"/>
		</ec:row>
	</ec:table>
</body>
<script type="text/javascript">
function getSelUser(){
	var r = document.getElementsByName('radio');
	for(var i=0;i<r.length;i++){
		if(r[i].checked)
			return r[i].value.split(',');
	}
}
</script>
</html>