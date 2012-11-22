package com.hanbang.core.action;

import com.opensymphony.xwork2.ActionSupport;




public class BaseAction extends ActionSupport
{
	private static final long serialVersionUID = 1L;

	// 主框架视图返回标识
	public static final String MAINVIEW = "mainView";

	// 表单视图返回标识
	public static final String FORMVIEW = "formView";

	// 列表视图返回标识
	public static final String LISTVIEW = "listView";

	// 重新载入列表视图返回标识
	public static final String RELOADVIEW = "reloadView";

	// 保存结束视图返回标识
	public static final String ENDVIEW = "endView";

	// 表单标题
	private String title;

	// 主键
	private Long key;



	public String getTitle()
	{
		return title;
	}


	public void setTitle(String title)
	{
		this.title = title;
	}


	public Long getKey()
	{
		return key;
	}


	public void setKey(Long key)
	{
		this.key = key;
	}

}
