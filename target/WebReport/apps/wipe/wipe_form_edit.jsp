<%@ page language="java" pageEncoding="UTF-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.hanbang.core.utils.ActionUtil;"%>
<html>
<head>
	<title>经费报销表单</title>
	<link rel="stylesheet" href="<s:url value='/css/form.css' includeParams='none' encode='false' />" type="text/css"/>
	<s:head template="jquery" />
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
		<s:form action="wipe_myreapply" namespace="/" theme="simple" >
		<table width="650px;" cellpadding="0" cellspacing="1" class="form">
			<thead>
				<tr>
					<td colspan="4"><s:property value="title"/></td>
					<s:hidden name="reApply"/>
					<s:hidden name="upd"/>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>禀议序号</td>
					<td>
					<s:textfield name="wipe.wCode" theme="simple"  maxlength="20" ></s:textfield>
					</td>
					<td>作成者</td><td><s:hidden name="wipe.wUser.id" /><s:textfield disabled="true" name="wipe.wUser.rName" theme="simple" cssClass="required" maxlength="20"/></td>
					
				</tr>
				<tr>
					<td>禀议标志</td>
					<td>
<s:select list="#{'1':'汉邦钢构','2':'港盛涂装','3':'建力设备','4':'港盛联合'}"  name="wipe.title" theme="simple" cssClass="required" onchange="setIcon(this)"/>					
					</td>
					<td colspan="2"><img id="img_title" src="<s:property value="imgRootUrl"/>hb.png" style="width:28px;height:28px;"></td>
				</tr>
				
				<tr>
				    <td>联系电话</td><td><s:textfield name="wipe.tel" theme="simple" cssClass="phone"/></td>
					<td>申请日期</td><td><s:textfield name="wipe.wApTime" disabled="false" ></s:textfield></td>	
				</tr>
				
				
				<tr>
					<td>合计金额</td><td><s:textfield name="wipe.wTotal" theme="simple" cssClass="required number" maxlength="20" value="100" /></td>
					<td>类别</td><td><s:select  list="#{'1':'部外决裁','0':'部内决裁'}" name="wipe.wType" theme="simple" onchange="setType('wipe.wType','wipe.judgeSet[2].user.rName','wipe.judgeSet[3].user.rName','wipe.judgeSet[4].user.rName')"/></td>
				</tr>
				
				<tr>
					<td>一级审查</td>
					<td>
						<s:hidden name="wipe.judgeSet[0].user.id"/>
						<s:textfield name="wipe.judgeSet[0].user.rName" theme="simple" cssClass="required UserSel" onclick="selUser('wipe.judgeSet[0].user.id','wipe.judgeSet[0].user.rName')"/>
					</td>
					<td>二级决裁</td>
					<td>
						<s:hidden name="wipe.judgeSet[1].user.id"/>
						<s:textfield name="wipe.judgeSet[1].user.rName" theme="simple" cssClass="required UserSel" onclick="selUser('wipe.judgeSet[1].user.id','wipe.judgeSet[1].user.rName')"/>
					</td>
				</tr>	
				
				<s:if test="#attr.wipe.wType==1">							
				<tr>
					<td>三级决裁</td>
					<td>
						<s:hidden name="wipe.judgeSet[2].user.id"/>
						<s:textfield  name="wipe.judgeSet[2].user.rName" theme="simple" cssClass="required UserSel"  onclick="selUser('wipe.judgeSet[2].user.id','wipe.judgeSet[2].user.rName')"/>
					</td>
					
					<td>四级合议</td>
					<td>
						<s:hidden name="wipe.judgeSet[3].user.id"/>
						<s:textfield  name="wipe.judgeSet[3].user.rName" theme="simple" cssClass="required UserSel"  onclick="selUser('wipe.judgeSet[3].user.id','wipe.judgeSet[3].user.rName')"/>
					</td>
				</tr>								
				<tr>
					<td>五级合议</td>
						<td>
							<s:hidden name="wipe.judgeSet[4].user.id"/>
							<s:textfield name="wipe.judgeSet[4].user.rName" theme="simple" cssClass="required UserSel"  onclick="selUser('wipe.judgeSet[4].user.id','wipe.judgeSet[4].user.rName')"/>
						</td>
						<td></td>
						<td></td>
						
				</tr>
				</s:if>
				
				
				<s:if test="#attr.wipe.wType==0">							
				<tr>
					<td>三级决裁</td>
					<td>
						<s:hidden name="wipe.judgeSet[2].user.id"/>
						<s:textfield disabled="true" name="wipe.judgeSet[2].user.rName"  theme="simple" cssClass="required UserSel"  onclick="selUser('wipe.judgeSet[2].user.id','wipe.judgeSet[2].user.rName')"/>
					</td>
					
					<td>四级合议</td>
					<td>
						<s:hidden name="wipe.judgeSet[3].user.id"/>
						<s:textfield disabled="true" name="wipe.judgeSet[3].user.rName" theme="simple" cssClass="required UserSel"  onclick="selUser('wipe.judgeSet[3].user.id','wipe.judgeSet[3].user.rName')"/>
					</td>
				</tr>								
				<tr>
					<td>五级合议</td>
						<td>
							<s:hidden name="wipe.judgeSet[4].user.id"/>
							<s:textfield disabled="true" name="wipe.judgeSet[4].user.rName" theme="simple" cssClass="required UserSel"  onclick="selUser('wipe.judgeSet[4].user.id','wipe.judgeSet[4].user.rName')"/>
						</td>
						<td></td>
						<td></td>
						
				</tr>
				</s:if>
				
				
				<tr><td>备注</td><td colspan="3"><s:textarea name="wipe.wRemark" theme="simple" cssStyle="width:450px;"></s:textarea></td></tr>
			</tbody>
			<tfoot>
				<tr>
<s:if test="#attr.mybtn=='ok'">			
<td colspan="4" align="right"><input type="button" value="添加" id="okBtn" disabled="disabled"></td>
</s:if>
<s:else>
<td colspan="4" align="right"><input type="button" value="添加" id="okBtn"></td>
</s:else>

				</tr>
			</tfoot>
		</table>
		</s:form>
	</div>
		

 <s:if test="#attr.disalbe=='false'">
 <div id="addWipeBtn" style="visibility: true;display: block">
<table width="400px;" cellpadding="0" cellspacing="0" class="form"><tr><td>
<input type="button" value="添加经费项目" id="addWipeItem"  onclick="showAddWipeForm()">
</td></tr></table>
</div>	 
 </s:if>
 
  
 <s:else>
 <div id="addWipeBtn" style="visibility: false;display: none">
<table width="400px;" cellpadding="0" cellspacing="1" class="form"><tr><td>
<input type="button" value="添加经费项目" id="addWipeItem"  onclick="showAddWipeForm()">
</td></tr></table>
</div>	 
 </s:else>


<s:if test="#attr.itemDisable=='false'">
<div id="addWipeForm" style="visibility: true;display: block">
	<s:form action="wipeItem_save" namespace="/" theme="simple">
	<table width="400px;" cellpadding="0" cellspacing="1" class="form">
		<tbody>										
			<tr>
              <td>经费报销编号<s:hidden name="wipeItem.wipe.id"></s:hidden></td>
			  <td><s:textfield name="wipeItem.wipe.wCode" theme="simple" cssClass="required" maxlength="25" disabled="true"/></td></tr>
			<tr><td>经费项目</td><td><s:textfield name="wipeItem.iItem" theme="simple" cssClass="required" maxlength="25"/></td></tr>	
			<tr><td>项目总金额</td><td><s:textfield name="wipeItem.iMoney" theme="simple" cssClass="required number" value="100"/></td></tr>	
            <tr><td colspan="2" align="right"><input type="button" value="保存" id="myokBtn" ></td></tr>  
	</table>
	</s:form>
</div>
</s:if>

<s:else>
<div id="addWipeForm" style="visibility: false;display: none">
	<s:form action="wipeItem_save" namespace="/" theme="simple">
	<table width="400px;" cellpadding="0" cellspacing="1" class="form">
		<tbody>										
			<tr>
			   
            <td>经费报销编号<s:hidden name="wipeItem.wipe.id"></s:hidden>
            </td><td><s:textfield name="wipeItem.wipe.wCode" theme="simple" cssClass="required" maxlength="25" disabled="true"/></td></tr>
			<tr><td>经费项目</td><td><s:textfield name="wipeItem.iItem" theme="simple" cssClass="required" maxlength="25"/></td></tr>
			<tr><td>项目总金额</td><td><s:textfield name="wipeItem.iMoney" theme="simple" cssClass="required number" value="100"/></td></tr>	
            <tr><td colspan="2" align="right"><input type="button" value="保存" id="myokBtn" ></td></tr>   
	</table>
	</s:form>
</div>
</s:else>

<s:if test="#attr.itemDisable=='false'">
<div id="wipeList" style="visibility: true;display: block">
<table>
	<tr><td>
		<table width="650px;" cellpadding="0" cellspacing="1" class="form">
         <tr><td colspan="5" align="center">经费项目</td></tr>
			  <tr>
			    <td>经费报销编号</td><td>经费项目</td><td>经费总金额</td><td>删除</td><td>经费项目详细</td>
			    </tr>
			<s:iterator id="wipeItemList" value="wipeItemList" var="myWipeItem">
			    <tr>
			 
			       <td><s:hidden name="id"></s:hidden><s:property value="wipe.wCode"/></td>
			       <td><s:property value="iItem"/></td>
			       <td><s:property value="iMoney" /></td>
			       <td><a href="wipeItem_delete.action?key=<s:property value='id'/>">删除</a></td>
			       <td><a onclick="showAddWipeItemDetailForm(<s:property value='id'/>)">添加经费项目详细</a></td>
			    </tr>
			</s:iterator>
			</table>
	</td></tr>
</table>
</div>
</s:if>

<s:else>
<div id="wipeList" style="visibility: false;display: none">
<table>
	<tr><td>
		<table width="650px;" cellpadding="0" cellspacing="1" class="form">
         <tr><td colspan="5" align="center">经费项目</td></tr>
			  <tr>
			    <td>经费报销编号</td><td>经费项目</td><td>经费总金额</td><td>删除</td><td>经费项目详细</td>
			    </tr>
			<s:iterator id="wipeItemList" value="wipeItemList" var="myWipeItem">
			    <tr>
			       <td><s:hidden name="id"></s:hidden><s:property value="wipe.wCode"/></td>
			       <td><s:property value="iItem"/></td>
			       <td><s:property value="iMoney"/></td> 
			       <td><a href="wipeItem_delete.action?key=<s:property value='id'/>">删除</a></td>
			       <td><a onclick="showAddWipeItemDetailForm(<s:property value='id'/>)">添加经费项目详细</a></td>
			    </tr>
			</s:iterator>
			</table>
	</td></tr>
</table>
</div>
</s:else>



<s:if test="#attr.itemDetailDisable=='false'">
<div id="addWipeItemDetailForm" style="visibility: true;display: block">
<s:form action="wipeItemDetail_save" namespace="/" theme="simple">
	<table width="400px;" cellpadding="0" cellspacing="1" class="form">
		<tbody>
			<tr>
				<td colspan="4" align="left">费用报销项目明细表单</td>
			</tr>
			<tr>
				<td>经费项目</td>	
				<td>
				<s:hidden name="wipeItemDetail.wipeItem.id"></s:hidden>
				<s:textfield name="wipeItemDetail.wipeItem.iItem"  theme="simple" cssClass="required" maxlength="25" disabled="true"/></td>
			</tr>
			<tr>
				<td>日期</td>
				<td><s:textfield name="wipeItemDetail.itemDetailDate"
					theme="simple"
					onfocus="WdatePicker({isShowClear:false,readOnly:true})"
					cssClass="required Wdate dateISO" /></td>
			</tr>
			<tr>
				<td>报销金额</td>
				<td><s:textfield name="wipeItemDetail.itemDetailMoney"
					cssClass="required number" maxlength="25" value="50"/></td>
			</tr>
			<tr>
				<td>摘要</td>
				<td><s:textfield name="wipeItemDetail.itemDetailBrief" /></td>
			</tr>
			<tr>
				<td>备注</td>
				<td colspan="3"><s:textarea
					name="wipeItemDetail.itemDetailRemark" theme="simple" rows="3" /></td>
			</tr>
			  <tfoot>
			     <tr>
				<td colspan="4" align="right"><input type="button" value="保存" id="itemDetailBtn" ></td>
			   </tr>
		    </tfoot>
	</table>
</s:form></div>	
</s:if>

<s:else>
<div id="addWipeItemDetailForm" style="visibility: false;display: none">
<s:form action="wipeItemDetail_save" namespace="/" theme="simple">
	<table width="400px;" cellpadding="0" cellspacing="1" class="form">
		<tbody>
			<tr>
				<td colspan="4" align="left">费用报销项目明细表单</td>
			</tr>
			<tr>
				<td>经费项目</td>	
				<td>
				<s:hidden name="wipeItemDetail.wipeItem.id"></s:hidden>
				<s:textfield name="wipeItemDetail.wipeItem.iItem"  theme="simple" cssClass="required" maxlength="25" disabled="true"/></td>
			</tr>
			<tr>
				<td>日期</td>
				<td><s:textfield name="wipeItemDetail.itemDetailDate"
					theme="simple"
					onfocus="WdatePicker({isShowClear:false,readOnly:true})"
					cssClass="required Wdate dateISO" /></td>
			</tr>
			<tr>
				<td>报销金额</td>
				<td><s:textfield name="wipeItemDetail.itemDetailMoney"
					cssClass="required number" maxlength="25" value="50"/></td>

			</tr>

			<tr>
				<td>摘要</td>
				<td><s:textfield name="wipeItemDetail.itemDetailBrief" /></td>
			</tr>

			<tr>
				<td>备注</td>
				<td colspan="3"><s:textarea
					name="wipeItemDetail.itemDetailRemark" theme="simple" rows="3" /></td>
			</tr>
			  <tfoot>
			     <tr>
				<td colspan="4" align="right"><input type="button" value="保存" id="itemDetailBtn" ></td>
			   </tr>
		    </tfoot>
	</table>
</s:form></div>	
</s:else>

<s:if test="#attr.itemDetailDisable=='false'">
<div id="wipeItemDetailList" style="visibility: true;display: block">
<table width="650px;" cellpadding="0" cellspacing="1" class="form">
		<tr><td colspan="6" align="center">经费项目详细</td></tr>
		<tr>
		    <td>经费项目</td><td>日期</td><td>报销金额</td><td>摘要</td><td>备注</td><td>删除</td>
		   </tr>
		<s:iterator id="wipeItemDetailList" value="wipeItemDetailList" var="wipeItemDetail">
		  <tr>
		       <td><s:hidden name="id"></s:hidden><s:property value="wipeItem.iItem"/></td>
		       <td><s:property value="itemDetailDate"/></td>
		       <td><s:property value="itemDetailMoney"/></td>
		        <td><s:property value="itemDetailBrief"/></td>
		       <td><s:property value="itemDetailRemark"/></td>
		       <td><a href="wipeItemDetail_delete.action?key=<s:property value='id'/>">删除</a></td>
		 </tr>
		</s:iterator>
		</table>
</div>
</s:if>
<s:else>
<div id="wipeItemDetailList" style="visibility: false;display: none">
<table width="650px;" cellpadding="0" cellspacing="1" class="form">
		<tr><td colspan="6" align="center">经费项目详细</td></tr>
		<tr>
		    <td>经费项目</td><td>日期</td><td>报销金额</td><td>摘要</td><td>备注</td><td>删除</td>
		   </tr>
		<s:iterator id="wipeItemDetailList" value="wipeItemDetailList" var="wipeItemDetail">
		  <tr>
		       <td><s:hidden name="id"></s:hidden><s:property value="wipeItem.iItem"/></td>
		       <td><s:property value="itemDetailDate"/></td>
		       <td><s:property value="itemDetailMoney"/></td>
		       <td><s:property value="itemDetailBrief"/></td>
		       <td><s:property value="itemDetailRemark"/></td>
		       <td><a href="wipeItemDetail_delete.action?key=<s:property value='id'/>">删除</a></td>
		 </tr>
		</s:iterator>
		</table>
</div>
</s:else>

<s:include value="/apps/pageFooter.jsp"/>

</body>
<script type="text/javascript">

	$('input.UserSel').each(function(){
		$(this).css('background','url(<s:property value="imgRootUrl"/>users.png) no-repeat right');   
	});
<!--显示addWipeItemDetail的form-->
function showAddWipeItemDetailForm(id)
{
   document.getElementById("addWipeItemDetailForm").style.display = "block";
   if(id == '')
   return;	 
   var url='<s:url action="wipeItem_get" includeParams="none" namespace="/"/>';	 
   $.post(url, {"key":id} ,function(wipeItem){
   		var a = eval('(' + wipeItem + ')');	 
   		document.getElementsByName("wipeItemDetail.wipeItem.id")[0].value=a.id;    
   		document.getElementsByName("wipeItemDetail.wipeItem.iItem")[0].value=a.item;      
   });	
}


<!--显示addWipeItem的form-->
function showAddWipeForm()
{
   document.getElementById("addWipeForm").style.display="block";
   document.getElementById("wipeList").style.display="block";
}

function add(url)
{
   var rev = window.showModalDialog(url, null, "dialogHeight:300px;dialogWidth:470px;help:0;status:0;scroll:0;resizable:1");
}

function setType(type,sanji,siji,wuji){
	var type= document.getElementsByName(type)[0];
	var sanji=document.getElementsByName(sanji)[0];
	var siji=document.getElementsByName(siji)[0];
	var wuji=document.getElementsByName(wuji)[0];
	//部内
	if(type.value=="0"){
	    sanji.disabled=true;
		siji.disabled=true;
		wuji.disabled=true;
		sanji.value="";
		siji.value="";
		wuji.value="";
	}
	if(type.value=="1"){
	    sanji.disabled=false;
		siji.disabled=false;
		wuji.disabled=false;
	}
}
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
//批准
	$("#okBtn").click(function(){
		if($("#wipe_myreapply").valid()){
			$.messager.prompt('禀议码验证', '请输入禀议码!', function(val){
				if (val){
			 		$.post('<s:url action="ringi_checkCode" includeParams="none" namespace="/"/>', {"ringiShoCode":val} ,function(text){
			 			var obj = eval(text);
			 			if(obj.checked){
			 				$("#wipe_myreapply").submit();
			 			}else{
			 				$.messager.alert('提示信息','禀议码错误!','warning');
			 			}
			 		});						
				}
			}); 
		}
		
	});



	$("#myokBtn").click(function(){
		if($("#wipeItem_save").valid()){
			$.messager.prompt('禀议码验证', '请输入禀议码!', function(val){
				if (val){
			 		$.post('<s:url action="ringi_checkCode" includeParams="none" namespace="/"/>', {"ringiShoCode":val} ,function(text){
			 			var obj = eval(text);
			 			if(obj.checked){
			 				$("#wipeItem_save").submit();
			 			}else{
			 				$.messager.alert('提示信息','禀议码错误!','warning');
			 			}
			 		});						
				}
			}); 
		}
		
	});
	
	
		$("#itemDetailBtn").click(function(){
		if($("#wipeItemDetail_save").valid()){
			$.messager.prompt('禀议码验证', '请输入禀议码!', function(val){
				if (val){
			 		$.post('<s:url action="ringi_checkCode" includeParams="none" namespace="/"/>', {"ringiShoCode":val} ,function(text){
			 			var obj = eval(text);
			 			if(obj.checked){
			 				$("#wipeItemDetail_save").submit();
			 			}else{
			 				$.messager.alert('提示信息','禀议码错误!','warning');
			 			}
			 		});						
				}
			}); 
		}
		
	});
	

	
	
	
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