<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<title>经费报销单</title>
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

<center>
<table style="width:700px;margin-top:2px;" cellpadding="1" cellspacing="0">
<tr><td align="center">
<table align="center"><tr>

<td align="left" style="vertical-align: middle">

<s:if test="wipe.title == 1">
<table border="0" cellpadding="0" cellspacing="0">
<tr><td style="text-align:center;"><img id="img_title" height="60" width="60" src="<s:property value="imgRootUrl"/>hb.png"></td></tr>
<tr><td style="text-align:center;" nowrap>汉邦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;钢构</td></tr>
</table>
</s:if>
<s:elseif test="wipe.title == 2">
<table border="0" cellpadding="0" cellspacing="0">
<tr><td style="text-align:center;"><img id="img_title" height="60" width="60" src="<s:property value="imgRootUrl"/>gs.png"></td></tr>
<tr><td style="text-align:center;" nowrap>港盛&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;涂装</td></tr> 
</table> 
</s:elseif>
<s:elseif test="wipe.title == 3">
<table border="0" cellpadding="0" cellspacing="0">
<tr><td style="text-align:center;"><img id="img_title" height="60" width="60" src="<s:property value="imgRootUrl"/>jl.png"></td></tr>
<tr><td style="text-align:center;" nowrap>建力&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;设备</td></tr> 
</table> 
</s:elseif>
<s:elseif test="wipe.title == 4">
<table border="0" cellpadding="0" cellspacing="0">
<tr><td style="text-align:center;"><img id="img_title" height="60" width="60" src="<s:property value="imgRootUrl"/>lh.png"></td></tr>
<tr><td style="text-align:center;" nowrap>港盛&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;联合</td></tr>
</table> 
</s:elseif> 
</td>


		<td style="text-align:center;vertical-align:top;width:100%;">
				<div style="border:1px black solid;width:300px;height:70px;text-decoration:underline;text-align:center;font-weight:bold;font-size:25pt;padding-top:15px;">经费报销单</div>
			</td>


<td align="right" style="vertical-align: bottom;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	保存年限___年</td>



</tr>
</table>

</td></tr>
<tr style="width: 700px;">
<td colspan="3">
<table style="width:100%;border:1px black solid;" cellpadding="0" cellspacing="0">
<tr style="height:35px;">
<td style="width:100px;text-align:center;border-right:1px black solid;">部　署</td>
<td style="width:100px;text-align:center;border-right:1px black solid;">起案</td>
<td style="width:100px;text-align:center;border-right:1px black solid;">一级审查</td>
<td style="width:100px;text-align:center;border-right:1px black solid;">二级决裁</td>
<td style="width:100px;text-align:center;border-right:1px black solid;">三级合议</td>
<td style="width:100px;text-align:center;border-right:1px black solid;">四级合议</td>
<td style="width:100px;text-align:center;">最终决裁</td>
</tr>
<tr style="height:35px;">
<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;">作&nbsp;&nbsp;成&nbsp;&nbsp;者</td>
<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;"><s:property value="wipe.wUser.rName"/>&nbsp;</td>
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
<s:if test="flowSigns['flowManFinance'] != null && flowSigns['flowManFinance'].RName != null">
<img src="<s:property value="uploadUrl"/><s:property value="flowSigns['flowManFinance'].RName"/>" style="width:100px;height:70px;">
</s:if>
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
<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;">电　话</td>
<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;"><s:property value="wipe.tel"/>&nbsp;</td>
</tr>
<tr style="height:35px;">
<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;">作成日期</td>
<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;"><s:date name="wipe.wApTime" format="yyyy-MM-dd"/>&nbsp;</td>
<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;">
<s:if test="wipe.judgeSet[0].judgeDate!= null"><s:property value="wipe.judgeSet[0].judgeDate"/></s:if><s:else>/</s:else>
</td>
<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;">
<s:if test="wipe.judgeSet[1].judgeDate!= null"><s:property value="wipe.judgeSet[1].judgeDate"/></s:if><s:else>/</s:else>
</td>
<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;">
<s:if test="wipe.judgeSet[2].judgeDate != null"><s:property value="wipe.judgeSet[2].judgeDate"/></s:if><s:else>/</s:else>

</td>
<td style="text-align:center;border-top:1px black solid;border-right:1px black solid;">
<s:if test="wipe.judgeSet[3].judgeDate!= null"><s:property value="wipe.judgeSet[3].judgeDate"/></s:if><s:else>/</s:else>
</td>
<td style="border-top:1px black solid;text-align:center;">
<s:if test="wipe.judgeSet[4].judgeDate != null"><s:property value="wipe.judgeSet[4].judgeDate"/></s:if><s:else>/</s:else>
</td>
</tr>
</table>
</td>
</tr>

<tr style="height:10px;"><td colspan="3">&nbsp;</td></tr>

<tr>
<td colspan="3"><span style="font-size:12pt;">一、经费总费用</span><span style="font-size:12pt;"><s:property value="wipe.wTotal"/></span>
</td>
</tr> 

<tr style="height:15px;"><td colspan="3">&nbsp;</td></tr>


<tr><td colspan="3"><span style="font-size:12pt;">二、经费项目</span></td></tr>
<tr>
<td>
<table width="700px" cellpadding="0" cellspacing="0" class="form" border="1">
<tr>
<td><span style="font-size:11pt;">经费报销编号</span></td><td><span style="font-size:11pt;">经费项目</span></td><td><span style="font-size:11pt;">经费总金额</span></td>
</tr>
<s:iterator id="wipeItemList" value="wipeItemList" var="wipeItem">
<tr>
<td><span style="font-size:11pt;"><s:property value="wipe.wCode"/></span></td>
<td><span style="font-size:11pt;"><s:property value="iItem"/></span></td>
<td><span style="font-size:11pt;"><s:property value="iMoney"/></span></td>
</tr>
</s:iterator>
</table>
</td></tr>


<tr style="height:15px;"><td colspan="3">&nbsp;</td></tr>

<tr><td colspan="5"><span style="font-size:12pt;">三、经费项目详细</span></td></tr>
<tr><td>

 
<table width="700px;" cellpadding="0" cellspacing="0" class="form" border="1">
<tr>
<td><span style="font-size:11pt;">经费项目</span></td>
<td><span style="font-size:11pt;"> 日 期</span></td>
<td><span style="font-size:11pt;">报销金额</span></td>
<td><span style="font-size:11pt;">摘要</span></td>
<td><span style="font-size:11pt;">备注</span></td>
</tr>
<s:iterator id="wipeItemDetailList" value="wipeItemDetailList" var="wipeItemDetail">
<tr>




<td><span style="font-size:11pt;"><s:property value="wipeItem.iItem"/></span></td>
<td>


<s:if test='#wipeItemDetail.itemDetailDate!=null&&#wipeItemDetail.itemDetailDate!=""'>
<span style="font-size:11pt;">
<s:property value="itemDetailDate"/>
</span></s:if>
<s:else>
无
</s:else>

</td>


<td><span style="font-size:11pt;"><s:property value="itemDetailMoney"/></span></td>

<td>
<s:if test='#wipeItemDetail.itemDetailBrief!=null&&#wipeItemDetail.itemDetailBrief!=""'>
<span style="font-size:11pt;">
<s:property value="itemDetailBrief"/>
</span></s:if>
<s:else>
无
</s:else>
</td>

<td>
<s:if test='#wipeItemDetail.itemDetailRemark!=null&&#wipeItemDetail.itemDetailRemark!=""'>
<span style="font-size:11pt;">
<s:property value="itemDetailRemark"/>
</span></s:if>
<s:else>
无
</s:else>
</td>

</tr>
</s:iterator>
</table>


</td>
</tr>

<tr style="height:15px;"><td colspan="3">&nbsp;</td></tr>


<s:if test='wipe.judgeSet!=null&&wipe.judgeSet!=""'>
<tr>
<td colspan="3"><span style="font-size:12pt;">指示事项</span>
<br>
<s:iterator value="wipe.judgeSet" id="stat" >
<s:if test='stat.jDirect!=null&&stat.jDirect!=""'>
<span style="font-size:11pt;">

<s:property value="user.rName"/> :<s:property value="stat.jDirect"/>
</span><br></s:if>

<s:else>

</s:else>


</s:iterator>
</td>
</tr>
</s:if>

<s:else>

</s:else>

<tr style="height:15px;"><td colspan="3">&nbsp;</td></tr>

<s:if test='wipe.wRemark!=null&&wipe.wRemark!=""'>
<tr>
<td colspan="3"><span style="font-size:12pt;">备注</span>
<br>
<s:property value="wipe.wRemark"/>
</td>
</tr> 
</s:if>
<s:else>

</s:else>

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
<input type="button" value="打印预览" onClick="Preview()"/>
<input type="button" value=" 打 印 " onClick="Print()"/>
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
//print.Print(); //弹出打印对话框(默认值)
print.Print(); //true 不出打印对话框直接打印
}

function PrintInit(){ //打印机初始化 
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
	print.marginTop = 10.16;   //页面上边距
    print.marginLeft = 10.16; //页面左边距
    print.marginRight = 10.16; //页面右边距
    print.marginBottom = 10.16; //页面底边距
//print.SetMarginMeasure(1); //设置单位 1:毫米(默认值) 2:英寸
//print.marginTop = 5; //页面上边距
//print.marginLeft = 5; //页面左边距
//print.marginRight = 5; //页面右边距
//print.marginBottom = 5; //页面底边距
print.header = "第 &p 页 / 共 &P 页"; //页面的页眉信息,设置值可以和下面IE的页眉页脚代码合并设置
//print.footer = "" ; //页面的页脚信息,设置值可以和下面IE的页眉页脚代码合并设置,如：“第 &p 页 / 共 &P 页”
//print.copies = 1; //打印份数
//print.selectedPages = false; //true：选择页打印 false：不选择页打印（默认值）
//pageFrom和pageTo的设置必须在selectedPages属性值为true时才能生效
//print.pageFrom = 2; //打印开始页数
//print.pageTo = 4; //打印结束页
//print.currentPage = true;//打印当前页,true:打印当前页；false:不打印当前页(默认值)
//当eprint.currentPage＝ true 和eprint.selectedPages = true时，则那个设置在最后则那个属性值有效。
//print.orientation = 1; //1:纵向，2:横向
print.paperSize = "A4"; //定制A4 纸打印 
//print.paperSource = "单张"; //纸张来源(设置值与打印机的纸张来源一致) 
//print.paperSize = "票据打印"; //用户自定义
//print.pageWidth = 6; //打印页面的宽
//print.pageHeight = 8; //打印页面的高
//print.zoomValue = "100";//打印预览时候的显示缩放比例(打开预览页面按100％的方式显示)
} 
</script>
</html>

