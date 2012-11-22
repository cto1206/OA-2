package com.hanbang.core.utils;

import java.util.Map;

import org.apache.log4j.Logger;
import com.hanbang.oa.entity.security.User;
import com.opensymphony.xwork2.ActionContext;




/**
 * 用于辅助web层获取系统数据.
 */
public abstract class ActionUtil
{

	protected static Logger logger = Logger.getLogger(ActionUtil.class);



	/**
	 * 得到当前登录人的登录信息，包括登录人信息和登录信息 注意：要求在action中调用
	 * 
	 * @return
	 */
	public static User getCurLoginInfo()
	{
		return (User) getActionContext().getSession().get(Constants.LOGIN_INFO);
	}


	/**
	 * 验证当前会话是否有效（未失效） 注意：要求在action中调用
	 * 
	 * @return true:有效；false:已失效
	 */
	public static Boolean isValid()
	{

		if (getActionContext().getSession().get(Constants.LOGIN_INFO) != null)
			return true;
		return false;
	}


	/**
	 * 得到当前会话
	 * 
	 * @return
	 */
	public static Map<String, Object> getSession()
	{
		return getActionContext().getSession();
	}


	/**
	 * 到得ActionContext对象，在获取该对象时将进行检测，以确定是否处于action环境中
	 * 
	 * @return ActionContext
	 */
	private static ActionContext getActionContext()
	{
		return ActionContext.getContext();
	}

}
