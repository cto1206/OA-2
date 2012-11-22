<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<title>禀议报告表单</title>
	<link rel="stylesheet" href="<s:url value='/css/form.css' includeParams='none' encode='false' />" type="text/css"/>
</head>
<body>
	<s:include value="/apps/pageHeader.jsp">
		<s:param name="fb_title">系统管理-禀议报告审查</s:param>
	</s:include>
	<s:url id="downUrl" action="fileDown_download" includeParams="none" namespace="/"/>
		<table width="650px;" cellpadding="0" cellspacing="1" class="form">
			<thead>
				<tr>
					<td colspan="4">禀议报告审查</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width:90px;">禀议归属</td>
					<td style="width:235px;">
						<s:if test="ringiSho.title == 1">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr><td><img id="img_title" src="<s:property value="imgRootUrl"/>hb.png" style="width:28px;height:28px;"></td><td>汉邦钢构</td></tr>
							</table>
						</s:if>
						<s:elseif test="ringiSho.title == 2">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr><td><img id="img_title" src="<s:property value="imgRootUrl"/>gs.png" style="width:28px;height:28px;"></td><td>港盛涂装</td></tr>
							</table>						
						</s:elseif>
						<s:elseif test="ringiSho.title == 3">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr><td><img id="img_title" src="<s:property value="imgRootUrl"/>jl.png" style="width:28px;height:28px;"></td><td>建力设备</td></tr>
							</table>						
						</s:elseif>
						<s:elseif test="ringiSho.title == 4">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr><td><img id="img_title" src="<s:property value="imgRootUrl"/>lh.png" style="width:28px;height:28px;"></td><td>港盛联合</td></tr>
							</table>						
						</s:elseif>
					</td>
					<td>作 成 者</td><td><s:property value="ringiSho.user.rName"/></td>
				</tr>
				<tr>
					<td>作成时间</td><td><s:date name="ringiSho.date" format="yyyy-MM-dd"/></td>
					<td>需求日期</td><td><s:date name="ringiSho.needDate" format="yyyy-MM-dd"/></td>
				</tr>
				<tr>
					<td>联系电话</td><td colspan="3"><s:property value="ringiSho.tel"/></td>					
				</tr>
				<tr>
					<td>禀议主题</td><td colspan="3"><s:property value="ringiSho.sub"/></td>
				</tr>
				<tr style="height:80px;vertical-align:top;padding-top:8px;">
					<td>原因目的</td><td colspan="3"><s:property value="ringiSho.cause" escape="false"/></td>
				</tr>
				<tr style="height:80px;vertical-align:top;padding-top:8px;">
					<td>详细内容</td><td colspan="3"><s:property value="ringiSho.synopsis" escape="false"/></td>
				</tr>				
				<tr>
					<td>附　　件</td>
					<td colspan="3">
						<s:if test="uploadeds != null">
							<table cellpadding="0" cellspacing="0">
								<tr>
									<s:iterator value="uploadeds">
										<td><img src="<s:property value="imgRootUrl"/>word.gif" width="15" height="15"/></td>
										<td><s:a href="%{downUrl}?key=%{id}"><s:property value="name"/></s:a></td>
									</s:iterator>
								</tr>
							</table>
						</s:if>
					</td>
				</tr>
				<tr>
					<td style="vertical-align:top;padding-top:8px;">指示事项</td>
					<td colspan="3" style="padding:0px;">
						<table style="width:100%;" cellpadding="0" cellspacing="0">
							<s:iterator value="ringiShoTask.ringiSho.ringiShoDetails" status="stat">
								<tr><td><s:property value="#stat.count"/> 、<s:property value="content"/></td></tr>
							</s:iterator>
						</table>
					</td>
				</tr>
				<tr>
					<td>一级审查</td>
					<td style="color:blue;">
						<s:if test="ringiSho.flowDate1 != null">
							（<s:property value="ringiSho.flowMan1.rName"/>）已批准
						</s:if>
						<s:else>（<s:property value="ringiSho.flowMan1.rName"/>）待审</s:else>
					</td>
					<td>二级决裁</td>
					<td style="color:blue;">
						<s:if test="ringiSho.flowDate2 != null">
							（<s:property value="ringiSho.flowMan2.rName"/>）已批准
						</s:if>
						<s:else>（<s:property value="ringiSho.flowMan2.rName"/>）待审</s:else>
					</td>
				</tr>
				<s:if test="ringiSho.leType == 1">							
					<tr>
						<td>三级合议</td>
						<td style="color:blue;">
							<s:if test="ringiSho.flag == 0">
								<s:if test="ringiSho.flowDateStock != null">
									（<s:property value="ringiSho.flowManStock.rName"/>）已批准
								</s:if>
								<s:else>（<s:property value="ringiSho.flowManStock.rName"/>）待审</s:else>
							</s:if>
							<s:elseif test="ringiSho.flag == 1">
								<s:if test="ringiSho.flowDateFinance != null">							
									（<s:property value="ringiSho.flowManFinance.rName"/>）已批准
								</s:if>
								<s:else>（<s:property value="ringiSho.flowManFinance.rName"/>）待审</s:else>
							</s:elseif>
						</td>
						<td>四级合议</td>
						<td style="color:blue;">
							<s:if test="ringiSho.flowDate4 != null">
								（<s:property value="ringiSho.flowMan4.rName"/>）已批准
							</s:if>
							<s:else>（<s:property value="ringiSho.flowMan4.rName"/>）待审</s:else>
						</td>
					</tr>							
				</s:if>
				<s:if test="ringiSho.flowDate4 != null && ringiSho.state == 0">
					<tr>
						<td>最终决裁</td>
						<td style="color:blue;">
							<s:if test="ringiSho.presidentDate != null">
								（<s:property value="ringiSho.presidentMan.rName"/>）已批准
							</s:if>
							<s:else>（<s:property value="ringiSho.presidentMan.rName"/>）待审</s:else>
						</td>
					</tr>
				</s:if>
			</tbody>
			<tfoot>
				<tr><td colspan="4"><input type="button" value="返回" onclick="window.history.go(-1);"/></td></tr>
			</tfoot>
		</table>
	<s:include value="/apps/pageFooter.jsp"/>
</body>
</html>