package com.hanbang.oa.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hanbang.core.dao.HibernateEntityDao;
import com.hanbang.oa.entity.security.Judge;

/**
 * 决策Dao
 * 
 * @author zx
 * 
 */
@Repository
public class JudgerDao extends HibernateEntityDao<Judge, Long> {
	//查询某个禀议编号下面的所有的有审批时间和指示事项的审批
	public List<Judge> selJudgeByCode(Long wCode) {
		String hql = "from Judge where judgeDate!=null and wipe.id=" + wCode + "";
		return this.find(hql);
	}

	//查询某个人的已审批
	public List<Judge> selJudgeByUser(Long uid) {
		String hql = "from Judge where user.id=" + uid + " and judgeDate!=null";
		return this.find(hql);
	}

	public void delByWid(Long wId) {
		List<Judge> judgeList = this.find("from Judge where wipe.id=" + wId + "");
		for (Judge judge : judgeList) {
			super.delete(judge);

		}
	}
}
