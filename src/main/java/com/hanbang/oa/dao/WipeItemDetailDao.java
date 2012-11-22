package com.hanbang.oa.dao;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.hanbang.core.dao.HibernateEntityDao;
import com.hanbang.core.dao.support.Page;
import com.hanbang.oa.entity.security.User;
import com.hanbang.oa.entity.security.WipeItemDetail;




/**
 * 经费报销信息数据服务
 * 
 * @author zx
 * 
 */
@Repository
public class WipeItemDetailDao extends HibernateEntityDao<WipeItemDetail, Long>
{
	// 根据报销编号查找报销项目详细
	public List<WipeItemDetail> selItemByWid(Long wId)
	{
		return find("from WipeItemDetail where wipeItem.wipe.id = ?", wId);
	}


	// 根据报销项目编号查找报销项目详细
	public List<WipeItemDetail> selItemByIid(Long iId)
	{
		return this.find("from WipeItemDetail where wipeItem.id = ?", iId);
	}


	// 根据报销编号查找报销项目
	public Page<WipeItemDetail> selItemByWid(Long wId, Page<WipeItemDetail> page)
	{
		String hql = "from WipeItemDetail where wipeItem.wipe.id = ?";
		return pagedQuery(page, hql, wId);
	}


	// 查询某个人的经费报销项目
	public Page<WipeItemDetail> getMyAll(User curUser, Page<WipeItemDetail> page, Long wId)
	{
		String hql = "from WipeItemDetail where wipeItem.wipe.wUser.id=" + curUser.getId();
		if (wId != null)
		{
			hql = hql + " and wipeItem.wipe.id=" + wId;
		}
		return pagedQuery(page, hql);
	}
}
