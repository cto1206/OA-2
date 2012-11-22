package com.hanbang.oa.service;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.hanbang.core.service.EntityService;
import com.hanbang.oa.dao.RingiShoDetailDao;
import com.hanbang.oa.entity.security.RingiShoDetail;




/**
 * 此类描述的是：禀议报告指示事项管理类.
 * 
 * @author: 张敏明
 * @version: 2010-1-4 下午07:32:10
 */

@Service
public class RingiShoDetailService extends EntityService<RingiShoDetail, Long>
{
	@Resource
	private RingiShoDetailDao ringiShoDetailDao;



	@Override
	protected RingiShoDetailDao getEntityDao()
	{
		return ringiShoDetailDao;
	}

}
