package com.hanbang.oa.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.hanbang.core.dao.support.Page;
import com.hanbang.core.service.EntityService;
import com.hanbang.oa.dao.ReceiveReportDao;
import com.hanbang.oa.entity.security.ReceiveReport;




/**
 * 此类描述的是： 禀议报告转发类
 * 
 * @author: 张敏明
 * @version: 2010-3-9 下午02:32:57
 */
@Service
public class ReceiveReportService extends EntityService<ReceiveReport, Long>
{
	@Resource
	private ReceiveReportDao receiveReportDao;



	@Override
	protected ReceiveReportDao getEntityDao()
	{
		return receiveReportDao;
	}


	/**
	 * 根据禀议报告转发后的状态查询禀议报告转发列表
	 * 
	 * @param page
	 * @param userId
	 * @param state
	 */
	public void find(Page<ReceiveReport> page, Long userId, Short state)
	{
		receiveReportDao.find(page, userId, state);
	}

}
