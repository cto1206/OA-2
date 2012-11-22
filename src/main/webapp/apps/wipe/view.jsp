<%@ page language="java" pageEncoding="UTF-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.hanbang.core.utils.ActionUtil;"%>
<html>
<head>
	<title>经费报销项目管理</title>
	<link rel="stylesheet" href="<s:url value='/css/form.css' includeParams='none' encode='false' />" type="text/css"/>
	<s:head template="ecside"/>
	<s:head template="jquery" />
</head>
<body>
<!-- 
	<s:include value="/apps/pageHeader.jsp">
		<s:param name="fb_title">系统管理-经费报销项目管理</s:param>
		<s:param name="fb_add"><s:url action="wipeItem_prepareForAdd" includeParams="none" namespace="/"/></s:param>
		<s:param name="fb_edit"><s:url action="wipeItem_prepareForEdit" includeParams="none" namespace="/"/></s:param>
		<s:param name="fb_del">#</s:param>
	</s:include> -->
	<s:form action="wipe_save" namespace="/" theme="simple">
	<table width="650px;" cellpadding="0" cellspacing="1" class="form">
			<thead>
				<tr>
					<td colspan="4"><s:property value="title"/></td>
					<s:hidden name="wipe.id"/>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>禀议编号</td>
					<td>
					<s:property value="wipe.wCode"/>
					
					</td>
					<td>联系电话</td><td>
					<s:property value="wipe.tel"/>
				</tr>
				<tr>
<td>申请日期</td>
						<td>
						<s:property value="wipe.wApTime"/></td>
						<td style="width:90px;">禀议归属</td>
					<td style="width:235px;">
						<s:if test="wipe.title == 1">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr><td><img id="img_title" src="<s:property value="imgRootUrl"/>hb.png" style="width:28px;height:28px;"></td><td>汉邦钢构</td></tr>
							</table>
						</s:if>
						<s:elseif test="wipe.title == 2">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr><td><img id="img_title" src="<s:property value="imgRootUrl"/>gs.png" style="width:28px;height:28px;"></td><td>港盛涂装</td></tr>
							</table>						
						</s:elseif>
						<s:elseif test="wipe.title == 3">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr><td><img id="img_title" src="<s:property value="imgRootUrl"/>jl.png" style="width:28px;height:28px;"></td><td>建力设备</td></tr>
							</table>						
						</s:elseif>
						<s:elseif test="wipe.title == 4">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr><td><img id="img_title" src="<s:property value="imgRootUrl"/>lh.png" style="width:28px;height:28px;"></td><td>港盛联合</td></tr>
							</table>						
						</s:elseif>
					</td>
				</tr>
				
				<tr>
					<td>作成者</td><td>
					<s:property value="wipe.wUser.rName"/></td>
					<td>合计金额</td><td>
					<s:property value="wipe.wTotal"/></td>
				</tr>
				
				
			<tr>
					<td>一级审查</td>
					<td>

							<s:property value="wipe.judgeSet[0].user.rName"/>
				</td>
						
				
					<td>二级决裁</td>
					<td style="color:blue;">
						<s:if test="wipe.judgeSet[1].judgeDate != null">
							（<s:property value="wipe.judgeSet[1].user.rName"/>）已批准
						</s:if>
						<s:else>（<s:property value="wipe.judgeSet[1].user.rName"/>）待审</s:else>
					</td>
				</tr>
				<s:if test="wipe.wType == 1">							
					<tr>
						<td>三级合议</td>
						<td style="color:blue;">

								<s:if test="wipe.judgeSet[2].judgeDate!= null">							
									（<s:property value="wipe.judgeSet[2].user.rName"/>）已批准
								</s:if>
								<s:else>（<s:property value="wipe.judgeSet[2].user.rName"/>）待审</s:else>
						</td>
						<td>四级合议</td>
						<td style="color:blue;">
							<s:if test="wipe.judgeSet[3].judgeDate!= null">
								（<s:property value="wipe.judgeSet[3].user.rName"/>）已批准
							</s:if>
							<s:else>（<s:property value="wipe.judgeSet[3].user.rName"/>）待审</s:else>
						</td>
					</tr>							
				
		<s:if test="wipe.judgeSet[3].judgeDate != null ">
					<tr>
						<td>最终决裁</td>
						<td style="color:blue;">
							<s:if test="wipe.judgeSet[4].judgeDate!= null">
								（<s:property value="wipe.judgeSet[4].user.rName"/>）已批准
							</s:if>
							<s:else>（<s:property value="wipe.judgeSet[4].user.rName"/>）待审</s:else>
						</td>
						<td></td>
						<td></td>
					</tr>
					</s:if>
</s:if>

<tr>
				<td>备注</td><td colspan="4">
				<s:property value="wipe.wRemark"/>
				</td></tr>		
		
			</tbody>
			
		</table>
		</s:form>	
		
<table width="650px;" cellpadding="0" cellspacing="1" class="form">
<tr><td colspan="3" align="center">经费项目</td></tr>
  <tr>
    <td>经费报销编号</td><td>经费项目</td><td>经费总金额</td>
    </tr>
<s:iterator id="wipeItemList" value="wipeItemList" var="wipeItem">
  
    <tr>
       <td><s:property value="wipe.wCode"/></td>
       <td><s:property value="iItem"/></td>
       <td><s:property value="iMoney"/></td>
    </tr>
</s:iterator>
</table>
		
<table width="650px;" cellpadding="0" cellspacing="1" class="form">
<tr><td colspan="5" align="center">经费项目详细</td></tr>
<tr>
    <td>经费项目</td><td>日期</td><td>报销金额</td><td>摘要</td><td>备注</td>
   </tr>
<s:iterator id="wipeItemDetailList" value="wipeItemDetailList" var="wipeItemDetail">
  
   
    <tr>
       <td><s:property value="wipeItem.iItem"/></td>
       <td><s:property value="itemDetailDate"/></td>
       <td><s:property value="itemDetailMoney"/></td>
        <td><s:property value="itemDetailBrief"/></td>
       <td><s:property value="itemDetailRemark"/></td>
    </tr>
</s:iterator>
</table>

	<s:include value="/apps/pageFooter.jsp"/>
</body>
</html>