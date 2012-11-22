package com.hanbang.core.utils;




/**
 * @author zpnin
 * 
 */
public class StringUtils
{

   
	/**
	 * 使用MD5算法进行加密
	 * @param sourcePassword 待加密的明文密码
	 * @return 返回加密后的字符串。32位。
	 */
	public static String getEncodedPassword(String sourcePassword) {
		String unionPassword = "";
		if (sourcePassword != null)
			unionPassword = new String(sourcePassword);
		MD5 md = new MD5();
		md.Update(unionPassword);
		return md.asHex();
	}
}