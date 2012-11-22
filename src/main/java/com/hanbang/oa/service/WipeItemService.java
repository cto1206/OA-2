package com.hanbang.oa.service;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.hanbang.core.dao.support.Page;
import com.hanbang.core.service.EntityService;
import com.hanbang.oa.dao.WipeItemDao;
import com.hanbang.oa.entity.security.User;
import com.hanbang.oa.entity.security.WipeItem;




/**
 * 经费报销管理类.
 * 
 * 实现领域对象部门的所有业务管理函数. 演示派生DAO层子类的模式,由注入的RingiShoDao封装数据库访问.
 * 
 * 通过泛型声明继承EntityManager,默认拥有CRUD管理方法. 使用Spring annotation定义事务管理.
 * 
 * @author zx
 */
// Spring Service Bean的标识.
@Service
public class WipeItemService extends EntityService<WipeItem, Long>
{
	@Resource
	private WipeItemDao wipeItemDao;

    

	@Override
	protected WipeItemDao getEntityDao()
	{
		return wipeItemDao;
	}

	// 根据报销编号查找报销项目
	public void updByItem(WipeItem item)
	{
		 wipeItemDao.updByItem(item);
	}
	

	// 根据报销编号查找报销项目
	public List<WipeItem> selItemByWid(Long wId)
	{
		return wipeItemDao.selItemByWid(wId);
	}


	// 根据报销编号查找报销项目
	public Page<WipeItem> selItemByWid(Long wId, Page<WipeItem> page)
	{
		return wipeItemDao.selItemByWid(wId, page);
	}


	// 查询某个人所写的经费报销
	public Page<WipeItem> getMyAll(User curUser, Page<WipeItem> page, Long wId)
	{
		return wipeItemDao.getMyAll(curUser, page, wId);
	}


	// 查询某个人所写的经费报销
	public List<WipeItem> getMyAll(User curUser, Long wId)
	{
		return wipeItemDao.getMyAll(curUser, wId);
	}
}
