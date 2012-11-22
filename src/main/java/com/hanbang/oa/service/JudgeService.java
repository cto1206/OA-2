package com.hanbang.oa.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hanbang.core.service.EntityService;
import com.hanbang.oa.dao.JudgerDao;
import com.hanbang.oa.dao.WipeDao;
import com.hanbang.oa.entity.security.Judge;
import com.hanbang.oa.entity.security.Wipe;

/**
 * 此类描述的是：决策管理类.
 * 
 * @author: 张敏明
 * @version: 2010-1-8 上午08:15:14
 */

@Service
public class JudgeService extends EntityService<Judge, Long> {
	@Resource
	private JudgerDao judgeDao;

	@Resource
	private WipeDao wipeDao;

	@Override
	protected JudgerDao getEntityDao() {
		return judgeDao;
	}

	// 查询某个禀议编号下面的所有的有审批时间和指示事项的审批
	public List<Judge> selJudgeByCode(Long wCode) {
		return judgeDao.selJudgeByCode(wCode);
	}

	// 删除某个禀议编号下面的所有审批
	public void del(Long wId) {
		judgeDao.delByWid(wId);
	}

	// 查询某个人的已审批
	public List<Judge> selJudgeByUser(Long uid) {
		return judgeDao.selJudgeByUser(uid);
	}

	// 查询某个人的已审批
	public List<Wipe> findWipeByUser(Long uid) {
		return wipeDao.findWipeByUser(uid);
	}

}
