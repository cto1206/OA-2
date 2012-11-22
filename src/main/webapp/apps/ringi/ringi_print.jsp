<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<title>禀议报告表单</title>
	<link rel="stylesheet" href="<s:url value='/css/form.css' includeParams='none' encode='false' />" type="text/css"/>
	<STYLE MEDIA="PRINT">    
		 .noprint{display:none;}
	</STYLE>
	<STYLE MEDIA="SCREEN">    
		.noprint {display:block;}
	</STYLE>
</head>
<body>
<div id="tip" style="position:absolute;left:1;width:100mm;border:1 solid red;">正在生成打印页面.. </div>
<s:url id="imgRootUrl" value="/images/" includeParams="none" />
<s:url id="uploadUrl" value="/upload/" includeParams="none" />
<s:url id="downUrl" action="fileDown_download" includeParams="none" namespace="/"/>
<center>
	<table style="width:700px;margin-top:50px;" cellpadding="1" cellspacing="0">
		<tr>
			<td style="text-align:center;vertical-align:top;border-bottom:1px black solid;">
				<s:if test="ringiSho.title == 1">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr><td style="text-align:center;"><img id="img_title" height="60" width="60" src="<s:property value="imgRootUrl"/>hb.png"></td></tr>
						<tr><td style="text-align:center;" nowrap>汉邦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;钢构</td></tr>
					</table>
				</s:if>
				<s:elseif test="ringiSho.title == 2">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr><td style="text-align:center;"><img id="img_title" height="60" width="60" src="<s:property value="imgRootUrl"/>gs.png"></td></tr>
						<tr><td style="text-align:center;" nowrap>港盛&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;涂装</td></tr>					
					</table>						
				</s:elseif>
				<s:elseif test="ringiSho.title == 3">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr><td style="text-align:center;"><img id="img_title" height="60" width="60" src="<s:property value="imgRootUrl"/>jl.png"></td></tr>
						<tr><td style="text-align:center;" nowrap>建力&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;设备</td></tr>					
					</table>						
				</s:elseif>
				<s:elseif test="ringiSho.title == 4">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr><td style="text-align:center;"><img id="img_title" height="60" width="60" src="<s:property value="imgRootUrl"/>lh.png"></td></tr>
						<tr><td style="text-align:center;" nowrap>港盛&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;联合</td></tr>
					</table>						
				</s:elseif>			
			</td>
			<td style="text-align:center;vertical-align:top;border-bottom:1px black solid;width:500px;">
				<div style="border:1px black solid;width:300px;height:70px;text-decoration:underline;text-align:center;font-weight:bold;font-size:25pt;padding-top:15px;">禀 议 书</div>
			</td>
			<td style="width:160px;border-bottom:1px black solid;">
				<table cellpadding="0" cellspacing="0" style="width:160px;">
					<tr style="height:35px;"><td colspan="4" style="text-align:center;">保存年限___年</td></tr>
					<tr style="height:35px;">
						<td colspan="4" style="font-style:italic;text-align:center;border:1px black solid;border-bottom:0px;">编号</td>
					</tr>
					<tr style="height:35px;">
						<td style="border:1px black solid;border-style:dotted;border-right:0px;border-left:1px black solid;border-bottom:0px;width:40px;text-align:center;"><s:property value="%{ringiSho.code.substring(0, 2)}"/></td>
						<td style="border:1px black solid;border-style:dotted;border-right:0px;border-bottom:0px;width:40px;text-align:center;"><s:property value="%{ringiSho.code.substring(3, 4)}" /></td>
						<td style="border:1px black solid;border-style:dotted;border-right:0px;border-bottom:0px;width:40px;text-align:center;"><s:property value="%{ringiSho.code.substring(5, 9)}" /></td>
						<td style="border:1px black solid;border-style:dotted;width:40px;border-right:1px black solid;border-bottom:0px;text-align:center;"><s:property value="%{ringiSho.code.substring(10, 13)}" /></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<table style="width:100%;border:1px black solid;" cellpadding="0" cellspacing="0">
					<tr style="height:35px;">
						<td style="width:100px;text-align:center;border-right:1px black solid;">部　　署</td>
						<td style="width:100px;text-align:center;border-right:1px black solid;">起案</td>
						<td style="width:100px;text-align:center;border-right:1px black solid;">一级审查</td>
						<td style="width:100px;text-align:center;border-right:1px black solid;">二级决裁</td>
						<td style="width:100px;text-align:center;border-right:1px black solid;">三级合议</td>
						<td style="width:100px;text-align:center;border-right:1px black solid;">四级合议</td>
						<td style="width:100px;text-align:center;">最终决裁</td>
					</tr>
					<tr style="height:35px;">
						<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;">作&nbsp;&nbsp;成&nbsp;&nbsp;者</td>
						<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;"><s:property value="ringiSho.user.rName"/>&nbsp;</td>
						<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;" rowspan="2">
							<s:if test="flowSigns['flowMan1'] != null && flowSigns['flowMan1'].RName != null">
								<img src="<s:property value="uploadUrl"/><s:property value="flowSigns['flowMan1'].RName"/>" style="width:100px;height:70px;">
							</s:if>
							<s:else>&nbsp;</s:else>
						</td>
						<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;" rowspan="2">
							<s:if test="flowSigns['flowMan2'] != null && flowSigns['flowMan2'].RName != null">
								<img src="<s:property value="uploadUrl"/><s:property value="flowSigns['flowMan2'].RName"/>" style="width:100px;height:70px;">
							</s:if>
							<s:else>&nbsp;</s:else>
						</td>
						<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;" rowspan="2">
							<s:if test="ringiSho.flag == 0">
								<s:if test="flowSigns['flowManStock'] != null && flowSigns['flowManStock'].RName != null">
									<img src="<s:property value="uploadUrl"/><s:property value="flowSigns['flowManStock'].RName"/>" style="width:100px;height:70px;">
								</s:if>
								<s:else>&nbsp;</s:else>						
							</s:if>
							<s:elseif test="ringiSho.flag == 1">
								<s:if test="flowSigns['flowManFinance'] != null && flowSigns['flowManFinance'].RName != null">
									<img src="<s:property value="uploadUrl"/><s:property value="flowSigns['flowManFinance'].RName"/>" style="width:100px;height:70px;">
								</s:if>
								<s:else>&nbsp;</s:else>							
							</s:elseif>
							<s:else>&nbsp;</s:else>
						</td>
						<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;" rowspan="2">
							<s:if test="flowSigns['flowMan4'] != null && flowSigns['flowMan4'].RName != null">
								<img src="<s:property value="uploadUrl"/><s:property value="flowSigns['flowMan4'].RName"/>" style="width:100px;height:70px;">
							</s:if>
							<s:else>&nbsp;</s:else>
						</td>
						<td style="border-top:1px black solid;text-align:center;" rowspan="2">
							<s:if test="flowSigns['presidentMan'] != null && flowSigns['presidentMan'].RName != null">
								<img src="<s:property value="uploadUrl"/><s:property value="flowSigns['presidentMan'].RName"/>" style="width:100px;height:70px;">
							</s:if>
							<s:else>&nbsp;</s:else>
						</td>
					</tr>
					<tr style="height:35px;">
						<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;">电　　话</td>
						<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;"><s:property value="ringiSho.tel"/>&nbsp;</td>
					</tr>
					<tr style="height:35px;">
						<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;">作成日期</td>
						<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;"><s:date name="ringiSho.date" format="yyyy-MM-dd"/>&nbsp;</td>
						<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;">
							<s:if test="ringiSho.flowDate1 != null"><s:date name="ringiSho.flowDate1" format="yyyy-MM-dd"/></s:if><s:else>/</s:else>
						</td>
						<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;">
							<s:if test="ringiSho.flowDate2 != null"><s:date name="ringiSho.flowDate2" format="yyyy-MM-dd"/></s:if><s:else>/</s:else>
						</td>
						<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;">
							<s:if test="ringiSho.flowDateStock != null"><s:date name="ringiSho.flowDateStock" format="yyyy-MM-dd"/></s:if>
							<s:elseif test="ringiSho.flowDateFinance != null"><s:date name="ringiSho.flowDateFinance" format="yyyy-MM-dd"/></s:elseif>
							<s:else>/</s:else>
						</td>
						<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;">
							<s:if test="ringiSho.flowDate4 != null"><s:date name="ringiSho.flowDate4" format="yyyy-MM-dd"/></s:if><s:else>/</s:else>
						</td>
						<td style="border-top:1px black solid;text-align:center;">
							<s:if test="ringiSho.presidentDate != null"><s:date name="ringiSho.presidentDate" format="yyyy-MM-dd"/></s:if><s:else>/</s:else>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr style="height:10px;"><td colspan="3">&nbsp;</td></tr>
		<tr>
			<td colspan="3"><span style="font-weight:bold;font-size:20pt;">主题:</span>&nbsp;&nbsp;&nbsp;<span style="font-weight:bold;font-size:18pt;"><s:property value="ringiSho.sub"/></span></td>
		</tr>
		<tr style="height:10px;"><td colspan="3">&nbsp;</td></tr>
		<tr>
			<td colspan="3"><span style="font-weight:bold;font-size:16pt;">一、原因目的</span>　　　　<span style="font-size:14pt;"><s:property value="ringiSho.cause" escape="false"/></span></td>
		</tr>
		<tr style="height:10px;"><td colspan="3">&nbsp;</td></tr>
		<tr>
			<td colspan="3"><span style="font-weight:bold;font-size:16pt;">二、详细内容</span>　　　　<span style="font-size:14pt;"><s:property value="ringiSho.synopsis" escape="false"/></span></td>
		</tr>
		<tr style="height:10px;"><td colspan="3">&nbsp;</td></tr>
		<tr>
			<td colspan="3"><span style="font-weight:bold;font-size:16pt;">三、需求日期</span>　　　　<span style="font-size:14pt;"><s:date name="ringiSho.needDate" format="yyyy年MM月dd日"/>之前</span></td>
		</tr>		
		<tr style="height:10px;"><td colspan="3">&nbsp;</td></tr>
		<tr>
			<td colspan="3"><span style="font-weight:bold;font-size:16pt;">☆、指示事项</span><br>
				<s:iterator value="ringiSho.ringiShoDetails" status="stat">
					<br>　　　　<span style="font-size:14pt;"><s:property value="#stat.count"/> 、<s:property value="content"/></span>
				</s:iterator>
			</td>
		</tr>
	</table>
	<div class="noprint">
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<s:if test="uploadeds != null">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<s:iterator value="uploadeds">
									<td><img src="<s:property value="imgRootUrl"/>word.gif" width="15" height="15"/></td>
									<td><s:a href="%{downUrl}?key=%{id}" cssStyle="text-decoration:none"><s:property value="name"/></s:a></td>
								</s:iterator>
							</tr>
						</table>
					</s:if>
				</td>
			</tr>
			<tr>
				<td>
					<object id="eprint" classid="clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441" codebase="<s:url value="/common/eprint/eprint.cab" includeParams="none"/>#Version=3,0,0,6" VIEWASTEXT></object>
					<input type="button" value="打印预览" onclick="Preview()"/>
					<input type="button" value=" 打  印 " onclick="Print()"/>
				</td>
			</tr>
		</table>
	</div>
</center>
</body>
<script language="javascript">
	var print = null;
	var paperTypes = {
		A4:{name:"A4",width:210,height:297},
		hrsoft:{name:"hrsoft",width:218,height:140}
	};

	function Preview(){
		if (print.defaultPrinterName.length==0){
			alert("请先安装打印机，再执行此功能！");
			return;
		}
		PrintInit();
		print.Preview();
	}

	function Print(){  
		if (print.defaultPrinterName.length==0){
			alert("请先安装打印机，再执行此功能！");
			return;
		}
		PrintInit();
		setParameters();
     //print.Print();  //弹出打印对话框(默认值)
		print.Print();  //true   不出打印对话框直接打印
	}
	
	function PrintInit(){  //打印机初始化
		print.InitPrint();
		print.companyName = "宁波汉邦钢结构有限公司";
		print.seriesNo = "7030-3805-0324-6726" ; 
		setParameters();
	}
	
	var printCall = null;
	window.onload = function(){	
		measurePxPerMM();
		print = document.all.eprint;
		setParameters();
	}

	function measurePxPerMM(){
		var px = document.getElementById("tip").offsetWidth;
		document.getElementById("tip").removeNode(true);
	}

	function setParameters(){
	    //print.SetMarginMeasure(1);  //设置单位  1:毫米(默认值) 2:英寸
	    print.marginTop = 10.16;   //页面上边距
	    print.marginLeft = 10.16; //页面左边距
	    print.marginRight = 10.16; //页面右边距
	    print.marginBottom = 10.16; //页面底边距
	    //print.header = "第 &p 页 / 共 &P 页";  //页面的页眉信息,设置值可以和下面IE的页眉页脚代码合并设置
	    //print.footer = "" ;  //页面的页脚信息,设置值可以和下面IE的页眉页脚代码合并设置,如：“第 &p 页 / 共 &P 页”
       //print.copies = 1; //打印份数
       //print.selectedPages = false; //true：选择页打印  false：不选择页打印（默认值）
                                      //pageFrom和pageTo的设置必须在selectedPages属性值为true时才能生效
       //print.pageFrom = 2;  //打印开始页数
       //print.pageTo = 4;     //打印结束页
       //print.currentPage = true;//打印当前页,true:打印当前页；false:不打印当前页(默认值)
                                  //当eprint.currentPage＝ true 和eprint.selectedPages = true时，则那个设置在最后则那个属性值有效。
       //print.orientation = 1;  //1:纵向，2:横向
       print.paperSize = "A4"; //定制A4 纸打印 
       //print.paperSource = "单张";   //纸张来源(设置值与打印机的纸张来源一致) 
       //print.paperSize = "票据打印"; //用户自定义
       //print.pageWidth = 6; //打印页面的宽
       //print.pageHeight = 8;  //打印页面的高
       //print.zoomValue = "100";//打印预览时候的显示缩放比例(打开预览页面按100％的方式显示)
	}		
</script>
</html>