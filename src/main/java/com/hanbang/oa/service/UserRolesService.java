package com.hanbang.oa.service;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.hanbang.core.service.EntityService;
import com.hanbang.oa.dao.UserRolesDao;
import com.hanbang.oa.entity.security.UserRoles;




/**
 * @author ZoopNin
 * 
 */
@Service
public class UserRolesService extends EntityService<UserRoles, Long>
{

	@Resource
	private UserRolesDao userRolesDao;



	@Override
	protected UserRolesDao getEntityDao()
	{
		return userRolesDao;
	}
}
