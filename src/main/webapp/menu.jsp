<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<jsp:include flush="true" page="/apps/role/constants.jsp"/>
<html>
<head>
<title>港盛联合禀议系统</title>


<s:set name="curUserRoles" value="#session[@com.hanbang.platform.util.Constants@ROLECONTENT]" scope="session"/>
<script type="text/javascript" src="common/jslib/crossbrowser.js"></script>
<script type="text/javascript" src="common/jslib/outlook.js"></script>

<script type="text/javascript">
	function logout(){
  		if (confirm("确实要退出吗？")){
  			  parent.parent.window.navigate("login.jsp");
    	}
 	 }




		//create OutlookBar
	  var menuWidth = screenSize.width;
	  var menuHeight = screenSize.height;
	  //#0F6BA9
	  var o = new createOutlookBar('Bar',0,0,menuWidth, menuHeight,'#ffffff','#0F6BA9');
	  
	  var p ;
	  
	  //建立系统管理面板
	 
	  <s:if test="@com.hanbang.platform.util.configurationMenu@handleValidate('10',#session.curUserRoles) == 1">
	  p = new createPanel('userMgr','用户管理') ;
	  p.addButton('images/userMgr.gif','用户管理','parent.contentFrame.location="<s:url action="user_list" includeParams="none" namespace="/"/>"') ;
	  o.addPanel(p) ;
	  
	  p = new createPanel('deptMgr','部门管理') ;
	  p.addButton('images/dept.gif','部门管理','parent.contentFrame.location="<s:url value="/apps/dept/dept_main.jsp" includeParams="none"/>"') ;
	  o.addPanel(p) ;
	  
	  <s:if test="@com.hanbang.platform.util.configurationMenu@handleValidate(#SYSTEM_ROLE,#session.curUserRoles) == 1"> 
	  p = new createPanel('roleMgr','角色管理') ;
	  p.addButton('images/qx.gif','角色管理','parent.contentFrame.location="<s:url action="role_list" includeParams="none" namespace="/"/>"')
	  o.addPanel(p) ;
	  </s:if>
	  
	  </s:if>
	
	  <s:if test="@com.hanbang.platform.util.configurationMenu@handleValidate('20',#session.curUserRoles) == 1">
	  p = new createPanel('byMgr','禀议报告管理') ;
	  
	  <s:if test="@com.hanbang.platform.util.configurationMenu@handleValidate(#BY_WAITING,#session.curUserRoles) == 1">
	  p.addButton('images/by_bh.gif','待办禀议','parent.contentFrame.location="<s:url action="ringi_tasks" includeParams="none" namespace="/"/>"') ;
	  </s:if>
	  
	  <s:if test="@com.hanbang.platform.util.configurationMenu@handleValidate(#BY_CREATE,#session.curUserRoles) == 1">
	  p.addButton('images/by_sh.gif','禀议申请','parent.contentFrame.location="<s:url value="/apps/ringi/ringi_form.jsp" includeParams="none"/>"') ;
	  </s:if>
	  
	  <s:if test="@com.hanbang.platform.util.configurationMenu@handleValidate(#BY_COMMENTS,#session.curUserRoles) == 1">
	  p.addButton('images/by_tg.gif','已批禀议','parent.contentFrame.location="<s:url action="ringi_list" includeParams="none" namespace="/"/>"') ;
	  </s:if>
	  
	  <s:if test="@com.hanbang.platform.util.configurationMenu@handleValidate(#BY_CONTROL,#session.curUserRoles) == 1">
	  p.addButton('images/by_tg.gif','禀议监控','parent.contentFrame.location="<s:url action="ringi_list" includeParams="none" namespace="/"/>?state=0"') ;
	  </s:if>
	  
	  o.addPanel(p) ;
	  </s:if>
	  
	  <s:if test="@com.hanbang.platform.util.configurationMenu@handleValidate('30',#session.curUserRoles) == 1">
	  p = new createPanel('jfMgr','经费报销管理') ;
	  
	  <s:if test="@com.hanbang.platform.util.configurationMenu@handleValidate(#JF_CREATE,#session.curUserRoles) == 1">
	  p.addButton('images/by_bh.gif','报销申请','parent.contentFrame.location="<s:url value="/apps/wipe/wipe_main.jsp" includeParams="none"/>"') ;
	  </s:if>
	  
	  <s:if test="@com.hanbang.platform.util.configurationMenu@handleValidate(#JF_WAITING,#session.curUserRoles) == 1">
	  p.addButton('images/by_sh.gif','待办报销','parent.contentFrame.location="<s:url value="/apps/wipe/wipe_wei.jsp" includeParams="none"/>"') ;
	  </s:if>
	  
	  <s:if test="@com.hanbang.platform.util.configurationMenu@handleValidate(#JF_FINISHH,#session.curUserRoles) == 1">
	  p.addButton('images/by_tg.gif','已批报销','parent.contentFrame.location="<s:url value="/apps/wipe/wipe_yi.jsp" includeParams="none" />"') ;
	  </s:if>
	  o.addPanel(p) ;
	  </s:if>
	  
	  <s:if test="@com.hanbang.platform.util.configurationMenu@handleValidate('40',#session.curUserRoles) == 1">
	  p = new createPanel('workFlowMgr','流程管理');
	  p.addButton('images/modifyPws.gif','流程管理','parent.contentFrame.location="<s:url action="flow_list" includeParams="none" namespace="/"/>"') ;
	  p.addButton('images/exit.gif','流程管理（图片添加）','parent.contentFrame.location="<s:url value="/apps/wipe/wipe_flow_form.jsp" includeParams="none" />"') ; 
	  o.addPanel(p) ;
	  </s:if>
	  
	  
	  p = new createPanel('sysMgr','系统管理') ;
	  <s:if test="@com.hanbang.platform.util.configurationMenu@handleValidate(#MODIFY_BY,#session.curUserRoles) == 1">
	  p.addButton('images/modifyPws.gif','修改禀议码','parent.contentFrame.location="apps/sys/edit_bycode.jsp"') ;
	  </s:if>
	  p.addButton('images/modifyPws.gif','修改密码','parent.contentFrame.location="apps/sys/edit_password.jsp"') ;
	  p.addButton('images/exit.gif','退出系统','javascript:logout()') ; 
	  o.addPanel(p) ;
	  
	  o.draw() ;
	  
	  
	  function resize_op5() {
	  	//设置初始菜单
  		var defaultPanel = 0;
  		o.showPanel(defaultPanel);
  		if (bt.op5) {
   			o.showPanel(o.aktPanel);
    		var s = new createPageSize();
   			if ((screenSize.width!=s.width) || (screenSize.height!=s.height)) {
     			 screenSize=new createPageSize();
     			 setTimeout("o.resize(0,0,screenSize.width,screenSize.height)",100);
    			}
    		setTimeout("resize_op5()",100);
 		 }
	}
	
	function showp(pan){
 		 o.showPanel(pan);
	}
	
	
	function myOnResize() {
  		if (bt.ie4 || bt.ie5 || bt.ns5) {
    		var s=new createPageSize();
    		o.resize(0,0,s.width,s.height);
  		}
  		else if(bt.ns4) 
  		location.reload();
	}
	  
</script>
</head>
<body onload="myOnResize()">

</body>

</html>