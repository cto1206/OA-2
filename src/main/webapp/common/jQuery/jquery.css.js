//**************************************************************//
		//																//
		//                       公共样式								//
		//																//
		//			注意：1、防止类重名									//
		//				  2、如果文本框中为数据类型,需要增加属性：		//
		//					 valueType="digital"。						//
		//                3、使用jquery验证框架的标签，请不要使用class  //
		//					 控制样式。									//
		//**************************************************************//

$(function(){      
		
	 	//class="even"
		//行样式：鼠标移入行，改变行背景
		$(".even").mouseover(function(){		 
			$(this).attr("class","highlight");
		}).mouseout(function(){
			$(this).attr("class","even"); 
		});   
		 
		$(":text").css("border","#8CB3E3 1px solid");
		//文本框获得焦点时高亮显示和失去焦点时还原默认样式
		//1、如果文本框为只读，则取消事件
		//2、如果文本框中内容为数字:class="digits" 或者 class="number"
		$(":text").focus(function(){  
			if($(this).attr("readOnly"))				
				return true;
			$(this).css("border","#ffcc33 1px solid");  
			if($(this).attr("class").indexOf("digits")!=-1){ 
				$(this).css("text-align","right");
			}else if($(this).attr("class").indexOf("number")!=-1){ 
				$(this).css("text-align","right");
			}else{ 
				$(this).css("text-align","left"); 
			}
			//失去焦点时调用方法
		}).blur(function(){  
			if($(this).attr("readOnly")) 
				return true; 
			$(this).css("border","#8CB3E3 1px solid"); 
			if($(this).attr("class").indexOf("digits")!=-1){ 
				$(this).css("text-align","right");
			}else if($(this).attr("class").indexOf("number")!=-1){ 
				$(this).css("text-align","right");
			}else{  
				$(this).css("text-align","left"); 
			}
		});  
		//只读文本框的样式 
		//如果只读文本框中内容为数字:class="digits" 或者 class="number"
		$(":text").each(function(){ 
			if($(this).attr("readOnly"))
			{   
				$(this).css("background","#cccccc");   
				$(this).css("border","0px");
				if($(this).attr("class").indexOf("digits")!=-1){ 
					$(this).css("text-align","right");
				}else if($(this).attr("class").indexOf("number")!=-1){
					$(this).css("text-align","right");
				}else{
					$(this).css("text-align","left");
				}
			} 
		}); 
		//多行文本框获得焦点时高亮显示和失去焦点时还原默认样式 
		$("textarea").focus(function(){  
			if($(this).attr("readOnly"))
				return;
			$(this).css("border","#ffcc33 1px solid");  
			 
		}).blur(function(){ 
			if($(this).attr("readOnly")) 
				return;   
			$(this).css("border","#8CB3E3 1px solid");  
		});
		$("textarea").each(function(){  
			if($(this).attr("readOnly")) {
				$(this).css("background","#cccccc");
				$(this).css("border","0");
			} else{
				$(this).css("border","#8CB3E3 1px solid");  
			}
		});
		//下拉选择框获得焦点时高亮显示和失去焦点时还原默认样式
		/*
		$("select").focus(function(){  
			$(this).css("border-color","#ff8811");    
			$(this).css("background","#eecc44");    
			$(this).css("border","1px");    
		}).blur(function(){ 
			$(this).css("border-color","#ffffff");    
			$(this).css("background","#ffffff");    
			$(this).css("border","1px");    
		});
		*/   
		  //返回按钮--后退
		$("#historyBack").click(function(){   
			history.back(-1); 
		}); 
		
		$("input.phone").mask("9999-99999999");
}); 