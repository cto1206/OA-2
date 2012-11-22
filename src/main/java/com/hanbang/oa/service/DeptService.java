package com.hanbang.oa.service;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.hanbang.core.service.EntityService;
import com.hanbang.oa.dao.DeptDao;
import com.hanbang.oa.entity.security.Dept;




/**
 * 此类描述的是：部门管理类
 * 
 * @author: 张敏明
 * @version: 2010-1-6 上午11:35:03
 */

@Service
public class DeptService extends EntityService<Dept, Long>
{

	@Resource
	private DeptDao deptDao;



	@Override
	protected DeptDao getEntityDao()
	{
		return deptDao;
	}

}
