package com.hanbang.oa.dao;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.hanbang.core.dao.HibernateEntityDao;
import com.hanbang.core.dao.support.Page;
import com.hanbang.oa.entity.security.User;
import com.hanbang.oa.entity.security.WipeItem;




/**
 * 经费报销信息数据服务
 * 
 * @author zx
 * 
 */
@Repository
public class WipeItemDao extends HibernateEntityDao<WipeItem, Long>
{
	// 根据报销编号查找报销项目
	public void updByItem(WipeItem item)
	{
	    super.getSession().createQuery("update WipeItem set iMoney="+item.getiMoney()+"where iItem="+item.getiItem()).executeUpdate();	
	
	}
	
	// 根据报销编号查找报销项目
	public List<WipeItem> selItemByWid(Long wId)
	{
		return find("from WipeItem where wipe.id = ?", wId);
	}


	// 根据报销编号查找报销项目
	public Page<WipeItem> selItemByWid(Long wId, Page<WipeItem> page)
	{
		String hql = "from WipeItem where wipe.id = ?";
		return pagedQuery(page, hql, wId);
	}


	// 查询某个人的经费报销项目
	public Page<WipeItem> getMyAll(User curUser, Page<WipeItem> page, Long wId)
	{
		String hql = "from WipeItem where wipe.wUser.id=" + curUser.getId();
		if (wId != null)
		{
			hql = hql + " and wipe.id=" + wId;
		}
		return pagedQuery(page, hql);
	}


	// 查询某个人的经费报销项目
	public List<WipeItem> getMyAll(User curUser, Long wId)
	{
		String hql = "from WipeItem where wipe.wUser.id=" + curUser.getId();
		if (wId != null)
		{
			hql = hql + " and wipe.id=" + wId;
		}
		return find(hql);
	}

}
