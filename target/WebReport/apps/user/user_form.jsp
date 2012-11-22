<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<html>
<head>
	<title>用户表单</title>
	<link rel="stylesheet" href="<s:url value='/css/form.css' includeParams='none' encode='false' />" type="text/css"/>
	<s:head template="jquery" id="user_save"/>
	<script type="text/javascript" src="<s:url value='/common/jQuery/jquery.MultiFile.js' includeParams='none' encode='false'/>"></script>
</head>
<body>
	<s:include value="/apps/pageHeader.jsp">
		<s:param name="fb_title">系统管理-人员信息</s:param>
	</s:include>
		<s:actionerror/>
		<s:form action="user_save" namespace="/" theme="simple" method="post" enctype="multipart/form-data">
			<s:token/>
			<table width="400px;" cellpadding="0" cellspacing="1" class="form">
				<thead>
					<tr>
						<td colspan="3">
							<s:if test="user.id != null">修改人员信息</s:if>
							<s:else>添加人员信息</s:else>						
						</td>
						<s:hidden name="user.id"/>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width:80px;">登录账号</td>
						<td colspan="2" style="padding:0px;">
							<table cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<s:if test="user.id != null">
											<s:textfield name="user.name" theme="simple" cssClass="required" maxlength="20" disabled="true"/>
										</s:if>
										<s:else>
											<s:textfield name="user.name" theme="simple" cssClass="required" maxlength="20"/>
										</s:else>
									</td>
									<td>
										<img id="loadImg" src="<s:property value="imgRootUrl"/>onLoad.gif" style="display:none">
										<img id="successImg" src="<s:property value="imgRootUrl"/>onSuccess.gif" style="display:none">
										<img id="errorImg" src="<s:property value="imgRootUrl"/>onError.gif" style="display:none">
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr><td>真实姓名</td><td colspan="2"><s:textfield name="user.rName" theme="simple"  cssClass="required" maxlength="20"/></td></tr>
					<tr>
						<td>性　　别</td>
						<td colspan="2">
						    <s:select list="#{'1':'男','2':'女'}" name="user.sex" theme="simple"/>
						</td>
					</tr>
					<tr>
						<td>所属部门</td>
						<td>
							<s:select name="user.dept.id" list="deptList" listKey="id" listValue="name" theme="simple"/>  											
						</td>
						<td rowspan="3" style="width:110px;padding:0px;">
							<s:if test="uploaded != null">
								<img id="sign" src="<s:url value="/upload/" includeParams="none"/><s:property value="uploaded.RName"/>" style="width:110px;height:84px;">
							</s:if>
							<s:else>
								<img id="sign" src="<s:property value="imgRootUrl"/>hotno1.gif" style="width:110px;height:84px;">
							</s:else>
						</td>
					</tr>
					<tr>
						<td>所属角色</td>
						<td>
							<s:select name="user.role.roleId" list="roleList" listKey="roleId" listValue="roleName" theme="simple"/>
						</td>
					</tr>
					<tr><td>联系电话</td><td><s:textfield name="user.tel" theme="simple" cssClass="phone"/></td></tr>
					<tr>
						<td>出生日期</td>
						<td><s:date id="birthday" name="user.birthday" format="yyyy-MM-dd"/><s:textfield name="user.birthday" theme="simple" onfocus="WdatePicker({isShowClear:false})" cssClass="Wdate dateISO" value="%{birthday}"/></td>
						<td style="text-align:center;">
							<s:if test="uploaded != null">
								<span id="span_img">
									<s:property value="uploaded.name"/><img style="cursor:pointer" src="<s:property value="imgRootUrl"/>empty.gif" width="16" height="14" onclick="deleteFile(<s:property value="uploaded.id"/>,'<s:property value="uploaded.name"/>')"/>
								</span>
							</s:if>
						</td>
					</tr>
					<tr>
						<td>签　　名</td>
						<td colspan="2">
							<s:file name="upload" />
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr><td colspan="3"><s:submit value="保存" theme="simple"/>&nbsp;&nbsp;<s:reset value="重置" theme="simple"/></td></tr>
				</tfoot>
			</table>
		</s:form>
	<s:include value="/apps/pageFooter.jsp"/>
</body>
<script type="text/javascript">
$(function(){ 
	$("input[name='upload']").MultiFile({ 
		STRING: { 
			remove: '<img src="<s:property value="imgRootUrl"/>empty.gif" style="border:0px;" height="16" width="16" alt="x"/>',
			denied:'你不能选择以 $ext 扩展名结尾的文件.\n请重新选择！',
			duplicate:'这个文件已经存在:\n$file'
		},
		max: 1, 
		accept: 'png|gif|jpg'
	});
	<s:if test="uploaded != null">
		$("input[name='upload']").attr('disabled',true);
	</s:if>
	
	$("input[name='user.name']").blur(function(){
		if($(this).val() == '')
			return;
		$('#errorImg').hide();
		$('#loadImg').show();
		$('#successImg').hide();
		$(this).attr('disabled',true);
 		$.post('<s:url action="user_check" includeParams="none" namespace="/"/>', {"user.name":$(this).val()} ,function(has){
 			$("input[name='user.name']").attr('disabled',false);
 			if(has == 'false'){
	 			window.alert("当前账号已存在！");		
	 			$("input[name='user.name']").focus();
	 			$('#errorImg').show();
	 			$('#loadImg').hide();
	 			$('#successImg').hide();
 			}else{
	 			$('#errorImg').hide();
	 			$('#loadImg').hide();
	 			$('#successImg').show();
 			}
 		});				
	});
});

function deleteFile(id,name){
	if(window.confirm("确定删除【" + name + "】吗?")){
 		$.post('<s:url action="fileDown_deleteFile" includeParams="none" namespace="/"/>', {"key":id} ,function(isDel){
 			if(isDel != undefined){
	 			$("#span_img").remove();
				$("input[name='upload']").attr('disabled',false);
				$('#sign').attr('src','<s:property value="imgRootUrl"/>hotno1.gif');
 			}
 		});	
	}
}
</script>
</html>