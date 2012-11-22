<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<jsp:include flush="true" page="constants.jsp"/>
<html>
<head>
<title>角色表单</title>
<link rel="stylesheet"
	href="<s:url value='/css/form.css' includeParams='none' encode='false' />"
	type="text/css" />
<s:head template="jquery" />	
<script type="text/javascript" src="/common/jslib/function.js"></script>
<script type="text/javascript">
	function submit_onclick(){
  		if (check()){
    		thisForm.submit() ;
  		}
	}
	
	function doReturn(){
 		 history.back();
	}
	
	function check(){
	  if (thisForm.roleName.value == ""){
	    alert("请填写角色名称！");
	    thisForm.roleName.focus();
	    return false;
	  }
	  thisForm.content.value=getRole();
	  return true;
	}
	
	function getRole(){
	  var allCHK = document.body.all.tags('INPUT');
	  var lstr = "" ;
	  for(i=0;i<allCHK.length;i++){
	    if(allCHK[i].type.toUpperCase()=="CHECKBOX" && allCHK[i].checked==true){
	       if (lstr==""){
	          lstr = allCHK[i].value;}
	       else {lstr= lstr + "," + allCHK[i].value;     }
	     }
	  }
	  return lstr ;
	}

	function getchk(ckName,bselect){
		  var allCHK = document.body.all.tags('INPUT');
		  var lstr = "" ;
		  for(i=0;i<allCHK.length;i++){
		     if(allCHK[i].type.toUpperCase()=="CHECKBOX" && allCHK[i].name=="box" && !(allCHK[i].value=="611")) {
		        allCHK[i].checked=bselect ;
		     }
		  }
		}
	
	function init(){
	 var allCHK = document.body.all.tags('INPUT');
	 var content = thisForm.content.value;
	 if(content != ""){
	   var strIds = content.split(",");
	   for(k=0;k<strIds.length;k++){
	     for(i=0;i<allCHK.length;i++){
	       if(allCHK[i].type.toUpperCase()=="CHECKBOX"  &&  allCHK[i].name=="box"  && allCHK[i].value==strIds[k]) {
	         allCHK[i].checked=true ;
	       }
	     }
	   }
	 }
	}

</script>
</head>
<body onload="init()">
<s:include value="/apps/pageHeader.jsp">
	<s:param name="fb_title">系统管理-角色表单</s:param>
</s:include>

<s:form name="thisForm" action="role_save" theme="simple">
	<!-- 处理重复提交信息 -->
	<s:hidden id = "content" name = "userRoles.content"/>
	<table width="440px" cellpadding="0" cellspacing="1" class="form">
		<thead>
			<tr>
				<td colspan="3">
					<s:if test="userRoles.roleId != null">修改角色信息</s:if>
					<s:else>添加角色信息</s:else>						
				</td>
				<s:hidden name="userRoles.roleId"/>
			</tr>
		</thead>	
		<tbody>
			<tr>
				<td align=right ><font color="#FF0000">*</font>角色名称：</td>
    			<td><s:textfield 	id="roleName" name="userRoles.roleName"  maxlength="15"  cssClass="inputStyle"/></td>
			</tr>
			<tr>
				<td align=right>&nbsp;角色描述：</td>
    			<td><s:textfield 	id="memo" name="userRoles.memo"  maxlength="50"  cssClass="inputStyle"/></td>
		
			</tr>
			<tr>
				<td align=right>&nbsp;功 能 组：</td>
				<td>权限设置&nbsp;&nbsp;
				<s:checkbox name="#" onclick="getchk(this.value,this.checked)" />全选</td>
			</tr>
			<tr>
				<td align=right>&nbsp;系统管理：</td>
				
				
				<td>
					<input name="box" type="checkbox" value="${SYSTEM_USER}" style="border: #000000">用户管理 
					<input name="box" type="checkbox" value="${SYSTEM_DEPT}" style="border: #000000">部门管理
					<input name="box" type="checkbox" value="${SYSTEM_ROLE}" style="border: #000000">角色管理</td>
			</tr>
			<tr>
				<td align=right>&nbsp;禀议管理：</td>
				<td>
					<input name="box" type="checkbox" value="${BY_CREATE}" style="border: #000000">禀议申请 
					<input name="box" type="checkbox" value="${BY_WAITING}" style="border: #000000">待批禀议
					<input name="box" type="checkbox" value="${BY_BACK}" style="border: #000000">驳回禀议
					<input name="box" type="checkbox" value="${BY_COMMENTS}" style="border: #000000">已批禀议<BR />
					<input name="box" type="checkbox" value="${BY_CONTROL}" style="border: #000000">禀议监控
					<input name="box" type="checkbox" value="${BY_LIB}" style="border: #000000">禀议资料库
				</td>
			</tr>

			<tr>
				<td align=right>&nbsp;报销管理：</td>
				<td>
					<input name="box" type="checkbox" value="${JF_CREATE }" style="border: #000000">报销申请 
					<input name="box" type="checkbox" value="${JF_WAITING }" style="border: #000000">待办报销
					<input name="box" type="checkbox" value="${JF_FINISHH }" style="border: #000000">已批报销
					<input name="box" type="checkbox" value="${JF_RETURN}" style="border: #000000">驳回报销<br/>
					<input name="box" type="checkbox" value="${JF_CONTROL}" style="border: #000000">报销监控
					<input name="box" type="checkbox" value="${JF_CMP}" style="border: #000000">完成报销
					<input name="box" type="checkbox" value="${JF_LIST}" style="border: #000000">报销资料库
				</td>
			</tr>

			<tr>
				<td align=right>&nbsp;其他管理：</td>
				<td>
					<input name="box" type="checkbox" value="${WORKFLOW_MANAGER }" style="border: #000000">流程管理
					<input name="box" type="checkbox" value="${WORKFLOW_MGR_PIC }" style="border: #000000">流程管理（图）
					<input name="box" type="checkbox" value="${MODIFY_BY}" style="border: #000000">修改禀议码
				</td>
			</tr>
			
		</tbody>
		<tfoot>
			<tr>
				<td></td>
				<td align=right>
				<input type=button  onclick="submit_onclick()"  value="保　存" >&nbsp;&nbsp;
				<input type=button  onclick="doReturn()"   value="取　消">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</tfoot>
	</table>
</s:form>

<s:include value="/apps/pageFooter.jsp"/>

</body>
</html>