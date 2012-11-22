package com.hanbang.core.action;

import java.util.List;

import javax.annotation.Resource;

import com.hanbang.core.utils.ActionUtil;
import com.hanbang.oa.entity.security.RingiSho;
import com.hanbang.oa.entity.security.User;
import com.hanbang.oa.model.RingiShoTask;
import com.hanbang.oa.service.RingiShoService;
import com.hanbang.oa.service.WipeService;




public class IndexMessageAction
{

	@Resource
	private WipeService wipeManager;

	@Resource
	private RingiShoService ringiShoService;

	@SuppressWarnings("unused")
	private Integer weiPiSize = 0;

	@SuppressWarnings("unused")
	private Integer yiPiSize = 0;

	private String display;



	public String getDisplay()
	{
		return display;
	}


	// 显示主界面详细信息
	public String getIndexMessage() throws Exception
	{
		if (wipeManager.weiShenPiList() != null)
			weiPiSize = wipeManager.weiShenPiList().size();

		if (wipeManager.yiShenPiList() != null)
			yiPiSize = wipeManager.yiShenPiList().size();

		User user = ActionUtil.getCurLoginInfo();

		// 待办禀议
		Integer todoSize = 0;
		// 已批禀议
		Integer endSize = 0;

		List<RingiShoTask> ringiShoTaskList = ringiShoService.getPendingTasks(user.getId());
		if (ringiShoTaskList != null && !ringiShoTaskList.isEmpty())
			todoSize = ringiShoTaskList.size();

		List<RingiSho> ringiShoList = ringiShoService.getRingiShoBy(user.getId(), (short) 1);
		if (ringiShoList != null && !ringiShoList.isEmpty())
			endSize = ringiShoList.size();
		display = "您有" + weiPiSize + "条待审批报销，有" + yiPiSize + "条已经审批报销";

		display += "<br>你有" + todoSize + "条待办禀议，有" + endSize + "条已批禀议";

		return "index";
	}
}
