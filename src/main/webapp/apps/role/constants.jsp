<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>


<!-- 
	系统管理 
	101 用户管理
	102 部门管理
	103 角色管理	
-->
<s:set name="SYSTEM_USER" value="101"/>
<s:set name="SYSTEM_DEPT" value="102"/>
<s:set name="SYSTEM_ROLE" value="103"/>

<!-- 
	禀议管理 
	201 禀议申请
	202 完成禀议
	203 待批禀议
	204 禀议监控
	205 禀议驳回
	206 已批禀议
	207禀议资料库
-->
<s:set name="BY_CREATE" value="201"/>
<s:set name="BY_COMMENTS" value="202"/>
<s:set name="BY_WAITING" value="203"/>
<s:set name="BY_CONTROL" value="204"/>
<s:set name="BY_BACK" value="205"/>
<s:set name="BY_LIB" value="206"/>
<s:set name="BY_ZLK" value="207"/>
<!-- 
	经费报销管理
	301 报销申请
	302 待办报销
	303 已批报销
	304 报销资料库
	305 驳回报销
	306 报销监控
	307 完成报销
 -->
<s:set name="JF_CREATE" value="301"/>
<s:set name="JF_WAITING" value="302"/>
<s:set name="JF_FINISHH" value="303"/>
<s:set name="JF_LIST" value="304"/>
<s:set name="JF_RETURN" value="305"/>
<s:set name="JF_CONTROL" value="306"/>
<s:set name="JF_CMP" value="307"/>

<!-- 
	其他管理
	401 流程管理
	402 流程管理（图）
	403 修改禀议码
 -->
<s:set name="WORKFLOW_MANAGER" value="401"/>
<s:set name="WORKFLOW_MGR_PIC" value="402"/>
<s:set name="MODIFY_BY" value="403"/>
