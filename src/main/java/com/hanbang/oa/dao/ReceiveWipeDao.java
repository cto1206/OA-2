package com.hanbang.oa.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.hanbang.core.dao.HibernateEntityDao;
import com.hanbang.oa.entity.security.ReceiveWipe;
import com.hanbang.oa.entity.security.RingiSho;




/**
 * 经费报销信息数据服务
 * 
 * @author zx
 * 
 */
@Repository
public class ReceiveWipeDao extends HibernateEntityDao<ReceiveWipe, Long>
{
	//查询某份报销单是否已经传送给了某人
	public List<ReceiveWipe> findReceiveBy(Long uId, Long wId)
	{
		String hql = "from ReceiveWipe a where a.RUser.id = ? and a.wipe.id = ?";
		return find(hql, new Object[] { uId, wId });
	}
	
	//查询接收报销列表
	public List<ReceiveWipe> selByUid(Long uId,Short state){	
		
		String hql = "from ReceiveWipe a where a.RUser.id = ? and a.state = ?";
		return find(hql, new Object[] { uId, state });
	}
}
