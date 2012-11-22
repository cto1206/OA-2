package com.hanbang.oa.dao;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import com.hanbang.core.dao.HibernateEntityDao;
import com.hanbang.core.dao.support.Page;
import com.hanbang.oa.entity.security.ReceiveReport;




/**
 * 此类描述的是：禀议报告转发
 * 
 * @author: 张敏明
 * @version: 2010-3-9 下午02:29:25
 */
@Repository
public class ReceiveReportDao extends HibernateEntityDao<ReceiveReport, Long>
{
	/**
	 * 根据禀议报告转发后的状态查询禀议报告转发列表
	 * 
	 * @param page
	 * @param userId
	 * @param state
	 */
	public void find(Page<ReceiveReport> page, Long userId, Short state)
	{
		DetachedCriteria dc = DetachedCriteria.forClass(ReceiveReport.class);
		dc.add(Restrictions.eq("RUser.id", userId));
		dc.add(Restrictions.eq("state", state));
		pagedQuery(page, dc);
	}

}
