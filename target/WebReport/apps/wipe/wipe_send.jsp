<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.hanbang.core.utils.ActionUtil;"%>
<html>
<head>
<title>经费报销表单</title>
<style>
	html, body {
		width : 100%;
		height : 100%;
		padding : 0;
		margin : 0;
	}
</style>
<link rel="stylesheet"
	href="<s:url value='/css/form.css' includeParams='none' encode='false' />"
	type="text/css" />
<s:head template="jquery"/>
<s:head template="messager" />
</head>
<body>
<s:include value="/apps/pageHeader.jsp">
	<s:param name="fb_title">系统管理-经费报销列表</s:param>
	<s:param name="fb_add">
		<s:url action="wipe_prepareForAdd" includeParams="none" namespace="/" />
	</s:param>
	<s:param name="fb_edit">
		<s:url action="#" includeParams="none" namespace="/" />
	</s:param>
	<s:param name="fb_del">#</s:param>	
</s:include>
<div style="vertical-align: top;">
<table width="650px;" cellpadding="0" cellspacing="1" class="form"
	style="vertical-align: top;">
	<thead>
		<tr>
			<td colspan="4">经费报销传送</td>
			<s:hidden name="wipe.id" />
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>禀议编号</td>
			<td><s:property value="wipe.wCode" /></td>
			<td>联系电话</td>
			<td><s:property value="wipe.tel" />
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
</div>
<br>
<br>
<br>
<table width="650px;" cellpadding="0" cellspacing="1" class="form">
	<tr>
		<td colspan="5" align="center">指示事项列表</td>
	</tr>
	<tr>
		<td>审批人编号</td>
		<td>审批人名字</td>
		<td>审批时间</td>
		<td>指示事项</td>
	</tr>
	<s:iterator id="judgeList" value="judgeList" var="judge">
		<tr>
			<td><s:property value="user.id" /></td>
			<td><s:property value="user.rName" /></td>
			<td><s:property value="judgeDate" /></td>
			<td><s:property value="jDirect" /></td>
		</tr>
	</s:iterator>
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
<s:form action="wipe_sendWipe" namespace="/" theme="simple">
	<table width="650px;" cellpadding="0" cellspacing="1" class="form"
		id="sendWipe">
		<tr>
			<td>接收人<s:hidden name="wipe.Id"/></td>

			<td><s:hidden name="uId" id="uId1" /> <s:textfield name="rUser"
				id="rUser1" theme="simple" cssClass="required UserSel,required"
				onclick="selUser1('uId1','rUser1')" /></td>

			<td></td>
		</tr>
	</table>

	<table>
		<tr>
			<td><input type="button" value="增加" id="addBtn"/></td>
			<td><input type="button" value="传送" id="sendBtn" /></td>
		</tr>
	</table>
</s:form>

<SCRIPT type="text/javascript">

function selUser1(id,name){

    var idField = document.getElementById(id);
	
	var nameField = document.getElementById(name);
	
	var url = '<s:url action="userSel_depts" includeParams="none" namespace="/"/>';
	
	var rev = window.showModalDialog(url, null, "dialogHeight:320px;dialogWidth:480px;help:0;status:0;scroll:0;resizable:1");
	
	if (rev) {
		idField.value = rev[0];
		nameField.value = rev[1];
	}
	
}

function selUser(id,name){
    var idField = document.getElementById(id);
	
	var nameField = document.getElementById(name);

	var url = '<s:url action="userSel_depts" includeParams="none" namespace="/"/>';
	
	var rev = window.showModalDialog(url, null, "dialogHeight:320px;dialogWidth:480px;help:0;status:0;scroll:0;resizable:1");
	
	if (rev) {
		idField.value = rev[0];
		nameField.value = rev[1];
	}
}

function check(id,name){
    
    var idField = document.getElementById(id);
	
	var nameField = document.getElementById(name);

    if(idField.value==""||nameField.value=="")
    {
        alert("请选择接收人员@");
        return false;
    }

}


//增加接收人
$("#addBtn").click(function(){
   var $table=$("#sendWipe tr");
   var len=$table.length;    
$("#sendWipe").append("<tr id="+(len+1)+"><td>接收人</td><td><input type=\'hidden\' name=\'uId\' id=\'uId"+(len+1)+"\'><input type=\'test\' name=\'rUser\' id=\'rUser"+(len+1)+"\'  onclick=selUser(\'uId"+(len+1)+"\',\'rUser"+(len+1)+"\') cssClass=\'required UserSel\'></td><td><input type=\'button\' name=\'del\' id=\'del\' onclick=\'deltr("+(len+1)+")\' value=\'删除\'></td></tr>");
});

// delete method
 function deltr(index)
 {
      $table=$("#sendWipe tr");
      if(index>$table.length)
                return;
       else
       {
            $("tr[id=\'"+index+"\']").remove(); 
            for(var temp=index+1;temp<=$table.length;temp++)
            {

                 $("tr[id=\'"+temp+"\']").replaceWith("<tr id="+(temp-1)+"><td>接收人</td><td><input type=\'hidden\' name=uId"+(temp-2)+"><input type=\'test\' name=rUser"+(temp-2)+"  onclick=\'selUser('uId"+(temp-2)+"','rUser"+(temp-2)+"')\' cssClass=\'required UserSel\'></td><td><input type=\'button\' name=\'del\' id='\del\' onclick='\deltr("+(temp-2)+")\' value='\删除\'></td></tr>");
             } 
       } 
 }
 
//传送
	$("#sendBtn").click(function(){
		if($("#wipe_sendWipe").valid()){
			$.messager.prompt('禀议码验证', '请输入禀议码!', function(val){
				if (val){
			 		$.post('<s:url action="ringi_checkCode" includeParams="none" namespace="/"/>', {"ringiShoCode":val} ,function(text){
			 			var obj = eval(text);
			 			if(obj.checked){
			 				$("#wipe_sendWipe").submit();
			 			}else{
			 				$.messager.alert('提示信息','禀议码错误!','warning');
			 			}
			 		});						
				}
			}); 
		 }
});
</SCRIPT>
</body>
</html>