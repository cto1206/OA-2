package com.hanbang.oa.dao;

import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import com.hanbang.core.dao.HibernateEntityDao;
import com.hanbang.core.dao.support.Page;
import com.hanbang.oa.entity.security.RingiSho;




/**
 * 此类描述的是：禀议报告数据服务
 * 
 * @author: 张敏明
 * @version: 2010-1-4 下午07:48:51
 */

@Repository
public class RingiShoDao extends HibernateEntityDao<RingiSho, Long>
{

	/**
	 * 根据审批状态查询禀议报告
	 * 
	 * @param page
	 * @param userId
	 * @param state
	 */
	public void getRingiShoBy(Page<RingiSho> page, Long userId, Short state)
	{
		DetachedCriteria dc = DetachedCriteria.forClass(RingiSho.class);
		dc.add(Restrictions.eq("user.id", userId));
		dc.add(Restrictions.eq("state", state));
		pagedQuery(page, dc);
	}


	/**
	 * 查询所有完成的禀议书
	 * 
	 * @param page
	 */
	public void getCompleteList(Page<RingiSho> page)
	{
		DetachedCriteria dc = DetachedCriteria.forClass(RingiSho.class);
		dc.add(Restrictions.eq("state", (short)1));
		dc.addOrder(Order.desc("date"));
		pagedQuery(page, dc);
	}


	/**
	 * 根据审批状态查询禀议报告
	 * 
	 * @param userId
	 * @param state
	 * @return
	 */
	public List<RingiSho> getRingiShoBy(Long userId, Short state)
	{
		String hql = "from RingiSho a where a.user.id = ? and a.state = ?";
		return find(hql, new Object[] { userId, state });
	}
}
