package com.hanbang.core.utils;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.ServletActionContext;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;




/**
 * 此类描述的是：Action辅助类，用于Ajax返回值
 * 
 * @author: 张敏明
 * @version: 2009-12-24 下午04:45:25
 */

public class Struts2Utils
{
	private static Logger logger = LoggerFactory.getLogger(Struts2Utils.class);



	protected static String render(String contentType, String content)
	{
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(contentType);
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter pw = null;
		try
		{
			pw = response.getWriter();
			pw.write(content);
		}
		catch (IOException e)
		{
			logger.error(e.getMessage(), e);
		}
		finally
		{
			pw.close();
		}

		return null;
	}


	public static String renderText(String text)
	{
		return render("text/plain", text);
	}


	public static String renderHtml(String html)
	{
		return render("text/html", html);
	}


	public static String renderXml(String xml)
	{
		return render("text/xml", xml);
	}


	public static String renderJson(String string)
	{
		return render("application/json", string);
	}


	public static String renderJson(Map<Object, Object> map)
	{
		String jsonString = new JSONObject(map).toString();
		return renderJson(jsonString);
	}


	public static String renderJson(Object object)
	{
		String jsonString = new JSONObject(object).toString();
		return renderJson(jsonString);
	}
}
