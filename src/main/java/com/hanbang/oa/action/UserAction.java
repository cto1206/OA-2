package com.hanbang.oa.action;

import java.util.List;
import javax.annotation.Resource;
import com.hanbang.core.action.FileUploadAction;
import com.hanbang.core.dao.support.Page;
import com.hanbang.core.utils.Struts2Utils;
import com.hanbang.oa.entity.security.Dept;
import com.hanbang.oa.entity.security.Uploaded;
import com.hanbang.oa.entity.security.User;
import com.hanbang.oa.entity.security.UserRoles;
import com.hanbang.oa.service.DeptService;
import com.hanbang.oa.service.UploadedService;
import com.hanbang.oa.service.UserService;
import com.hanbang.oa.service.UserRolesService;




/**
 * 用户信息控制器
 * 
 * @author zmm
 * 
 */
public class UserAction extends FileUploadAction<User>
{

	private static final long serialVersionUID = 1L;

	private User user;

	private List<Dept> deptList;

	private List<UserRoles> roleList;

	private Uploaded uploaded;

	@Resource
	private UserService userService;

	@Resource
	private DeptService deptService;

	@Resource
	private UserRolesService userRolesService;

	@Resource
	private UploadedService uploadedService;



	@Override
	protected void list(Page<User> page) throws Exception
	{
		userService.pagedQuery(page);
	}


	@Override
	public String delete() throws Exception
	{
		userService.delete(getKey());
		return RELOADVIEW;
	}


	public String prepareForEdit() throws Exception
	{
		user = userService.get(super.getKey());
		deptList = deptService.findAll();
		roleList = userRolesService.findAll();
		List<Uploaded> lst = uploadedService.findBy(user.getId(), User.class.getSimpleName());
		if (lst != null && !lst.isEmpty())
			uploaded = lst.get(0);
		return FORMVIEW;
	}


	/**
	 * 检查用户名是否唯一
	 * 
	 * @return
	 * @throws Exception
	 */
	public String check() throws Exception
	{
		boolean has = userService.isLoginNameUnique(user.getName());
		return Struts2Utils.renderText(String.valueOf(has));
	}


	@Override
	public String save() throws Exception
	{
		if (user.getId() == null)
			user.setPwd("111111");
		userService.save(user, getUploadPath(), getUpload(), getUploadFileName());
		return RELOADVIEW;
	}


	public String prepareForAdd() throws Exception
	{

		deptList = deptService.findAll();
		roleList = userRolesService.findAll();
		return FORMVIEW;
	}


	public List<Dept> getDeptList()
	{
		return deptList;
	}


	public List<UserRoles> getRoleList()
	{
		return roleList;
	}


	public User getUser()
	{
		return user;
	}


	public void setUser(User user)
	{
		this.user = user;
	}


	public Uploaded getUploaded()
	{
		return uploaded;
	}


	public String getUserById() throws Exception
	{
		return userService.get(super.getKey()).getByPwd();
	}


	@Override
	public String get() throws Exception
	{

		return null;
	}

}
