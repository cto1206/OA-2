<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.hanbang.core.utils.ActionUtil;"%>
<html>
<head>
<title>经费报销项目表单</title>
<style>
html,body {
	width: 100%;
	height: 100%;
	padding: 0;
	margin: 0;
}
</style>
	<link rel="stylesheet" href="<s:url value='/css/form.css' includeParams='none' encode='false' />" type="text/css"/>
	<s:head template="jquery" />
	<s:head template="messager" />
</head>
<body>
<s:include value="/apps/pageHeader.jsp">
	<s:param name="fb_title">系统管理-经费报销项目审核</s:param>
	<s:param name="fb_add">#</s:param>
	<s:param name="fb_edit">#</s:param>
	<s:param name="fb_del">#</s:param>
</s:include>
<s:if test="#attr.judge=='dissent'">
	<s:url id="myjudge" action="wipe_dissent" includeParams="none"
		namespace="/" />
</s:if>

<s:elseif test="#attr.judge=='confirm'">
	<s:url id="myjudge" action="wipe_confirm" includeParams="none"
		namespace="/" />
</s:elseif>

<s:elseif test="#attr.judge=='reject'">
	<s:url id="myjudge" action="wipe_reject" includeParams="none"
		namespace="/" />
</s:elseif>

<s:set name="curUser" value="#session[@com.hanbang.core.utils.Constants@LOGIN_INFO]" scope="page" id="curUser"/>
<s:date id="curDate" format="yyyy-MM-dd" name="new java.util.Date()"/>
	
<table width="650px;" cellpadding="0" cellspacing="1" class="form">
	<thead>
		<tr>
			<td colspan="4">经费报销审核</td>
			<s:hidden name="wipe.id" />
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>禀议编号</td>
			<td><s:property value="wipe.wCode" /></td>
			<td>联系电话</td>
			<td><s:property value="wipe.tel" /></td>
		</tr>
		<tr>
			<td>申请日期</td>
			<td><s:property value="wipe.wApTime" /></td>
			<td style="width: 90px;">禀议归属</td>
			<td style="width: 235px;"><s:if test="wipe.title == 1">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td><img id="img_title"
							src="<s:property value="imgRootUrl"/>hb.png"
							style="width: 28px; height: 28px;"></td>
						<td>汉邦钢构</td>
					</tr>
				</table>
			</s:if> <s:elseif test="wipe.title == 2">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td><img id="img_title"
							src="<s:property value="imgRootUrl"/>gs.png"
							style="width: 28px; height: 28px;"></td>
						<td>港盛涂装</td>
					</tr>
				</table>
			</s:elseif> <s:elseif test="wipe.title == 3">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td><img id="img_title"
							src="<s:property value="imgRootUrl"/>jl.png"
							style="width: 28px; height: 28px;"></td>
						<td>建力设备</td>
					</tr>
				</table>
			</s:elseif> <s:elseif test="wipe.title == 4">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td><img id="img_title"
							src="<s:property value="imgRootUrl"/>lh.png"
							style="width: 28px; height: 28px;"></td>
						<td>港盛联合</td>
					</tr>
				</table>
			</s:elseif></td>
		</tr>

		<tr>
			<td>作成者</td>
			<td><s:property value="wipe.wUser.rName" /></td>
			<td>合计金额</td>
			<td><s:property value="wipe.wTotal" /></td>
		</tr>
		<tr>
			<td>备注</td>
			<td colspan="4"><s:property value="wipe.wRemark" /></td>
		</tr>
		<tr>
			<td>一级审查</td>
			<td style="color: blue;"><s:if
				test="wipe.judgeSet[0].judgeDate != null">
							（<s:property value="wipe.judgeSet[0].user.rName" />）已审批
						</s:if> <s:else>（<s:property value="wipe.judgeSet[0].user.rName" />）待审</s:else>
			</td>
			<td>二级决裁</td>
			<td style="color: blue;"><s:if
				test="wipe.judgeSet[1].judgeDate != null">
							（<s:property value="wipe.judgeSet[1].user.rName" />）已审批
						</s:if> <s:else>（<s:property value="wipe.judgeSet[1].user.rName" />）待审</s:else>
			</td>
		</tr>
		<s:if test="wipe.wType == 1">
			<tr>
				<td>三级合议</td>
				<td style="color: blue;"><s:if
					test="wipe.judgeSet[2].judgeDate!= null">							
									（<s:property value="wipe.judgeSet[2].user.rName" />）已审批
								</s:if> <s:else>（<s:property
						value="wipe.judgeSet[2].user.rName" />）待审</s:else></td>
				<td>四级合议</td>
				<td style="color: blue;"><s:if
					test="wipe.judgeSet[3].judgeDate!= null">
								（<s:property value="wipe.judgeSet[3].user.rName" />）已审批
							</s:if> <s:else>（<s:property
						value="wipe.judgeSet[3].user.rName" />）待审</s:else></td>
			</tr>

			<s:if test="wipe.topJudge == 1">
				<tr>
					<td>最终决裁</td>
					<td style="color: blue;"><s:if
						test="wipe.judgeSet[4].judgeDate!= null">
								（<s:property value="wipe.judgeSet[4].user.rName" />）已审批
							</s:if> <s:else>（<s:property
							value="wipe.judgeSet[4].user.rName" />）待审</s:else></td>
					<td></td>
					<td></td>
				</tr>
			</s:if>
		</s:if>
	</tbody>

</table>

<br>
<br>
<br>

<table width="650px;" cellpadding="0" cellspacing="1" class="form">
	<tr>
		<td colspan="3" align="center">经费项目</td>
	</tr>
	<tr>
		<td>经费报销编号</td>
		<td>经费项目</td>
		<td>经费总金额</td>
	</tr>
	<s:iterator id="wipeItemList" value="wipeItemList" var="wipeItem">

		<tr>
			<td><s:property value="wipe.wCode" /></td>
			<td><s:property value="iItem" /></td>
			<td><s:property value="iMoney" /></td>
		</tr>
	</s:iterator>
</table>
<br>
<br>
<br>
<table width="650px;" cellpadding="0" cellspacing="1" class="form">
	<tr>
		<td colspan="5" align="center">经费项目详细</td>
	</tr>
	<tr>
		<td>经费项目</td>
		<td>日期</td>
		<td>报销金额</td>
		<td>摘要</td>
		<td>备注</td>
	</tr>
	<s:iterator id="wipeItemDetailList" value="wipeItemDetailList"
		var="wipeItemDetail">


		<tr>
			<td><s:property value="wipeItem.iItem" /></td>
			<td><s:property value="itemDetailDate" /></td>
			<td><s:property value="itemDetailMoney" /></td>
			<td><s:property value="itemDetailBrief" /></td>
			<td><s:property value="itemDetailRemark" /></td>
		</tr>
	</s:iterator>
</table>
<br>
<br>
<br>

	
	<s:form action="wipe_confirm" namespace="/" theme="simple">
		<table width="650px;" cellpadding="0" cellspacing="1" class="form">
		<thead>
		<tr>
			<td colspan="4">经费报销审核</td>
			<s:hidden name="wipe.id" />
			<s:hidden name="wipe.wCode" />
			<s:hidden name="taskId" />

		</tr>
	</thead>
	<tbody>
			<tr>
				<td>审批人</td>
				<td width="150">
					
					<input name="wipe.judgeSet[judgeList.size].user.rName" value='<s:property  value="#attr.curUser.rName"/>'>

					</td>
					
				<td>审批日期</td>
				<td width="150"><s:textfield
					name="wipe.judgeSet[judgeList.size].judgeDate" theme="simple"
					disabled="true" value="%{#curDate}"/></td>
			</tr>
			
			
			<tr>
				<td style="vertical-align:top;padding-top:8px;">指示事项</td>
				<td colspan="3" style="padding:0px;">
					<table style="width:100%;" cellpadding="0" cellspacing="0">
						<s:iterator value="judgeList" status="stat" var="judges">
						<s:if test="%{#judges.jDirect!=''}">
							<tr><td><s:property value="#stat.count"/> 、<s:property value="jDirect"/></td></tr>
							</s:if>
						</s:iterator>
						<tr><td><s:textarea name="dire" theme="simple" cssStyle="width:480px;" rows="5"/></td></tr>
					</table>
				</td>
			</tr>
				
			<tr>
				<s:if test="task.name == '四级合议'">
					<td>董事长审批:</td>
					<td colspan="3"><s:select list="#{'1':'是','0':'否'}" name="topJudge"></s:select></td>
				</s:if>
			</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="4"><input type="button" value="批准" id="okBtn">&nbsp;&nbsp;<input
						type="button" value="驳回" id="cancelBtn" /></td>
			
				</tr>
			</tfoot>
		</table>
	</s:form>

	<s:include value="/apps/pageFooter.jsp" />
</body>
<script type="text/javascript">
function selpass(pwd,mypwd){
  var pwd = document.getElementsByName(pwd)[0];
  var mypwd = document.getElementsByName(mypwd)[0];
  if(pwd.value!=mypwd.value)
  {
     alert("禀议码不正确，请重新输入。");
     mypwd.value="";
     return;
  }
}
</script>

<script type="text/javascript">
$(function(){
	
	$('input.UserSel').each(function(){
		$(this).css('background','#fff url(<s:property value="imgRootUrl"/>users.png) no-repeat right');   
		$(this).css('border','#999 1px solid');
		$(this).css('cursor','pointer');
		$(this).attr('readOnly',true);
	});
	

	//批准
	$("#okBtn").click(function(){
		$.messager.prompt('禀议码验证', '请输入禀议码!', function(val){
			if (val){
		 		$.post('<s:url action="ringi_checkCode" includeParams="none" namespace="/"/>', {"ringiShoCode":val} ,function(text){
		 			var obj = eval(text);
		 			if(obj.checked){
		 			    $("#wipe_confirm").attr('action','<s:url action="wipe_confirm" includeParams="none" namespace="/"/>');
		 				$("#wipe_confirm").submit();
		 			}else{
		 				$.messager.alert('提示信息','禀议码错误!','warning');
		 			}
		 		});						
			}
		});
	});
	
	//驳回
	$("#cancelBtn").click(function(){
		$.messager.prompt('禀议码验证', '请输入禀议码!', function(val){
			if (val){
		 		$.post('<s:url action="ringi_checkCode" includeParams="none" namespace="/"/>', {"ringiShoCode":val} ,function(text){
		 			var obj = eval(text);
		 			if(obj.checked){
		 				$("#wipe_confirm").attr('action','<s:url action="wipe_reject" includeParams="none" namespace="/"/>');
		 				$("#wipe_confirm").submit();
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