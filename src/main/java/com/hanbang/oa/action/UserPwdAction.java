package com.hanbang.oa.action;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.struts2.interceptor.SessionAware;

import com.hanbang.core.action.BaseAction;
import com.hanbang.oa.entity.security.User;
import com.hanbang.oa.service.UserService;


public class UserPwdAction extends BaseAction implements SessionAware{
	private static final long serialVersionUID = 1L;
	private Map<String,Object> session ;
	
	private Long userId;
	
	private String oldPwd;
	
	private String newPwd;
	
	private String message;
	
	@Resource
	private UserService userManager;
	
	
	@Override
	public void setSession(Map<String, Object> session) {
		// TODO Auto-generated method stub
		
	}

	public Map<String, Object> getSession() {
		return session;
	}
	
	
	public String savepwd() throws Exception{
		Long userId = (Long)session.get("USERID") ;
		String oldpassword = "" ;
		User oneUser = userManager.get(userId) ;
		oldpassword = oneUser.getPwd() ;
		if(this.getOldPwd().equals(oldpassword)){
			this.addFieldError("savepwd.oldpwd", "<font color=red>旧密码有误！请重试！</font>") ;
		}else{
			oneUser.setPwd(this.getNewPwd()) ;
			userManager.save(oneUser) ;
			this.setMessage("您已成功修改了口令，请重新登录！") ;
		}
		return SUCCESS ;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getOldPwd() {
		return oldPwd;
	}

	public void setOldPwd(String oldPwd) {
		this.oldPwd = oldPwd;
	}

	public String getNewPwd() {
		return newPwd;
	}

	public void setNewPwd(String newPwd) {
		this.newPwd = newPwd;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
