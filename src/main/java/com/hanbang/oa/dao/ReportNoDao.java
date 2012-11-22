package com.hanbang.oa.dao;

import org.springframework.stereotype.Repository;
import com.hanbang.core.dao.HibernateEntityDao;
import com.hanbang.oa.entity.security.ReportNo;




/**
 * 此类描述的是：禀议编号数据服务
 * 
 * @author: 张敏明
 * @version: 2010-1-6 上午09:44:45
 */

@Repository
public class ReportNoDao extends HibernateEntityDao<ReportNo, Long>
{

	/**
	 * 根据禀议书提交的时间查询禀议编号
	 * 
	 * @param hour
	 * 
	 */
	public ReportNo findByHour(String hour)
	{
		return (ReportNo) findUnique("from ReportNo where hour = ?", hour);
	}
}
