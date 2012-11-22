<%@ page language="java" pageEncoding="UTF-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.hanbang.core.utils.ActionUtil,java.math.BigDecimal;"%>
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
	</s:include>
	<s:form action="wipe_upd" namespace="/" theme="simple" >
		<s:hidden name="isCom"></s:hidden>
		<s:hidden name="ju1"></s:hidden>
		<table width="650px;" cellpadding="0" cellspacing="1" class="form">
			<thead>
				<tr>
					<td colspan="4">报销申请<s:property value="title"/></td>
					<s:hidden name="wipe.id"/>
					<s:hidden name="wipe.pId"/>
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
					<td>合计金额</td><td><s:textfield name="wipe.wTotal" theme="simple" cssClass="required number" maxlength="20" /></td>
					<td>类别</td><td>
					<s:select list="#{'0':'部内决裁','1':'部外决裁'}" name="wipe.wType" theme="simple"/></td>
				</tr>
				<tr>
					<td>一级审查</td>
					<td>
						<s:hidden name="wipe.judgeSet[0].user.id"/>
						<s:textfield name="wipe.judgeSet[0].user.rName" theme="simple" cssClass="required UserSel"  onclick="selUser('wipe.judgeSet[0].user.id','wipe.judgeSet[0].user.rName')"/>
					</td>
					<td>二级决裁</td>
					<td>
						<s:hidden name="wipe.judgeSet[1].user.id"/>
						<s:textfield name="wipe.judgeSet[1].user.rName" theme="simple" cssClass="required UserSel"  onclick="selUser('wipe.judgeSet[1].user.id','wipe.judgeSet[1].user.rName')"/>
					</td>
				</tr>	
				<s:if test="#attr.wipe.wType==1">
				<tr id="tr_3"><td>三级决裁</td>
					<td>
						<s:hidden name="wipe.judgeSet[2].user.id" id="sanjiId"/>
						<s:textfield name="wipe.judgeSet[2].user.rName" id="sanjiName" theme="simple" cssClass="required UserSel"  onclick="selUser('wipe.judgeSet[2].user.id','wipe.judgeSet[2].user.rName')"/>
					</td>				
					<td>四级合议</td>
					<td>
						<s:hidden name="wipe.judgeSet[3].user.id" id="sijiId"/>
						<s:textfield name="wipe.judgeSet[3].user.rName"  id="sijiName" theme="simple" cssClass="required UserSel" onclick="selUser('wipe.judgeSet[3].user.id','wipe.judgeSet[3].user.rName')"/>
					    <s:hidden name="wipe.judgeSet[4].user.id" value="2" id="wujiId"/>
						<s:hidden name="wipe.judgeSet[4].user.rName" value="钟海港" id="wujiName"/>
					</td>
				</tr>			
				</s:if>
				<s:else>
				<tr id="tr_3" style="display:none;">
				<td>三级决裁</td>
					<td>
						<s:hidden name="wipe.judgeSet[2].user.id" id="sanjiId" disabled="true"/>
						<s:textfield name="wipe.judgeSet[2].user.rName" id="sanjiName" disabled="true" theme="simple" cssClass="required UserSel"  onclick="selUser('wipe.judgeSet[2].user.id','wipe.judgeSet[2].user.rName')"/>
					</td>				
					<td>四级合议</td>
					<td>
						<s:hidden name="wipe.judgeSet[3].user.id" id="sijiId" disabled="true"/>
						<s:textfield name="wipe.judgeSet[3].user.rName"  disabled="true" id="sijiName" theme="simple" cssClass="required UserSel" onclick="selUser('wipe.judgeSet[3].user.id','wipe.judgeSet[3].user.rName')"/>
					    <s:hidden name="wipe.judgeSet[4].user.id" value="2" id="wujiId" disabled="true"/>
						<s:hidden name="wipe.judgeSet[4].user.rName" value="钟海港" id="wujiName" disabled="true"/>
					</td>
				</tr>	
				</s:else>
									

				<tr>
				     <td>备注</td><td colspan="3"><s:textarea name="wipe.wRemark" cssStyle="width:480px;"></s:textarea></td>
				</tr>
			</tbody>			
		</table>
	<input type="button" value="添加经费项目" id="addBtn" onClick="insRow()" >

		<table width="650px;" cellpadding="0" cellspacing="1" class="form" id="itemList">
         <tr><td colspan="7" align="center">经费项目</td></tr>
			  <tr>
		       <td>经费报销编号</td><td>经费项目</td><td>经费总金额</td><td>删除</td><td>经费项目详细</td>
			    </tr>
			<s:iterator id="wipeItemList" value="wipeItemList" var="myWipeItem" status="i">
			    <tr>
			       <td>
			       <s:hidden name="wipeItemList[%{#i.index}].id" value="%{#myWipeItem.id}" theme="simple"/>
			       <s:textfield name="wipeItemList[%{#i.index}].wipe.wCode" value="%{#myWipeItem.wipe.wCode}" theme="simple"/></td>
			       <td><s:textfield name="wipeItemList[%{#i.index}].iItem" value="%{#myWipeItem.iItem}" theme="simple" cssClass="required"></s:textfield></td>
			       <td><s:textfield  name="wipeItemList[%{#i.index}].iMoney" value="%{#myWipeItem.iMoney}" theme="simple" cssClass="required number"></s:textfield></td> 
			       <td><s:a onclick="javascript:deleteCurrentRow(this)">删除</s:a></td>
			       <td><a onclick="javascript:insRowDetail(this)">经费项目详细</a></td>
			    </tr>
			</s:iterator>
			</table>
<s:hidden name="itemString"/>
<s:hidden name="detailString" />

<script type="text/javascript">
function deleteCurrentRow(obj){
	if(window.confirm("确定删除该经费报销大类吗？那对应的子类也将删除？")){
	    var index=obj.parentNode.parentNode.rowIndex;
	    var itemValue=document.getElementById("itemList").getElementsByTagName("TR")[index].getElementsByTagName("INPUT")[2];
	    var len=document.getElementById("detailList").rows.length;
		var k=2;
		for(i=2; i <len ; i++){
		      var detailValue=document.getElementById("detailList").getElementsByTagName("TR")[k].getElementsByTagName("INPUT")[1];
              if(itemValue.value==detailValue.value)
		      {
		         
				var dValue=document.getElementById("detailList").getElementsByTagName("TR")[k].getElementsByTagName("INPUT")[0].value;
				var detailValue=document.getElementsByName("detailString")[0].value;
				
				if(detailValue=="")
				    detailValue=detailValue+dValue;
				else
				    detailValue=detailValue+","+dValue;
				    
				document.getElementsByName("detailString")[0].value=detailValue;
		        document.getElementById("detailList").deleteRow(k);
		      }
		      else
		      {
		         k++;
		      }
		}
		
		
		var idValue=document.getElementById("itemList").getElementsByTagName("TR")[index].getElementsByTagName("INPUT")[0].value;
		var itemValue=document.getElementsByName("itemString")[0].value;
		if(itemValue=="")
		  itemValue=itemValue+idValue;
		else
		  itemValue=itemValue+","+idValue;
		  
	    document.getElementsByName("itemString")[0].value=itemValue;
		
		var tr=obj.parentNode.parentNode; 
		var tbody=tr.parentNode; 
		tbody.removeChild(tr); 
		
	}
} 	
function deleteRow(obj){
	var tr=obj.parentNode.parentNode;
	var tbody=tr.parentNode; 
	
	var dValue=tr.getElementsByTagName("INPUT")[0].value;
	var detailValue=document.getElementsByName("detailString")[0].value;
	
	if(detailValue=="")
	    detailValue=detailValue+dValue;
	else
	    detailValue=detailValue+","+dValue;
	    
	document.getElementsByName("detailString")[0].value=detailValue;
  
	tbody.removeChild(tr); 
} 	
	//添加经费项目
function insRow() {
    var myCode=document.getElementsByName("wipe.wCode")[0].value;
    var itemLen=document.getElementById('itemList').rows.length;
    var x=document.getElementById('itemList').insertRow(itemLen);
    var code=x.insertCell(0);
    var item=x.insertCell(1);
	var money=x.insertCell(2);
	var del=x.insertCell(3);
	var detail=x.insertCell(4);   
	code.innerHTML='<input type="hidden" name="wipeItemList['+(itemLen-2)+'].id"/><input type="text" name="wipeItemList['+(itemLen-2)+'].wipe.wCode" style="width:155px" cssClass="required" value="'+myCode+'">';
	item.innerHTML='<input type="text" name="wipeItemList['+(itemLen-2)+'].iItem" style="width:155px" style="width:90px">';
	money.innerHTML='<s:textfield name="wipeItemList['+(itemLen-2)+'].iMoney" style="width:155px" cssClass="required number" theme="simple"/>';
	del.innerHTML='<a onclick="javascript:deleteCurrentRow(this)">删除</a>';
	detail.innerHTML='<a onclick="javascript:insRowDetail(this)">经费项目详细</a>';
}
	//添加经费项目详细
function insRowDetail(obj) {
    var index=obj.parentNode.parentNode.rowIndex;
    var detailLen=document.getElementById('detailList').rows.length;
    var inputValue0=document.getElementById("itemList").getElementsByTagName("TR")[index].getElementsByTagName("INPUT")[0];
    var inputValue1=document.getElementById("itemList").getElementsByTagName("TR")[index].getElementsByTagName("INPUT")[1];
    var inputValue2=document.getElementById("itemList").getElementsByTagName("TR")[index].getElementsByTagName("INPUT")[2];   
    var inputValue;
    if(inputValue0.value.substring(0,2)=="JF")
    {   
	   inputValue=inputValue1.value;   
	}
	else
	{
	    inputValue=inputValue2.value;
	}
	var x=document.getElementById('detailList').insertRow(document.getElementById('detailList').rows.length);
    var item=x.insertCell(0);
	var day=x.insertCell(1);
	var money=x.insertCell(2);
	var brief=x.insertCell(3);
	var remark=x.insertCell(4);
	var del=x.insertCell(5);
	item.innerHTML="<input type='hidden' name='wipeItemDetailList["+(detailLen-2)+"].id'><input type='text' name='wipeItemDetailList["+(detailLen-2)+"].wipeItem.iItem' style='width:95px' value='"+inputValue+"'>";
	day.innerHTML='<input type="text" name="wipeItemDetailList['+(detailLen-2)+'].itemDetailDate" style="width:90px">';
	money.innerHTML='<s:textfield theme="simple"  name="wipeItemDetailList['+(detailLen-2)+'].itemDetailMoney" style="width:80px" cssClass="required number"/>';
	brief.innerHTML='<input type="text" name="wipeItemDetailList['+(detailLen-2)+'].itemDetailBrief"  onclick="showDivBrief(this)">';
	remark.innerHTML='<input type="text" name="wipeItemDetailList['+(detailLen-2)+'].itemDetailRemark" onclick="showDiv(this)">';	
    del.innerHTML='<a onclick="javascript:deleteRow(this)">删除</a>';
}
</script>

<table width="650px;" cellpadding="0" cellspacing="1" class="form" id="detailList">
		<tr><td colspan="6" align="center">经费项目详细</td></tr>
		<tr>
		    <td>经费项目</td><td>日期</td><td>报销金额</td><td>摘要</td><td>备注</td><td>删除</td>
		   </tr>
		<s:iterator id="wipeItemDetailList" value="wipeItemDetailList" var="wipeItemDetail" status="sta">
		  <tr>
		       <td><s:hidden name="wipeItemDetailList[%{#sta.index}].id" value="%{#wipeItemDetail.id}"></s:hidden><s:textfield  theme="simple" name="wipeItemDetailList[%{#sta.index}].wipeItem.iItem" cssStyle="width:90px" value="%{#wipeItemDetail.wipeItem.iItem}" cssClass="required"></s:textfield></td>
		       <td><s:textfield theme="simple" name="wipeItemDetailList[%{#sta.index}].itemDetailDate" cssStyle="width:90px" theme="simple" value="%{#wipeItemDetail.itemDetailDate}"/></td>
		       <td><s:textfield theme="simple" name="wipeItemDetailList[%{#sta.index}].itemDetailMoney" cssStyle="width:80px" value="%{#wipeItemDetail.itemDetailMoney}" cssClass="required number"></s:textfield></td>
		        <td><s:textfield theme="simple" name="wipeItemDetailList[%{#sta.index}].itemDetailBrief" value="%{#wipeItemDetail.itemDetailBrief}" 
		        onclick="showDivBrief(this)"></s:textfield></td>
		       <td><s:textfield theme="simple" name="wipeItemDetailList[%{#sta.index}].itemDetailRemark" value="%{#wipeItemDetail.itemDetailRemark}" 
		       onclick="showDiv(this)"></s:textfield></td>
		       <td><a onclick="javascript:deleteRow(this)">删除</a></td>
		 </tr>
		</s:iterator>
</table>
<table width="650px;" cellpadding="0" cellspacing="1" class="form"><tr><td align="center"  >
 <input type="button" value="修改" id="updBtn"> <input type="button" value="返回" id="pre" onclick="window.history.go(-1);"></td>

 </tr></table>
</s:form>
<s:include value="/apps/pageFooter.jsp"/>
</body>
<script type="text/javascript">
function showDiv(obj){
	var index=obj.parentNode.parentNode.rowIndex;
	var inputValue=document.getElementById("detailList").getElementsByTagName("TR")[index].getElementsByTagName("INPUT")[5];
	
	var str=window.showModalDialog("apps/wipe/input.html",inputValue,'dialogHeight:270px;dialogWidth:270px;help:0;status:0;scroll:0;resizable:1');
	inputValue.value=str; 
}

function showDivBrief(obj){
	var index=obj.parentNode.parentNode.rowIndex;
	var inputValue=document.getElementById("detailList").getElementsByTagName("TR")[index].getElementsByTagName("INPUT")[4];
	var str=window.showModalDialog("apps/wipe/input.html",inputValue,'dialogHeight:270px;dialogWidth:270px;help:0;status:0;scroll:0;resizable:1');
	inputValue.value=str; 
}

$('input.UserSel').each(function(){
	$(this).css('background','url(<s:property value="imgRootUrl"/>users.png) no-repeat right');   
});

$(function(){
//批准
	$("#updBtn").click(function(){

		if($("#wipe_upd").valid()){
			$.messager.prompt('禀议码验证', '请输入禀议码!', function(val){
				if (val){
			 		$.post('<s:url action="ringi_checkCode" includeParams="none" namespace="/"/>', {"ringiShoCode":val} ,function(text){
			 			var obj = eval(text);
			 			if(obj.checked){
			 				$("#wipe_upd").submit();
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
			$('#sanjiId').attr("disabled",true);
			$('#sanjiName').attr("disabled",true);
			
			$('#sijiId').attr("disabled",true);
			$('#sijiName').attr("disabled",true);
			
			$('#wujiId').attr("disabled",true);
			$('#wujiName').attr("disabled",true);

		}else if(le == 1){
			$('#tr_3').show(); 
			
		    $('#sanjiId').attr("disabled",false);
			$('#sanjiName').attr("disabled",false);
			
			$('#sijiId').attr("disabled",false);
			$('#sijiName').attr("disabled",false);
			
			$('#wujiId').attr("disabled",false);
			$('#wujiName').attr("disabled",false);
		}
	}

});

$(function(){
	$("input.byCode").mask("aa-a-9999-999");
	$("input.byCode").blur(function(){
		$(this).val($(this).val().toUpperCase());
	});
    }
)
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