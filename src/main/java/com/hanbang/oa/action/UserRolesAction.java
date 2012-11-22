package com.hanbang.oa.action;

import javax.annotation.Resource;
import com.hanbang.core.action.CRUDActionSupport;
import com.hanbang.core.dao.support.Page;
import com.hanbang.oa.entity.security.UserRoles;
import com.hanbang.oa.service.UserRolesService;




/**
 * @author ZoopNin 权限
 */

public class UserRolesAction extends CRUDActionSupport<UserRoles>
{

	private static final long serialVersionUID = 1L;

	@Resource
	private UserRolesService userRolesService;

	private UserRoles userRoles;



	public String save() throws Exception
	{
		userRolesService.saveOrUpdate(userRoles);
		return RELOADVIEW;
	}


	public String delete() throws Exception
	{
		userRolesService.delete(super.getKey());
		return RELOADVIEW;
	}


	@Override
	public String get() throws Exception
	{
		// TODO Auto-generated method stub
		return null;

	}


	public String prepareForAdd() throws Exception
	{
		return FORMVIEW;
	}


	public String prepareForEdit() throws Exception
	{
		userRoles = userRolesService.get(super.getKey());
		return FORMVIEW;
	}


	protected void list(Page<UserRoles> page) throws Exception
	{
		userRolesService.pagedQuery(page);
	}


	public UserRoles getUserRoles()
	{
		return userRoles;
	}


	public void setUserRoles(UserRoles userRoles)
	{
		this.userRoles = userRoles;
	}

}
