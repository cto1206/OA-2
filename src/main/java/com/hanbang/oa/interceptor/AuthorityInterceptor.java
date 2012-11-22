package com.hanbang.oa.interceptor;

import java.util.Map;

import org.apache.struts2.ServletActionContext;

import com.hanbang.core.utils.Constants;
import com.hanbang.oa.entity.security.User;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class AuthorityInterceptor extends AbstractInterceptor {

	private static final long serialVersionUID = 1L;

	// 拦截Action处理的拦截方法
	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		// 取得请求相关的ActionContext实例
		ActionContext ctx = invocation.getInvocationContext();
		Map<String, Object> session = ctx.getSession();
		// 取出名为user的session属性
		User user = (User) session.get(Constants.LOGIN_INFO);

		if (user == null) {
			StringBuffer requestURL = ServletActionContext.getRequest().getRequestURL();
			if (requestURL.indexOf("/index_login.action") > 0) {
				return invocation.invoke();
			} else {
				ctx.put("tip", "您还没有登录，请登陆系统");
				return Action.LOGIN;
			}
		}
		return invocation.invoke();
	}

}
