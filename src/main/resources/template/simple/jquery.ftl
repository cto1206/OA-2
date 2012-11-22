<link rel="stylesheet" href="<@s.url value='/common/jQuery/css/common.css' includeParams='none' encode='false' />" type="text/css"/>
<script type="text/javascript" src="<@s.url value='/common/datePicker/WdatePicker.js' includeParams='none' encode='false'/>"></script>
<script type="text/javascript" src="<@s.url value='/common/jQuery/jquery-1.3.2.js' includeParams='none' encode='false'/>"></script>
<script type="text/javascript" src="<@s.url value='/common/jQuery/jquery.validate.js' includeParams='none' encode='false'/>"></script>
<script type="text/javascript" src="<@s.url value='/common/jQuery/messages_cn.js' includeParams='none' encode='false'/>"></script>
<script type="text/javascript" src="<@s.url value='/common/jQuery/string.js' includeParams='none' encode='false'/>"></script>
<script type="text/javascript" src="<@s.url value='/common/jQuery/jquery.maskedinput-1.2.2.js' includeParams='none' encode='false'/>"></script>
<script type="text/javascript" src="<@s.url value='/common/jQuery/jquery.css.js' includeParams='none' encode='false'/>"></script>
<#if parameters.id?if_exists != "">
<script type="text/javascript"> 
$(function(){
	$("#${parameters.id?html}").validate();
});
</script>
</#if>