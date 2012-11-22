package com.hanbang.oa.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hanbang.core.service.EntityService;
import com.hanbang.oa.dao.ReportNoDao;
import com.hanbang.oa.entity.security.ReportNo;




/**
 * 此类描述的是：禀议编号管理类
 * 
 * @author: 张敏明
 * @version: 2010-1-6 上午09:48:26
 */

@Service
public class ReportNoService extends EntityService<ReportNo, Long>
{
	@Resource
	private ReportNoDao reportNoDao;



	@Override
	protected ReportNoDao getEntityDao()
	{
		return reportNoDao;
	}


	/**
	 * 返回当前禀议编号信息,并使当前禀议编号顺序加一
	 * 
	 */
	@Transactional
	public ReportNo next()
	{
		ReportNo temp = reportNoDao.findByHour(getCurrentHour());
		if (temp == null)
		{
			temp = new ReportNo();
			temp.setHour(getCurrentHour());
			temp.setAlignment(1);
			reportNoDao.save(temp);
		}
		ReportNo reportNo = new ReportNo();
		reportNo.setId(temp.getId());
		reportNo.setHour(temp.getHour());
		reportNo.setAlignment(temp.getAlignment());
		temp.setAlignment(reportNo.getAlignment() + 1);
		return reportNo;
	}


	/**
	 * 重新设置禀议编号顺序
	 * 
	 */
	public void reset(Integer alignment)
	{
		ReportNo reportNo = reportNoDao.findByHour(getCurrentHour());
		reportNo.setAlignment(alignment);
	}


	/**
	 * 取得当前禀议书提交的日期信息
	 * 
	 */
	public String getCurrentHour()
	{
		DateFormat df = new SimpleDateFormat("yyMM");
		return df.format(new Date());
	}

}
