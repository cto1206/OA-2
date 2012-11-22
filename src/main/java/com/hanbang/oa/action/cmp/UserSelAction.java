package com.hanbang.oa.action.cmp;

import java.util.List;
import javax.annotation.Resource;

import com.hanbang.core.action.BaseAction;
import com.hanbang.oa.entity.security.Dept;
import com.hanbang.oa.entity.security.User;
import com.hanbang.oa.service.DeptService;
import com.hanbang.oa.service.UserService;




/**
 * 
 * 人员选择组件
 * 
 * @author zmm
 * 
 */
public class UserSelAction extends BaseAction
{
	private static final long serialVersionUID = 1L;

	@Resource
	private DeptService deptService;

	@Resource
	private UserService userService;

	private List<Dept> deptList;

	private List<User> userList;



	public String depts()
	{

		deptList = deptService.findAll();
		return MAINVIEW;
	}


	public String users()
	{
		if (getKey() == null)
		{
			userList = userService.findAll();
		}
		else
		{
			userList = userService.findByProperty("dept.id", getKey());
		}
		return LISTVIEW;
	}


	public List<Dept> getDeptList()
	{
		return deptList;
	}


	public List<User> getUserList()
	{
		return userList;
	}

}
