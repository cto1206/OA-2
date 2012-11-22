<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<html>
<head>
	<title>经费报销项目管理</title>
	<s:head template="ecside"/>
</head>
<body>


	<s:include value="/apps/pageHeader.jsp">
		<s:param name="fb_title">系统管理-经费报销项目管理</s:param>
		<s:param name="fb_add"><s:url action="wipeItem_prepareForAdd" includeParams="none" namespace="/"/></s:param>
		<s:param name="fb_edit"><s:url action="wipeItem_prepareForEdit" includeParams="none" namespace="/"/></s:param>
		<s:param name="fb_del">#</s:param>
	</s:include>
	
	<s:url id="checkUrl" action="wipeItem_prepareForEdit" includeParams="none" namespace="/"/>
	
		<ec:table items="wipeItemList" var="wipeItem" action="./wipe_save.action" width="100%" listWidth="100%" resizeColWidth="true" doPreload="false">
			<ec:row>
		    <ec:column property="wipe.wCode" title="经费报销编号" style="text-align:center"/>
			<ec:column property="iItem" title="经费项目" style="text-align:center"/>
			<ec:column property="iMoney" title="经费总金额"/>
			
			<ec:column title="操作" property="id" style="text-align:center">
					<a href="wipeItem_prepareForEdit.action?key=<s:property value='%{#attr.wipeItem.id}'/>">修改</a>           
					&nbsp;
					<a href="wipeItem_delete.action?key=<s:property value='%{#attr.wipeItem.id}'/>">删除</a>
		  </ec:column>	
		  
		</ec:row>
		</ec:table>
	
			<s:if test="#attr.reApply=='reApply'">
				<s:a href="wipeItemDetail_list.action?reApply='reApply'&&wId=%{#attr.wId}">下一步</s:a>
            </s:if>
	<s:include value="/apps/pageFooter.jsp"/>
</body>
</html>