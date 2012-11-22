package com.hanbang.oa.action;

import javax.annotation.Resource;
import com.hanbang.core.action.CRUDActionSupport;
import com.hanbang.core.dao.support.Page;
import com.hanbang.oa.entity.security.RingiSho;
import com.hanbang.oa.service.RingiShoService;




/**
 * 此类描述的是：已审禀议查询
 * 
 * @author: 张敏明
 * @version: 2010-1-6 下午06:13:52
 */

public class RingiShoMeAction extends CRUDActionSupport<RingiSho>
{

	private static final long serialVersionUID = 1L;

	@Resource
	private RingiShoService ringiShoService;



	@Override
	public String delete() throws Exception
	{
		return null;
	}


	@Override
	public String get() throws Exception
	{
		return null;
	}


	@Override
	protected void list(Page<RingiSho> p) throws Exception
	{
		ringiShoService.getCompleteList(p);
	}


	@Override
	public String save() throws Exception
	{
		return null;
	}

}
