package com.hanbang.oa.service;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.hanbang.core.service.EntityService;
import com.hanbang.oa.dao.UserDao;
import com.hanbang.oa.entity.security.User;




@Service
public class UserInfoService extends EntityService<User, Long>
{

	@Resource
	private UserDao userDao;



	@Override
	protected UserDao getEntityDao()
	{
		return userDao;
	}


	public User display(String name)
	{
		return userDao.findUserInfo(name);
	}

}
