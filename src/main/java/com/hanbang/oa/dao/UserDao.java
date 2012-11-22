package com.hanbang.oa.dao;

import org.springframework.stereotype.Repository;
import com.hanbang.core.dao.HibernateEntityDao;
import com.hanbang.oa.entity.security.User;




/**
 * 此类描述的是：用户信息数据服务
 * 
 * @author: 张敏明
 * @version: 2010-1-4 下午08:02:31
 */

@Repository
public class UserDao extends HibernateEntityDao<User, Long>
{

	/**
	 * 查询登录用户
	 * 
	 * @param name
	 * @param pwd
	 * @return
	 */
	public User findLogin(String name, String pwd)
	{
		return (User) findUnique("from User where name = ? and pwd = ?", new Object[] { name, pwd });
	}


	/**
	 * 根据账号查询用户信息
	 * 
	 * @return
	 * @param name
	 *            账号
	 */

	public User findUserInfo(String name)
	{

		return (User) find("from User where name = ? ", name);
	}

}
