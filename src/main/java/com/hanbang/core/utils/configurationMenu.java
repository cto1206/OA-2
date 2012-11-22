package com.hanbang.core.utils;

/**
 *@author zpnin
 *登陆用户功能分配 
 */
public class configurationMenu {
	
	
	/**
	 *处理权限菜单
	 *@return
	 *@param
	 *@param 
	 */
	public static  int handleValidate(String constant,Object allConstant){
		int flag = 0 ;
		String cons[] = String.valueOf(allConstant).split(",") ;
		int n = cons.length ;
		for(int i=0;i<n;i++){
			if(cons[i].startsWith(constant)){
				flag = 1 ;
				break ;
			}
		}
		return flag ;
	}

}
