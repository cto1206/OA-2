<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<title>禀议报告表单</title>
	<link rel="stylesheet" href="<s:url value='/css/form.css' includeParams='none' encode='false' />" type="text/css"/>
	<s:head template="jquery" />
	<s:head template="messager" />
</head>
<body>
	<s:include value="/apps/pageHeader.jsp">
		<s:param name="fb_title">系统管理-禀议报告审查</s:param>
	</s:include>
	<s:url id="downUrl" action="fileDown_download" includeParams="none" namespace="/"/>
	<s:set name="curUser" value="#session[@com.hanbang.platform.util.Constants@LOGIN_INFO]" scope="page"/>
	<s:date id="curDate" format="yyyy-MM-dd" name="new java.util.Date()"/>
		<s:form action="ringi_confirm" namespace="/" theme="simple">
		<table width="650px;" cellpadding="0" cellspacing="1" class="form">
			<thead>
				<tr>
					<td colspan="4">禀议报告审查</td>
					<s:hidden name="ringiShoDetail.ringiSho.id" value="%{ringiShoTask.ringiSho.id}"/>
					<s:hidden name="taskId" value="%{ringiShoTask.task.id}"/>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width:90px;">禀议归属</td>
					<td style="width:235px;">
						<s:if test="ringiShoTask.ringiSho.title == 1">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr><td><img id="img_title" src="<s:property value="imgRootUrl"/>hb.png" style="width:28px;height:28px;"></td><td>汉邦钢构</td></tr>
							</table>
						</s:if>
						<s:elseif test="ringiShoTask.ringiSho.title == 2">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr><td><img id="img_title" src="<s:property value="imgRootUrl"/>gs.png" style="width:28px;height:28px;"></td><td>港盛涂装</td></tr>
							</table>						
						</s:elseif>
						<s:elseif test="ringiShoTask.ringiSho.title == 3">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr><td><img id="img_title" src="<s:property value="imgRootUrl"/>jl.png" style="width:28px;height:28px;"></td><td>建力设备</td></tr>
							</table>						
						</s:elseif>
						<s:elseif test="ringiShoTask.ringiSho.title == 4">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr><td><img id="img_title" src="<s:property value="imgRootUrl"/>lh.png" style="width:28px;height:28px;"></td><td>港盛联合</td></tr>
							</table>						
						</s:elseif>
					</td>
					<td style="width:90px;">作 成 者</td><td style="width:235px;"><s:property value="ringiShoTask.ringiSho.user.rName"/></td>
				</tr>
				<tr>
					<td>作成时间</td><td><s:date name="ringiShoTask.ringiSho.date" format="yyyy-MM-dd"/></td>
					<td>需求日期</td><td><s:date name="ringiShoTask.ringiSho.needDate" format="yyyy-MM-dd"/></td>
				</tr>
				<tr>
					<td>联系电话</td><td colspan="3"><s:property value="ringiShoTask.ringiSho.tel"/></td>
				</tr>
				<tr>
					<td>禀议主题</td><td colspan="3"><s:property value="ringiShoTask.ringiSho.sub"/></td>
				</tr>
				<tr style="height:80px;vertical-align:top;padding-top:8px;">
					<td>原因目的</td><td colspan="3"><s:property value="ringiShoTask.ringiSho.cause"/></td>
				</tr>
				<tr style="height:80px;vertical-align:top;padding-top:8px;">
					<td>详细内容</td><td colspan="3"><s:property value="ringiShoTask.ringiSho.synopsis" escape="false" /></td>
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
							<tr><td><s:textarea name="ringiShoDetail.content" theme="simple" cssStyle="width:480px;" rows="5"/></td></tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>一级审查</td>
					<td style="color:blue;">
						<s:if test="ringiShoTask.ringiSho.flowDate1 != null">
							（<s:property value="ringiShoTask.ringiSho.flowMan1.rName"/>）已批准
						</s:if>
					</td>
					<td>二级决裁</td>
					<td style="color:blue;">
						<s:if test="ringiShoTask.ringiSho.flowDate2 != null">
							（<s:property value="ringiShoTask.ringiSho.flowMan2.rName"/>）已批准
						</s:if>
					</td>
				</tr>
				<s:if test="ringiShoTask.ringiSho.leType == 1">							
					<tr>
						<td>三级合议</td>
						<td style="color:blue;">
							<s:if test="ringiShoTask.ringiSho.flowDateStock != null">
								（<s:property value="ringiShoTask.ringiSho.flowManStock.rName"/>）已批准&nbsp;&nbsp;
							</s:if>
							<s:if test="ringiShoTask.ringiSho.flowDateFinance != null">
								（<s:property value="ringiShoTask.ringiSho.flowManFinance.rName"/>）已批准
							</s:if>
						</td>
						<td>四级合议</td>
						<td style="color:blue;">
							<s:if test="ringiShoTask.ringiSho.flowDate4 != null">
								（<s:property value="ringiShoTask.ringiSho.flowMan4.rName"/>）已批准
							</s:if>
						</td>
					</tr>							
				</s:if>
				<s:if test="ringiShoTask.task.name == '四级合议'">
					<tr>
						<td>最终决裁</td>
						<td colspan="3">
							<s:hidden name="ringiShoDetail.ringiSho.presidentMan.id"/>
							<s:textfield name="ringiShoDetail.ringiSho.presidentMan.rName" theme="simple" cssClass="UserSel"/>
						</td>
					</tr>
				</s:if>
			</tbody>
			<tfoot>
				<tr><td colspan="4"><input type="button" value="批准" id="okBtn">&nbsp;&nbsp;<input type="button" value="驳回" id="cancelBtn"/></td></tr>
			</tfoot>
		</table>
		</s:form>
	<s:include value="/apps/pageFooter.jsp"/>
</body>
<script type="text/javascript">
$(function(){
	
	$('input.UserSel').each(function(){
		$(this).css('background','#fff url(<s:property value="imgRootUrl"/>users.png) no-repeat right');   
		$(this).css('border','#999 1px solid');
		$(this).css('cursor','pointer');
		$(this).attr('readOnly',true);
	});
	
	$("input[name='ringiShoDetail.ringiSho.presidentMan.rName']").click(function(){
		var url = '<s:url action="userSel_depts" includeParams="none" namespace="/"/>';
		var rev = window.showModalDialog(url, null, "dialogHeight:320px;dialogWidth:480px;help:0;status:0;scroll:0;resizable:1");
		if (rev) {
			$("input[name='ringiShoDetail.ringiSho.presidentMan.id']").val(rev[0]);
			$(this).val(rev[1]);
		}
	});
	
	//批准
	$("#okBtn").click(function(){
		if($("#ringi_confirm").valid()){
			$.messager.prompt('禀议码验证', '请输入禀议码!', function(val){
				if (val){
			 		$.post('<s:url action="ringi_checkCode" includeParams="none" namespace="/"/>', {"ringiShoCode":val} ,function(text){
			 			var obj = eval(text);
			 			if(obj.checked){
			 				$("#ringi_confirm").attr('action','<s:url action="ringi_confirm" includeParams="none" namespace="/"/>')
			 				$("#ringi_confirm").submit();
			 			}else{
			 				$.messager.alert('提示信息','禀议码错误!','warning');
			 			}
			 		});						
				}
			}); 
		}
	});
	
	//驳回
	$("#cancelBtn").click(function(){
		$.messager.prompt('禀议码验证', '请输入禀议码!', function(val){
			if (val){
		 		$.post('<s:url action="ringi_checkCode" includeParams="none" namespace="/"/>', {"ringiShoCode":val} ,function(text){
		 			var obj = eval(text);
		 			if(obj.checked){
		 				$("#ringi_confirm").attr('action','<s:url action="ringi_reject" includeParams="none" namespace="/"/>');
		 				$("#ringi_confirm").submit();
		 			}else{
		 				$.messager.alert('提示信息','禀议码错误!','warning');
		 			}
		 		});						
			}
		});
	});
});
</script>
</html>