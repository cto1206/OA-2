<%@ page language="java" pageEncoding="UTF-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.hanbang.core.utils.ActionUtil;"%>
<html>
<head>
	<title>经费报销表单</title>
	<link rel="stylesheet" href="<s:url value='/css/form.css' includeParams='none' encode='false' />" type="text/css"/>
	<s:head template="jquery" id="wipe_save"/>
	<s:head template="messager" />
</head>
<body>
	<s:include value="/apps/pageHeader.jsp">
		<s:param name="fb_title">系统管理-经费报销表单</s:param>
		<s:param name="fb_add">#</s:param>
		<s:param name="fb_edit">#</s:param>
		<s:param name="fb_del">#</s:param>
	</s:include>
<div>
<s:form action="wipe_save" namespace="/" theme="simple">
	<table width="650px;" cellpadding="0" cellspacing="1" class="form">
			<thead>
				<tr>
					<td colspan="4">报销申请<s:property value="title"/></td>
					<s:hidden name="wipe.id"/>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>禀议序号</td>
					<td><s:textfield name="wipe.wCode" theme="simple" cssClass="required" maxlength="20" ></s:textfield></td>
					<td>作成者</td>
					<td><s:hidden name="wipe.wUser.id"/><s:textfield name="wipe.wUser.rName" theme="simple" cssClass="required" maxlength="20"/></td>
				</tr>
				<tr>
					<td>禀议标志</td>
					<td>
<s:select list="#{'1':'汉邦钢构','2':'港盛涂装','3':'建力设备','4':'港盛联合'}"  name="wipe.title" theme="simple" cssClass="required" onchange="setIcon(this)"/>					
					</td>
					<td colspan="2"><img id="img_title" src="<s:property value="imgRootUrl"/>hb.png" style="width:28px;height:28px;"></td>
				</tr>
				
				<tr>
				    <td>联系电话</td><td><s:textfield name="wipe.tel" theme="simple" cssClass="phone" value="%{#session[@com.hanbang.core.utils.Constants@LOGIN_INFO].tel}"/></td>
					<td>申请日期</td><td><s:textfield name="wipe.wApTime" theme="simple" cssClass="required"></s:textfield></td>	
				</tr>
				<tr>
					<td>合计金额</td><td><s:textfield name="wipe.wTotal" theme="simple" cssClass="required number" maxlength="20" /></td>
					<td>类    别</td><td><s:select list="#{'0':'部内决裁','1':'部外决裁'}" name="wipe.wType" theme="simple" cssClass="required"/></td>
				</tr>
				<tr>
					<td>一级审查</td>
					<td>
						<s:hidden name="wipe.judgeSet[0].user.id"/>
						<s:textfield name="wipe.judgeSet[0].user.rName"  theme="simple" cssClass="required UserSel" onclick="selUser('wipe.judgeSet[0].user.id','wipe.judgeSet[0].user.rName')"/>
					</td>
					<td>二级决裁</td>
					<td>
						<s:hidden name="wipe.judgeSet[1].user.id"/>
						<s:textfield name="wipe.judgeSet[1].user.rName" theme="simple" cssClass="required UserSel" onclick="selUser('wipe.judgeSet[1].user.id','wipe.judgeSet[1].user.rName')"/>
					</td>
				</tr>								
				<tr id="tr_3" style="display:none">
					<td>三级决裁</td>
					<td>
						<s:hidden name="wipe.judgeSet[2].user.id" />
						<s:textfield name="wipe.judgeSet[2].user.rName"  id="sanji" theme="simple" cssClass="required UserSel"  onclick="selUser('wipe.judgeSet[2].user.id','wipe.judgeSet[2].user.rName')"/>
					</td>				
					<td>四级合议</td>
					<td>
						<s:hidden name="wipe.judgeSet[3].user.id" />
						<s:textfield name="wipe.judgeSet[3].user.rName" theme="simple" id="siji"  cssClass="required UserSel"  onclick="selUser('wipe.judgeSet[3].user.id','wipe.judgeSet[3].user.rName')"/>
	
					    <s:hidden name="wipe.judgeSet[4].user.id"  />
						<s:hidden name="wipe.judgeSet[4].user.rName"  />
					</td>
				</tr>										
				<tr><td>备    注</td><td colspan="3"><s:textarea name="wipe.wRemark" theme="simple" cssStyle="width:480px;"></s:textarea></td></tr>			
			</tbody>
</table>

   <input type="button" value="添加经费项目" id="addBtn" onClick="insRow()" >
<table width="650px;" cellpadding="0" cellspacing="1" class="form" id="tableItem">
       <tr><td colspan="7" align="center">经费项目列表</td></tr>
	   <tr><td>经费项目</td><td>经费总金额</td>
	   <td>删除</td>
	   <td>经费项目详细</td></tr>
</table>

<table width="650px;" cellpadding="0" cellspacing="1" class="form" id="itemDetailList">
		<tr><td colspan="6" align="center">经费项目详细</td></tr>
		<tr>
		    <td>经费项目</td><td>日期</td><td>报销金额</td><td>摘要</td><td>备注</td><td>删除</td>
      </tr>
	</table>
	
	<table width="650px;" cellpadding="0" cellspacing="1" class="form">
	  <tr>
	  <td align="center"><input type="button" id="saveBtn" value="保存" />

	  </td>
	  
	</tr></table>
	
	
</s:form>


<s:include value="/apps/pageFooter.jsp"/>
</body>
<script type="text/javascript">

function deleteRow(obj){
	var tr=obj.parentNode.parentNode;
	var tbody=tr.parentNode; 
	tbody.removeChild(tr); 
} 

function showDiv(obj){
	var index=obj.parentNode.parentNode.rowIndex;
	var inputValue=document.getElementById("itemDetailList").getElementsByTagName("TR")[index].getElementsByTagName("INPUT")[4];
	var str=window.showModalDialog("apps/wipe/input.html",inputValue,'dialogHeight:270px;dialogWidth:270px;help:0;status:0;scroll:0;resizable:1');
	inputValue.value=str; 

}

function showDivBrief(obj){
	var index=obj.parentNode.parentNode.rowIndex;
	var inputValue=document.getElementById("itemDetailList").getElementsByTagName("TR")[index].getElementsByTagName("INPUT")[3];
	var str=window.showModalDialog("apps/wipe/input.html",inputValue,'dialogHeight:270px;dialogWidth:270px;help:0;status:0;scroll:0;resizable:1');
	inputValue.value=str; 
}

	//添加经费项目
function insRow() {
    var x=document.getElementById('tableItem').insertRow(document.getElementById('tableItem').rows.length);
    var item=x.insertCell(0);
	var money=x.insertCell(1);
	var del=x.insertCell(2);
	var detail=x.insertCell(3);	
	var len=document.getElementById('tableItem').rows.length;
	item.innerHTML='<input type="text" name="wipeItemList['+(len-3)+'].iItem" style="width:400px">';
	money.innerHTML='<s:textfield name="wipeItemList['+(len-3)+'].iMoney" style="width:100px" cssClass="required number" theme="simple"/>';
	del.innerHTML='<a onclick="javascript:deleteCurrentRow(this)">删除</a>';
	detail.innerHTML='<a onclick="javascript:insRowDetail(this)">经费项目详细</a>';
}

	//添加经费项目详细
function insRowDetail(obj) {
    var index=obj.parentNode.parentNode.rowIndex;
    var inputValue=document.getElementById("tableItem").getElementsByTagName("TR")[index].getElementsByTagName("INPUT")[0];
	var x=document.getElementById('itemDetailList').insertRow(document.getElementById('itemDetailList').rows.length);
    var item=x.insertCell(0);
	var day=x.insertCell(1);
	var money=x.insertCell(2);
	var brief=x.insertCell(3);
	var remark=x.insertCell(4);
	var del=x.insertCell(5);
	
	var len=document.getElementById('itemDetailList').rows.length;

	item.innerHTML="<input type='text' name='wipeItemDetailList["+(len-3)+"].wipeItem.iItem' style='width:95px' value='"+inputValue.value+"'>";
	day.innerHTML='<input type="text" name="wipeItemDetailList['+(len-3)+'].itemDetailDate" style="width:75px">';
	money.innerHTML='<s:textfield  name="wipeItemDetailList['+(len-3)+'].itemDetailMoney" style="width:75px" theme="simple" cssClass="required number"/>';
	brief.innerHTML='<input type="text" name="wipeItemDetailList['+(len-3)+'].itemDetailBrief"  onclick="showDivBrief(this)">';
	remark.innerHTML='<input type="text" name="wipeItemDetailList['+(len-3)+'].itemDetailRemark" onclick="showDiv(this)">';	
    del.innerHTML='<a onclick="javascript:deleteRow(this)">删除</a>';
}

function deleteCurrentRow(obj){ 
	if(window.confirm("确定删除该经费报销大类吗？那对应的子类也将删除？")){
	    var index=obj.parentNode.parentNode.rowIndex;
	    var itemValue=document.getElementById("tableItem").getElementsByTagName("TR")[index].getElementsByTagName("INPUT")[0];

	    var len=document.getElementById("itemDetailList").rows.length;
	    var k=2;
		for(i=2; i <len; i++){
		   var detailValue=document.getElementById("itemDetailList").getElementsByTagName("TR")[k].getElementsByTagName("INPUT")[0];
		   if(itemValue.value==detailValue.value)
		   {
		       document.getElementById("itemDetailList").deleteRow(k);
		   }
		   else
	       {
	         k++;
	       }
		}
		var tr=obj.parentNode.parentNode; 
		var tbody=tr.parentNode; 
		tbody.removeChild(tr); 
	}
	
} 	 
$(function(){
    //保存经费报销单
	$("#saveBtn").click(function(){
		if($("#wipe_save").valid()){
			$.messager.prompt('禀议码验证', '请输入禀议码!', function(val){
				if (val){
			 		$.post('<s:url action="ringi_checkCode" includeParams="none" namespace="/"/>', {"ringiShoCode":val} ,function(text){
			 			var obj = eval(text);
			 			if(obj.checked){
			 				$("#wipe_save").submit();//.ajaxSubmit();
			 			}else{
			 				$.messager.alert('提示信息','禀议码错误!','warning');
			 			}
			 		});						
				}
			});
		} 
	});
	
    $("select[name='wipe.wType']").change(function(){
		selLevel($(this).val()); 
	});

	//决裁级别选择
	function selLevel(le){
		if(le == 0){
			$('#tr_3').hide();	
            $('#sanji').attr('disabled',true);
            $('#siji').attr('disabled',true);
		}else if(le == 1){
			$('#tr_3').show(); 
		    $('#sanji').attr('disabled',false);
            $('#siji').attr('disabled',false);	
		}
	}
	selLevel(0);
	
	$('input.UserSel').each(function(){
		$(this).css('background','#fff url(<s:property value="imgRootUrl"/>users.png) no-repeat right');   
		$(this).css('border','#999 1px solid');
		$(this).css('cursor','pointer');
		$(this).attr('readOnly',true);
	});
});
	

function setIcon(o){
	var img_obj = document.getElementById('img_title');
	var icon = '';
	switch(parseInt(o.value)){
		case 1: icon = 'hb.png';
			break;
		case 2: icon = 'gs.png';
			break;
		case 3: icon = 'jl.png';
			break;
		case 4: icon = 'lh.png';
			break;
	}
	img_obj.src = '<s:property value="imgRootUrl"/>' + icon;
}
//人员选择
function selUser(id,name){
	var idField = document.getElementsByName(id)[0];
	var nameField = document.getElementsByName(name)[0];
	var url = '<s:url action="userSel_depts" includeParams="none" namespace="/"/>';	
	var rev = window.showModalDialog(url, null, "dialogHeight:430px;dialogWidth:480px;help:0;status:0;scroll:0;resizable:1");
	if (rev) {
		idField.value = rev[0];
		nameField.value = rev[1];
	}
}

function openIt(){
	var width = 480;
	var height = 320;
	var top = (screen.height-height)/2;
	var left = (screen.width-width)/2;
	var url = '<s:url action="userSel_depts" includeParams="none" namespace="/"/>';   
	window.open(url,'newwindow','height=' + height + ',width=' + width + ',top=' + top + ',left=' + left + ',toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no, status=no');
}
</script>
</html>