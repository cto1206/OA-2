package com.hanbang.core.utils;

import java.text.SimpleDateFormat;
import java.util.Date;




/**
 * Java生成日期唯一码
 * 
 * @author zmm
 * 
 */
public class IdentityCode
{

	/**
	 * getPK,获得数据库使用的一个long型唯一主键 16位，同一微秒内3000个不会重复
	 */
	private static long[] ls = new long[3000];
	private static int li = 0;



	public synchronized static long getPK()
	{
		long lo = getpk();
		for (int i = 0; i < 3000; i++)
		{
			long lt = ls[i];
			if (lt == lo)
			{
				lo = getPK();
				break;
			}
		}
		ls[li] = lo;
		li++;
		if (li == 3000)
		{
			li = 0;
		}
		return lo;
	}


	private synchronized static long getpk()
	{
		String a = (String.valueOf(System.currentTimeMillis())).substring(3, 13);
		String d = (String.valueOf(Math.random())).substring(2, 8);
		return Long.parseLong(a + d);
	}


	public synchronized static long getWorkNumber()
	{

		String a = (String.valueOf(System.currentTimeMillis())).substring(5, 13);
		String d = (String.valueOf(Math.random())).substring(5, 8);
		String a1 = (new SimpleDateFormat("yyyyMMdd").format(new Date()));
		return Long.parseLong(a1 + a + d);
	}
}
