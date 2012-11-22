<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<title>人员选择</title>
	<link rel="stylesheet" href="<s:url value='/css/list.css' includeParams='none' encode='false' />" type="text/css"/>
	<link rel="stylesheet" href="<s:url value='/common/dtree/dtree.css' includeParams='none' encode='false' />" type="text/css"/>
	<script type="text/javascript" src="<s:url value='/common/dtree/dtree.js' includeParams='none' encode='false'/>"></script>	
	<style type="text/css">
	<!--
	DIV.TREE{WIDTH: 145; HEIGHT: 250; OVERFLOW: auto; scrollbar-face-color: #C1E5FB; scrollbar-shadow-color: #FFFFFF; scrollbar-highlight-color: #FFFFFF; scrollbar-3dlight-color: #C1E5FB; scrollbar-darkshadow-color: #C1E5FB; scrollbar-track-color: #FFFFFF; scrollbar-arrow-color: #FFFFFF}
	-->
	</style>	
</head>
<body>
<s:url id="imgRootUrl" value="/images/" includeParams="none" />
<s:url id="userUrl" action="userSel_users" includeParams="none" namespace="/"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="30"	background="<s:property value="imgRootUrl"/>tab_05.gif">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="12" height="30"><img	src="<s:property value="imgRootUrl"/>tab_03.gif" width="12" height="30" /></td>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="46%" valign="middle">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="5%">
								<div align="center"><img src="<s:property value="imgRootUrl"/>tb.gif" width="16" height="16" /></div>
								</td>
								<td width="95%">
									<span style="font-weight:bold;padding-left:3px;">请选择人员</span>：系统管理-用户列表
								</td>
							</tr>
						</table>
						</td>
						<td width="54%">
	
						</td>
					</tr>
				</table>
				</td>
				<td width="16"><img src="<s:property value="imgRootUrl"/>tab_07.gif" width="16" height="30" /></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table style="height:100%;width:100%;" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="8" background="<s:property value="imgRootUrl"/>tab_12.gif">&nbsp;</td>
				<td>
					<table>
						<tr>
							<td style="border-right:2px #D3D3D3 solid;">
								<div class="tree">
								<script type="text/javascript">
									d = new dTree('d');
									d.add(0,-1,'港盛联合');
							        <s:iterator value="deptList">
							        	d.add(<s:property value="id"/>,<s:property value="parent"/>,'<s:property value="name"/>','<s:url action="userSel_users" includeParams="none" namespace="/"><s:param name="key" value="id" /></s:url>','','','<s:property value="imgRootUrl"/>list_users.gif');
							        </s:iterator>
									d.config.target = 'deptContentFrame';
									document.write(d);
								</script>								
								</div>
							</td>
							<td style="width:100%;"><iframe name="deptContentFrame" src="<s:property value='userUrl'/>" frameborder="0" scrolling="yes" style="width:100%;height:100%;border:0px;"></iframe></td>
						</tr>
					</table>
				</td>
				<td width="8" background="<s:property value='imgRootUrl'/>tab_15.gif">&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="35"	background="<s:property value='imgRootUrl'/>tab_19.gif">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr style="vertical-align:top;">
				<td width="12" height="35"><img	src="<s:property value='imgRootUrl'/>tab_18.gif" width="12" height="35" /></td>
				<td style="text-align:center;padding-top:2px;"><input type="button" value="确定" onclick="sel()">&nbsp;&nbsp;<input type="button" value="关闭" onclick="window.close();"></td>
				<td width="16"><img src="<s:property value='imgRootUrl'/>tab_20.gif" width="16" height="35" /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>				
</body>
<script type="text/javascript">
function sel(){
	var u = document.frames['deptContentFrame'].getSelUser();
	if(u == undefined){
		window.alert("请选择一个人员!");
		return;
	}
	window.returnValue = u;
	window.close();
}
</script> 
</html>