<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<s:url id="imgRootUrl" value="/images/" includeParams="none" />
    <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		<tr>
			<td height="30"	background="<s:property value="imgRootUrl"/>tab_05.gif" valign="top" colspan="3">
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
										<span style="font-weight:bold;">你当前的位置</span>：
										<%
											if(request.getParameter("fb_title")!=null){
												out.println(request.getParameter("fb_title"));
											}
										%>
									</td>
								</tr>
							</table>
							</td>
							<td width="54%">
							<table border="0" align="right" cellpadding="0" cellspacing="0">
								<tr>
								<!-- 
									<td width="60">
									<table width="87%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td>
												<div align="center"><input type="checkbox" name="checkbox62" value="checkbox" /></div>
											</td>
											<td>
												<div align="center">全选</div>
											</td>
										</tr>
									</table>
									</td>
								 -->
								 	<%if(request.getParameter("fb_add")!=null){%>
									<td width="60">
									<table width="90%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td>
												<div align="center"><img src="<s:property value="imgRootUrl"/>22.gif" width="14" height="14" /></div>
											</td>
											<td>
												<div align="center">
													<a href="<%=request.getParameter("fb_add") %>">新增</a>
												</div>
											</td>
										</tr>
									</table>
									</td>
									<%}%>
									<%if(request.getParameter("fb_edit")!=null){%>						
									<td width="60">
									<table width="90%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td>
												<div align="center"><img src="<s:property value="imgRootUrl"/>33.gif" width="14" height="14" /></div>
											</td>
											<td>
												<div align="center">
													<a href="<%=request.getParameter("fb_edit") %>">修改</a>
												</div>
											</td>
										</tr>
									</table>
									</td>
									<%}%>											
									<%if(request.getParameter("fb_del")!=null){%>						
									<td width="52">
									<table width="88%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td>
											<div align="center"><img src="<s:property value="imgRootUrl"/>11.gif" width="14" height="14" /></div>
											</td>
											<td>
												<div align="center">
												<a href="<%=request.getParameter("fb_del") %>">删除</a>
												</div>
											</td>
										</tr>
									</table>
									</td>
									<%}%>																						
								</tr>
							</table>
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
			<td width="8"><img	src="<s:property value='imgRootUrl'/>tab_12.gif" width="8" height="100%" /></td>
            <td valign="top">
                <div id="content" style="height:100%;overflow:auto;scrollbar-face-color:#9EBFE8;scrollbar-shadow-color:#FFFFFF;scrollbar-highlight-color:#FFFFFF;scrollbar-3dlight-color:#9EBFE8;scrollbar-darkshadow-color:#9EBFE8;scrollbar-track-color:#FFFFFF;scrollbar-arrow-color:#FFFFFF">