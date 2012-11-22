package com.hanbang.oa.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.hanbang.core.action.CRUDActionSupport;
import com.hanbang.core.dao.support.Page;
import com.hanbang.core.utils.ActionUtil;
import com.hanbang.core.utils.Struts2Utils;
import com.hanbang.oa.entity.security.ReceiveReport;
import com.hanbang.oa.entity.security.RingiSho;
import com.hanbang.oa.entity.security.Uploaded;
import com.hanbang.oa.entity.security.User;
import com.hanbang.oa.service.ReceiveReportService;
import com.hanbang.oa.service.UploadedService;




public class ReportMailAction extends CRUDActionSupport<ReceiveReport>
{

	private static final long serialVersionUID = 1L;

	private RingiSho ringiSho;

	private ReceiveReport receiveReport;

	private User user;

	private Short state;

	// 详细信息视图返回标识
	public static final String DETAILVIEW = "detailView";

	private List<Uploaded> uploadeds;

	private Map<String, Uploaded> flowSigns;

	@Resource
	private ReceiveReportService receiveReportService;

	@Resource
	private UploadedService uploadedManager;



	@Override
	public String delete() throws Exception
	{
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public String get() throws Exception
	{
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	protected void list(Page<ReceiveReport> p) throws Exception
	{
		if (state != null)
		{
			receiveReportService.find(p, ActionUtil.getCurLoginInfo().getId(), state);
		}

	}


	@Override
	public String save() throws Exception
	{
		if (ringiSho == null || ringiSho.getId() == null)
			return null;

		if (user == null || user.getId() == null)
			return null;

		ReceiveReport receiveReport = new ReceiveReport();
		receiveReport.setRingiSho(ringiSho);
		receiveReport.setSUser(ActionUtil.getCurLoginInfo());
		receiveReport.setRUser(user);
		receiveReport.setDate(new Date());
		receiveReport.setState((short) 0);

		receiveReportService.save(receiveReport);
		return Struts2Utils.renderText("true");
	}


	/**
	 * 显示详细信息
	 * 
	 */
	public String details() throws Exception
	{
		if (getKey() != null)
		{
			receiveReport = receiveReportService.get(getKey());
			ringiSho = receiveReport.getRingiSho();
			if (receiveReport.getState().shortValue() != 1)
			{
				receiveReport.setState((short) 1);
				receiveReportService.save(receiveReport);
			}

			uploadeds = uploadedManager.findBy(ringiSho.getId(), RingiSho.class.getSimpleName());
			flowSigns = new HashMap<String, Uploaded>();
			User flowMan = null;
			List<Uploaded> signs = null;

			// 一级审查人员签名
			flowMan = ringiSho.getFlowMan1();
			if (flowMan != null && flowMan.getId() != null)
			{
				signs = uploadedManager.findBy(flowMan.getId(), User.class.getSimpleName());
				if (signs != null && !signs.isEmpty())
					flowSigns.put("flowMan1", signs.get(0));
			}

			// 二级决裁人员签名
			flowMan = ringiSho.getFlowMan2();
			if (flowMan != null && flowMan.getId() != null)
			{
				signs = uploadedManager.findBy(flowMan.getId(), User.class.getSimpleName());
				if (signs != null && !signs.isEmpty())
					flowSigns.put("flowMan2", signs.get(0));
			}

			if (ringiSho.getLeType() == 1)
			{
				// 三级采购人员签名
				flowMan = ringiSho.getFlowManStock();
				if (flowMan != null && flowMan.getId() != null)
				{
					signs = uploadedManager.findBy(flowMan.getId(), User.class.getSimpleName());
					if (signs != null && !signs.isEmpty())
						flowSigns.put("flowManStock", signs.get(0));
				}

				// 三级财务人员签名
				flowMan = ringiSho.getFlowManFinance();
				if (flowMan != null && flowMan.getId() != null)
				{
					signs = uploadedManager.findBy(flowMan.getId(), User.class.getSimpleName());
					if (signs != null && !signs.isEmpty())
						flowSigns.put("flowManFinance", signs.get(0));
				}

				// 四级决裁人员签名
				flowMan = ringiSho.getFlowMan4();
				if (flowMan != null && flowMan.getId() != null)
				{
					signs = uploadedManager.findBy(flowMan.getId(), User.class.getSimpleName());
					if (signs != null && !signs.isEmpty())
						flowSigns.put("flowMan4", signs.get(0));
				}

				// 董事长决裁签名
				flowMan = ringiSho.getPresidentMan();
				if (flowMan != null && flowMan.getId() != null)
				{
					signs = uploadedManager.findBy(flowMan.getId(), User.class.getSimpleName());
					if (signs != null && !signs.isEmpty())
						flowSigns.put("presidentMan", signs.get(0));
				}
			}
		}
		return DETAILVIEW;
	}


	public RingiSho getRingiSho()
	{
		return ringiSho;
	}


	public void setRingiSho(RingiSho ringiSho)
	{
		this.ringiSho = ringiSho;
	}


	public User getUser()
	{
		return user;
	}


	public void setUser(User user)
	{
		this.user = user;
	}


	public void setState(Short state)
	{
		this.state = state;
	}


	public ReceiveReport getReceiveReport()
	{
		return receiveReport;
	}


	public List<Uploaded> getUploadeds()
	{
		return uploadeds;
	}


	public Map<String, Uploaded> getFlowSigns()
	{
		return flowSigns;
	}
}
