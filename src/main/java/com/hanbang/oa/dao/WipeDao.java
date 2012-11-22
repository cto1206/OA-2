package com.hanbang.oa.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.hanbang.core.dao.HibernateEntityDao;
import com.hanbang.core.dao.support.Page;
import com.hanbang.oa.entity.security.User;
import com.hanbang.oa.entity.security.Wipe;

/**
 * 经费报销信息数据服务
 * 
 * @author zx
 * 
 */
@Repository
public class WipeDao extends HibernateEntityDao<Wipe, Long> {
	// 查询所有完成的禀议书
	public void getCompleteList(Page<Wipe> page) {
		DetachedCriteria dc = DetachedCriteria.forClass(Wipe.class);
		dc.add(Restrictions.eq("state", (short) 1));
		dc.addOrder(Order.desc("wApTime"));
		pagedQuery(page, dc);
	}

	// 根据经费状态查询经费
	public void getWipeBy(Page<Wipe> page, Long userId, Short state) {
		DetachedCriteria dc = DetachedCriteria.forClass(Wipe.class);
		if (userId != null) {
			dc.add(Restrictions.eq("wUser.id", userId));
		}
		dc.add(Restrictions.eq("state", state));
		dc.addOrder(Order.desc("wApTime"));
		pagedQuery(page, dc);
	}

	public Page<Wipe> getMyAll(User curUser, Page<Wipe> page) {
		String hql = "from Wipe where wUser.id=? order by wApTime desc";
		return pagedQuery(page, hql, curUser.getId());
	}

	public Wipe getWipe(String wCode) {
		List<Wipe> lst = findByProperty("wCode", wCode);
		if (lst == null || lst.isEmpty())
			return null;
		return lst.get(0);
	}

	public Page<Wipe> getMyAll(User curUser, Page<Wipe> page, String selDate) {
		String hql = "from Wipe where wUser.id=? and wApTime=? order by wApTime desc";
		return pagedQuery(page, hql, curUser.getId(), selDate);
	}

	public Page<Wipe> getMyAll(Page<Wipe> page, String selDate) {
		String hql = "from Wipe where wApTime=? order by wApTime desc";
		return pagedQuery(page, hql, selDate);
	}

	//查询某个人的已审批
	public List<Wipe> findWipeByUser(Long uid) {
		String hql = "select distinct a.wipe from Judge a where a.user.id = ? and a.judgeDate is not null and a.wipe.state in (0,1) order by a.wipe.wApTime desc";
		return find(hql, uid);
	}

	public void mery(Wipe wipe) {
		merge(wipe);
	}
}
