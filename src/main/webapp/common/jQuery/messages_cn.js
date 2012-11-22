/*
 * Translated default messages for the jQuery validation plugin.
 * Language: CN
 * Author: Fayland Lam <fayland at gmail dot com>
 */
jQuery.extend(jQuery.validator.messages, {
		required:'<br><img src="common/jQuery/images/Alert.png" height="16" width="16"/><font color="red">该项必须填写.</font>',
		remote: '<br><img src="common/jQuery/images/Alert.png" height="16" width="16"/><font color="red">请检查输入.</font>',
		email:'<br><img src="common/jQuery/images/Alert.png" height="16" width="16"/><font color="red">请输入有效的邮箱地址.</font>',
		url: '<br><img src="common/jQuery/images/Alert.png" height="16" width="16"/><font color="red">请输入有效的网址.</font>',
		date:'<br><img src="common/jQuery/images/Alert.png" height="16" width="16"/><font color="red">请输入正确的日期.</font>',
		dateISO: '<br><img src="common/jQuery/images/Alert.png" height="16" width="16"/><font color="red">请输入正确的日期(ISO).</font>',
		dateDE: '<br><img src="common/jQuery/images/Alert.png" height="16" width="16"/><font color="red">请输入意大利日期.</font>',
		number: '<br><img src="common/jQuery/images/Alert.png" height="16" width="16"/><font color="red">请输入数字.</font>',
		numberDE: '<br><img src="common/jQuery/images/Alert.png" height="16" width="16"/><font color="red">请输入意大利数字.</font>',
		digits: '<br><img src="common/jQuery/images/Alert.png" height="16" width="16"/><font color="red">只能输入正整数.</font>',
		creditcard:'<br><img src="common/jQuery/images/Alert.png" height="16" width="16"/><font color="red">请输入正确的银行帐号.</font>',
		equalTo: '<br><img src="common/jQuery/images/Alert.png" height="16" width="16"/><font color="red">两次输入的不一致.</font>',
		accept: '<br><img src="common/jQuery/images/Alert.png" height="16" width="16"/><font color="red">请输入正确的内容.</font>',
		maxlength: $.format('<br><img src="common/jQuery/images/Alert.png" height="16" width="16"/><font color="red">长度不能大于{0}.</font>'),
		minlength: $.format('<br><img src="common/jQuery/images/Alert.png" height="16" width="16"/><font color="red">长度不能小于{0}.</font>'),
		rangelength: $.format('<br><img src="common/jQuery/images/Alert.png" height="16" width="16"/><font color="red">输入的长度应在{0}和{1}之间.</font>'),
		range: $.format('<br><img src="common/jQuery/images/Alert.png" height="16" width="16"/><font color="red">输入的值应该大于{0},小于{1}.</font>'),
		max: $.format('<br><img src="common/jQuery/images/Alert.png" height="16" width="16"/><font color="red">输入的值应该小于{0}.</font>'),
		min: $.format('<br><img src="common/jQuery/images/Alert.png" height="16" width="16"/><font color="red">输入的值应该大于{0}.</font>')
});