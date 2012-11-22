<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<jsp:include flush="true" page="/apps/role/constants.jsp"/>
<html>
<head>
<title>港盛联合禀议系统</title>
<s:set name="curUserRoles" value="#session[@com.hanbang.core.utils.Constants@ROLECONTENT]" scope="session"/>
<link rel="stylesheet" href="<s:url value='/common/dtree/dtree.css' includeParams='none' encode='false' />" type="text/css"/>
<script type="text/javascript" src="<s:url value='/common/dtree/dtree.js' includeParams='none' encode='false'/>"></script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>

</head>

<body>
<table width="171" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top"><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0"  style="table-layout:fixed;">
      <tr>
        <td style="width:3px; background:#0a5c8e;">&nbsp;</td>
        <td><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" style="table-layout:fixed;">
          <tr>
            <td height="5" style="line-height:5px; background:#0a5c8e;">&nbsp;</td>
          </tr>
          <tr>
            <td height="23" background="images/main_29.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="40%">&nbsp;</td>
                <td width="42%"><font style="height:1;font-size:9pt; color:#bfdbeb;filter:glow(color=#1070a3,strength=1)">系统管理</font></td>
                <td width="18%">&nbsp;</td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td bgcolor="#e5f4fd"><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td valign="top">            
                	<div style="margin-left:20px;margin-top:5px;">
                		<script type="text/javascript">
                		
							<!--
					
							d = new dTree('d');
					
							d.add(0,-1,'系统功能菜单');
							<s:if test="@com.hanbang.core.utils.configurationMenu@handleValidate('10',#session.curUserRoles) == 1">
								d.add(1,0,'用户管理','<s:url action="user_list" includeParams="none" namespace="/"/>');
								d.add(2,0,'部门管理','<s:url value="/apps/dept/dept_main.jsp" includeParams="none"/>');
								<s:if test="@com.hanbang.core.utils.configurationMenu@handleValidate(#SYSTEM_ROLE,#session.curUserRoles) == 1">
									d.add(3,0,'角色管理','<s:url action="role_list" includeParams="none" namespace="/"/>');
								</s:if>
							</s:if>
							
							<s:if test="@com.hanbang.core.utils.configurationMenu@handleValidate('20',#session.curUserRoles) == 1">
								d.add(4,0,'禀议报告管理');
								<s:if test="@com.hanbang.core.utils.configurationMenu@handleValidate(#BY_WAITING,#session.curUserRoles) == 1">
									d.add(40,4,'待办禀议','<s:url action="ringi_pendingTasks" includeParams="none" namespace="/"/>');
								</s:if>
								
								<s:if test="@com.hanbang.core.utils.configurationMenu@handleValidate(#BY_BACK,#session.curUserRoles) == 1">
								d.add(41,4,'驳回禀议','<s:url action="ringi_rejectTasks" includeParams="none" namespace="/"/>');
								</s:if>
								<s:if test="@com.hanbang.core.utils.configurationMenu@handleValidate(#BY_CREATE,#session.curUserRoles) == 1">
									d.add(42,4,'禀议申请','<s:url action="ringi_view" includeParams="none" namespace="/"/>');
								</s:if>
								<s:if test="@com.hanbang.core.utils.configurationMenu@handleValidate(#BY_COMMENTS,#session.curUserRoles) == 1">
									d.add(43,4,'已批禀议','<s:url action="ringi_list" includeParams="none" namespace="/"/>?state=1');
								</s:if>
								<s:if test="@com.hanbang.core.utils.configurationMenu@handleValidate(#BY_CONTROL,#session.curUserRoles) == 1">
									d.add(44,4,'禀议监控','<s:url action="ringi_list" includeParams="none" namespace="/"/>?state=0');
								</s:if>
								<s:if test="@com.hanbang.core.utils.configurationMenu@handleValidate(#BY_LIB,#session.curUserRoles) == 1">
								d.add(45,4,'禀议资料库','<s:url action="ringiMe_list" includeParams="none" namespace="/"/>?state=0');
								</s:if>
								d.add(46,4,'接收禀议');
							    d.add(47,46,'待阅接收禀议','<s:url action="report_list" includeParams="none" namespace="/"/>?state=0');
				                d.add(48,46,'已阅接收禀议','<s:url action="report_list" includeParams="none" namespace="/"/>?state=1');								
							</s:if>
							
							
							<s:if test="@com.hanbang.core.utils.configurationMenu@handleValidate('30',#session.curUserRoles) == 1">
								d.add(5,0,'经费报销管理');
								<s:if test="@com.hanbang.core.utils.configurationMenu@handleValidate(#JF_CREATE,#session.curUserRoles) == 1">
									d.add(50,5,'报销申请','<s:url action="wipe_prepareForAdd" includeParams="none" namespace="/"/>');
								</s:if>
								<s:if test="@com.hanbang.core.utils.configurationMenu@handleValidate(#JF_WAITING,#session.curUserRoles) == 1">
									d.add(51,5,'待办报销','<s:url action="wipe_weiShenPiList" includeParams="none" namespace="/"/>');
								</s:if>
								
								<s:if test="@com.hanbang.core.utils.configurationMenu@handleValidate(#JF_RETURN,#session.curUserRoles) == 1">
									d.add(54,5,'驳回报销','<s:url action="wipe_rejectTasks" includeParams="none" namespace="/"/>');
								</s:if>
								
								<s:if test="@com.hanbang.core.utils.configurationMenu@handleValidate(#JF_CONTROL,#session.curUserRoles) == 1">
									d.add(55,5,'报销监控','<s:url action="wipe_list" includeParams="none" namespace="/"/>?state=0');
								</s:if>
								
								<s:if test="@com.hanbang.core.utils.configurationMenu@handleValidate(#JF_FINISHH,#session.curUserRoles) == 1">
									d.add(52,5,'已批报销','<s:url action="wipe_yiShenPiList" includeParams="none" namespace="/"/>');
								</s:if>
								<s:if test="@com.hanbang.core.utils.configurationMenu@handleValidate(#JF_CMP,#session.curUserRoles) == 1">
									d.add(53,5,'完成报销','<s:url action="wipe_list" includeParams="none" namespace="/"/>?state=1');
								</s:if>
								
								<s:if test="@com.hanbang.core.utils.configurationMenu@handleValidate(#JF_LIST,#session.curUserRoles) == 1">
									d.add(56,5,'报销资料库','<s:url action="wipe_list" includeParams="none" namespace="/"/>?state=1&&compelete=compelete');
								</s:if>
								
								
								d.add(57,5,'接收报销');
								    d.add(2,57,'待阅接收','<s:url action="wipe_receiveWipe" includeParams="none" namespace="/"/>?state=0');
					                d.add(1,57,'已阅接收','<s:url action="wipe_receiveWipe" includeParams="none" namespace="/"/>?state=1');
					                d.add(3,57,'回收站','<s:url action="wipe_receiveWipe" includeParams="none" namespace="/"/>?state=2');
					                	
							</s:if>
							
							<s:if test="@com.hanbang.core.utils.configurationMenu@handleValidate(#WORKFLOW_MANAGER,#session.curUserRoles) == 1">
								d.add(6,0,'流程管理','<s:url action="flow_list" includeParams="none" namespace="/"/>');
							</s:if>
							<s:if test="@com.hanbang.core.utils.configurationMenu@handleValidate(#WORKFLOW_MGR_PIC,#session.curUserRoles) == 1">
								d.add(7,0,'流程管理(图片添加)','<s:url value="/apps/wipe/wipe_flow_form.jsp" includeParams="none" />');
							</s:if>
							
							d.add(8,0,'系统管理');
							<s:if test="@com.hanbang.core.utils.configurationMenu@handleValidate(#MODIFY_BY,#session.curUserRoles) == 1">
								d.add(80,8,'修改禀议码','<s:url value="/apps/sys/edit_bycode.jsp" includeParams="none" />');
							</s:if>
							d.add(81,8,'修改密码','<s:url value="/apps/sys/edit_password.jsp" includeParams="none" />');					
							d.config.target = 'contentFrame';
							document.write(d);
					
							//-->			                		            		
                		</script><!--  <s:url value="/apps/TabPanel/demo.html" includeParams="none" />-->
                		<!-- 
                		<img src="images/tree.gif" width="117" height="189">
                		 -->
                	</div>
                </td>
              </tr>
              <tr>
                <td height="50"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td height="25" background="images/main_43.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="37%">&nbsp;</td>
                        <td width="45%"><font style="height:1;font-size:9pt; color:#bfdbeb;filter:glow(color=#1070a3,strength=1)">方法浏览</font></td>
                        <td width="18%">&nbsp;</td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="25" background="images/main_43.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="37%">&nbsp;</td>
                        <td width="45%"><font style="height:1;font-size:9pt; color:#bfdbeb;filter:glow(color=#1070a3,strength=1)">其他菜单</font></td>
                        <td width="18%">&nbsp;</td>
                      </tr>
                    </table></td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr> 
            <td height="23" background="images/main_45.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="18%">&nbsp;</td>
                <td width="64%"><div align="center"><font style="height:1;font-size:9pt; color:#bfdbeb;filter:glow(color=#1070a3,strength=1)">版本2010 V1.0 </font></div></td>
                <td width="18%">&nbsp;</td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td height="9" style="line-height:9px; background:#0a5c8e;">&nbsp;</td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>