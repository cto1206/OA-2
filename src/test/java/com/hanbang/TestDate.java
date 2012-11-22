package com.hanbang;

import java.util.Date;




public class TestDate
{

	/**
	 * 此方法描述的是：
	 * 
	 * @author: wangxiongdx@163.com
	 * @version: 2010-1-6 上午10:17:36
	 */

	public static void main(String[] args)
	{
		/** 输出格式: 20060101000000** */
		java.text.DateFormat format2 = new java.text.SimpleDateFormat("yyMM");
		String s = format2.format(new Date());
		System.out.println(s);

		String pattern = "000";
		java.text.DecimalFormat df = new java.text.DecimalFormat(pattern);
		int i = 10, j = 6;
		System.out.println("i=" + df.format(i) + "\nj=" + df.format(j));
	}

}
