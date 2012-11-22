package com.hanbang.oa.service;

import java.io.File;
import java.util.List;
import javax.annotation.Resource;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.hanbang.core.service.EntityService;
import com.hanbang.oa.dao.UserDao;
import com.hanbang.oa.entity.security.User;




/**
 * 此类描述的是：用户管理类.
 * 
 * @author: 张敏明
 * @version: 2010-1-4 下午08:04:10
 */

@Service
public class UserService extends EntityService<User, Long>
{
	@Resource
	private UserDao userDao;

	@Resource
	private UploadedService uploadedManager;



	@Override
	protected UserDao getEntityDao()
	{
		return userDao;
	}


	/**
	 * 查询登录用户
	 * 
	 * @param name
	 * @param pwd
	 * @return
	 */
	@Transactional(readOnly = true)
	public User findLogin(String name, String pwd)
	{
		return userDao.findLogin(name, pwd);
	}


	/**
	 * 保存用户及签字附件
	 * 
	 * @param user
	 * @param realPath
	 * @param upload
	 * @param uploadFileName
	 * @throws Exception
	 */
	@Transactional
	public void save(User user, String realPath, List<File> upload, List<String> uploadFileName) throws Exception
	{
		saveOrUpdate(user);
		if (upload != null && upload.size() > 0)
			uploadedManager.saveFile(user.getId(), User.class.getSimpleName(), realPath, upload, uploadFileName);
	}


	/**
	 * 检查用户名是否唯一.
	 * 
	 * @return loginName在数据库中唯一时返回true.
	 */
	@Transactional(readOnly = true)
	public boolean isLoginNameUnique(String loginName)
	{
		if (StringUtils.isEmpty(loginName))
			return false;
		List<User> lst = userDao.findByProperty("name", loginName);
		return lst.isEmpty();
	}


	/**
	 * 
	 * @return
	 * @param 账号
	 */
	public User findByName(String name)
	{
		return userDao.findUserInfo(name);
	}

}
