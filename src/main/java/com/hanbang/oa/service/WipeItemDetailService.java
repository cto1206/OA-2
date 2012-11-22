package com.hanbang.oa.service;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.hanbang.core.dao.support.Page;
import com.hanbang.core.service.EntityService;
import com.hanbang.oa.dao.WipeItemDetailDao;
import com.hanbang.oa.entity.security.User;
import com.hanbang.oa.entity.security.WipeItemDetail;




/**
 * 经费报销项目详细管理类.
 * 
 * 实现领域对象部门的所有业务管理函数. 演示派生DAO层子类的模式,由注入的RingiShoDao封装数据库访问.
 * 
 * 通过泛型声明继承EntityManager,默认拥有CRUD管理方法. 使用Spring annotation定义事务管理.
 * 
 * @author zx
 */
// Spring Service Bean的标识.
@Service
public class WipeItemDetailService extends EntityService<WipeItemDetail, Long>
{
	@Resource
	private WipeItemDetailDao wipeItemDetailDao;



	@Override
	protected WipeItemDetailDao getEntityDao()
	{

		return wipeItemDetailDao;
	}


	// 根据报销编号查找报销项目详细
	public List<WipeItemDetail> selItemByWid(Long wId)
	{
		return wipeItemDetailDao.selItemByWid(wId);
	}


	// 根据报销项目编号查找报销项目详细
	public List<WipeItemDetail> selItemByIid(Long iId)
	{
		return wipeItemDetailDao.selItemByIid(iId);
	}


	// 根据报销编号查找报销项目项目
	public Page<WipeItemDetail> selItemByWid(Long wId, Page<WipeItemDetail> page)
	{
		return wipeItemDetailDao.selItemByWid(wId, page);
	}


	// 查询某个人所写的经费报销
	public Page<WipeItemDetail> getMyAll(User curUser, Page<WipeItemDetail> page, Long wId)
	{
		return wipeItemDetailDao.getMyAll(curUser, page, wId);
	}

}
