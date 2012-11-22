package com.hanbang.oa.action;

import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;
import com.hanbang.core.utils.Constants;
import com.hanbang.core.utils.MD5;
import com.hanbang.core.utils.StringUtils;
import com.hanbang.core.utils.Struts2Utils;
import com.hanbang.oa.entity.security.User;
import com.hanbang.oa.service.UserService;
import com.opensymphony.xwork2.ActionSupport;




public class IndexAction extends ActionSupport implements SessionAware
{

	private static final long serialVersionUID = 1L;

	@Resource
	private UserService userManager;

	private String userName;

	private String userPwd;

	private Map<String, Object> session;

	private String uId;

	private String oldPwd;

	private String newPwd;

	private String message;

	private String newBy;



	/**
	 * 
	 */
	public String login()
	{
		if (userName == null || userName.trim().length() == 0 || userPwd == null || userPwd.trim().length() == 0)
			return LOGIN;
		if (!("111111".equals(userPwd)))
		{
			userPwd = StringUtils.getEncodedPassword(userPwd);
		}
		User user = userManager.findLogin(userName, userPwd);

		if (user == null)
			return LOGIN;
		session.put(Constants.LOGIN_INFO, user);
		session.put("userid", user.getId());
		session.put(Constants.ROLECONTENT, user.getRole().getContent());
		Cookie cookieUsername = new Cookie("xabpoUsername", user.getName());
		cookieUsername.setMaxAge(60 * 60 * 24);
		ServletActionContext.getResponse().addCookie(cookieUsername);
		return SUCCESS;
	}


	/**
	 * 从session中删除当前用户
	 */
	public String unload()
	{
		if (session.containsKey(Constants.LOGIN_INFO))
		{
			session.remove(Constants.LOGIN_INFO);
			session.clear();
		}
		return Struts2Utils.renderText(String.valueOf(session.containsKey(Constants.LOGIN_INFO)));
	}


	/**
	 * 修改密码
	 * 
	 * @param
	 */
	public String savepwd() throws Exception
	{
		Long id = (Long) session.get("userid");
		User oneUser = userManager.get(id);
		
		System.out.println("pwd===="+oneUser.getPwd()+"oldpwd==="+this.getOldPwd());
		if(!this.oldPwd.equals(oneUser.getPwd())){
			//this.addActionError("旧密码不正确");
			this.addFieldError("newPwd", "旧密码不正确");
			return INPUT;
		}
		
		if ("111111".equals(this.getNewPwd()))
		{
			this.addFieldError("newPwd", "不能再次把初始化密码设置为现在的密码");
			return INPUT;
		}
		// 修改加密
		oneUser.setPwd(StringUtils.getEncodedPassword(this.getNewPwd()));
		userManager.save(oneUser);
		session.clear();
		return "succ";
	}


	/**
	 * 修改禀议论码
	 * 
	 * @param
	 */
	public String saveBy() throws Exception
	{
		Long id = (Long) session.get("userid");
		User bUser = userManager.get(id);
		bUser.setByPwd(this.getNewBy());
		userManager.save(bUser);
		session.clear();
		return "succ1";
	}


	public void setUserName(String userName)
	{
		this.userName = userName;
	}


	public void setUserPwd(String userPwd)
	{
		this.userPwd = userPwd;
	}


	@Override
	public void setSession(Map<String, Object> session)
	{
		// TODO Auto-generated method stub
		this.session = session;

	}


	public Map<String, Object> getSession()
	{
		return session;
	}


	public String getUId()
	{
		return uId;
	}


	public void setUserId(String uId)
	{
		this.uId = uId;
	}


	public String getOldPwd()
	{
		return oldPwd;
	}


	public void setOldPwd(String oldPwd)
	{
		this.oldPwd = oldPwd;
	}


	public String getNewPwd()
	{
		return newPwd;
	}


	public void setNewPwd(String newPwd)
	{
		this.newPwd = newPwd;
	}


	public String getMessage()
	{
		return message;
	}


	public void setMessage(String message)
	{
		this.message = message;
	}


	public String getNewBy()
	{
		return newBy;
	}


	public void setNewBy(String newBy)
	{
		this.newBy = newBy;
	}

}
