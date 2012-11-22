<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<html>
<head>
	<title>经费报销项目明细管理</title>
	<s:head template="ecside"/>
</head>
<body>
	<s:include value="/apps/pageHeader.jsp">
		<s:param name="fb_title">系统管理-经费报销项目明细</s:param>
		<s:param name="fb_add"><s:url action="wipeItemDetail_prepareForAdd" includeParams="none" namespace="/"/></s:param>
		<s:param name="fb_edit"><s:url action="wipeItemDetail_prepareForEdit" includeParams="none" namespace="/"/></s:param>
		<s:param name="fb_del">#</s:param>
	</s:include>
	<s:url id="checkUrl" action="wipeItemDetail_prepareForEdit" includeParams="none" namespace="/"/>
		<ec:table items="page.result" var="wipeItemDetail" action="./wipeItemDetail_list.action" width="100%" listWidth="100%" resizeColWidth="true" doPreload="false">
			<ec:row>
				<ec:column property="wipeItem.iItem" title="经费项目" style="text-align:center"/>
					<ec:column property="itemDetailDate" title="日期"/>
					<ec:column property="itemDetailMoney" title="报销金额" style="text-align:center"/>
					<ec:column property="itemDetailBrief" title="摘要"/>
					<ec:column property="itemDetailRemark" title="备注" style="text-align:center"/>
					
					<ec:column title="操作" property="id" style="text-align:center">
					<a href="wipeItemDetail_prepareForEdit.action?key=<s:property value='%{#attr.wipeItemDetail.id}'/>">修改</a>           
					&nbsp;
					<a href="wipeItemDetail_delete.action?key=<s:property value='%{#attr.wipeItemDetail.id}'/>">删除</a>
		            </ec:column>	
		  
		  
			</ec:row>
		</ec:table>
	<s:include value="/apps/pageFooter.jsp"/>
</body>
</html>