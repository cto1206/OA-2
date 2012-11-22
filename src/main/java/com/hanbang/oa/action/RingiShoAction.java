package com.hanbang.oa.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.lang.StringUtils;

import com.hanbang.core.action.FileUploadAction;
import com.hanbang.core.dao.support.Page;
import com.hanbang.core.utils.ActionUtil;
import com.hanbang.core.utils.Struts2Utils;
import com.hanbang.oa.entity.security.RingiSho;
import com.hanbang.oa.entity.security.RingiShoDetail;
import com.hanbang.oa.entity.security.Uploaded;
import com.hanbang.oa.entity.security.User;
import com.hanbang.oa.model.RingiShoTask;
import com.hanbang.oa.service.RingiShoService;
import com.hanbang.oa.service.UploadedService;




/**
 * 禀议管理控制器
 * 
 * @author zmm
 * 
 */
public class RingiShoAction extends FileUploadAction<RingiSho>
{

	private static final long serialVersionUID = 1L;

	// 审查视图页面返回标识
	public static final String FLOWVIEW = "flowView";

	// 撤销禀议返回标识
	public static final String REJECTRELOADVIEW = "rejectReloadView";

	// 审查视图页面返回标识
	public static final String FORMEDITVIEW = "formEditView";

	// 打印视图页面返回标识
	public static final String PRINTVIEW = "printView";

	// 待办任务列表返回标识
	public static final String PENDINGTASKVIEW = "pendingTaskView";

	// 驳回任务列表返回标识
	public static final String REJECTTASKVIEW = "rejectTaskView";

	// 当前活动任务列表返回标识
	public static final String ACTIVITYVIEW = "activityView";

	// 流程监视明细返回标识
	public static final String MONITORVIEW = "monitorView";

	private String state;

	// 禀议码
	private String ringiShoCode;

	private RingiSho ringiSho;

	private RingiShoDetail ringiShoDetail;

	private List<Uploaded> uploadeds;

	private Map<String, Uploaded> flowSigns;

	private String taskId;

	private List<RingiShoTask> ringiShoTaskList;

	private RingiShoTask ringiShoTask;

	@Resource
	private RingiShoService ringiShoService;

	@Resource
	private UploadedService uploadedManager;



	/**
	 * 验证禀议码
	 * 
	 * @return
	 * @throws Exception
	 */
	public String checkCode()
	{
		Boolean isOk = false;
		if (StringUtils.isNotEmpty(ringiShoCode))
		{
			User user = (User) ActionUtil.getCurLoginInfo();
			if (ringiShoCode.equalsIgnoreCase(user.getByPwd()))
				isOk = true;
		}
		return Struts2Utils.renderJson("({checked:" + isOk + "})");
	}


	/**
	 * 已审批的禀议列表
	 * 
	 * @return
	 * @throws Exception
	 */
	@Override
	protected void list(Page<RingiSho> page) throws Exception
	{
		if (StringUtils.isNotEmpty(state))
			ringiShoService.getRingiShoBy(page, ActionUtil.getCurLoginInfo().getId(), Short.parseShort(state));
	}


	/**
	 * 待办任务列表
	 * 
	 * @return
	 * @throws Exception
	 */
	public String pendingTasks() throws Exception
	{
		User user = ActionUtil.getCurLoginInfo();
		ringiShoTaskList = ringiShoService.getPendingTasks(user.getId());
		return PENDINGTASKVIEW;
	}


	/**
	 * 驳回任务列表
	 * 
	 * @return
	 * @throws Exception
	 */
	public String rejectTasks() throws Exception
	{
		User user = ActionUtil.getCurLoginInfo();
		ringiShoTaskList = ringiShoService.getRejectTasks(user.getId());
		return REJECTTASKVIEW;
	}


	/**
	 * 审查禀议申请单
	 * 
	 * @return
	 * @throws Exception
	 */
	public String review() throws Exception
	{
		ringiShoTask = ringiShoService.getRingiShoByTask(taskId);
		uploadeds = uploadedManager.findBy(ringiShoTask.getRingiSho().getId(), RingiSho.class.getSimpleName());
		return FLOWVIEW;
	}


	/**
	 * 修改禀议申请单
	 * 
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception
	{
		ringiShoTask = ringiShoService.getRingiShoByTask(taskId);
		uploadeds = uploadedManager.findBy(ringiShoTask.getRingiSho().getId(), RingiSho.class.getSimpleName());
		return FORMEDITVIEW;
	}


	/**
	 * 当前流程执行情况详细
	 * 
	 * @return
	 * @throws Exception
	 */
	public String monitor() throws Exception
	{
		if (getKey() != null)
		{
			ringiSho = ringiShoService.get(getKey());
			uploadeds = uploadedManager.findBy(ringiSho.getId(), RingiSho.class.getSimpleName());
		}
		return MONITORVIEW;
	}


	/**
	 * 禀议申请单内容
	 * 
	 * @return
	 * @throws Exception
	 */
	public String details() throws Exception
	{
		if (getKey() != null)
		{
			ringiSho = ringiShoService.get(getKey());
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
		return PRINTVIEW;
	}


	/**
	 * 禀议批准通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String confirm() throws Exception
	{
		ringiShoService.confirm(ringiShoDetail, taskId);
		return RELOADVIEW;
	}


	/**
	 * 禀议驳回
	 * 
	 * @return
	 * @throws Exception
	 */
	public String reject() throws Exception
	{
		ringiShoService.reject(ringiShoDetail, taskId);
		return RELOADVIEW;
	}


	/**
	 * 禀议申请单发起
	 * 
	 * @return
	 * @throws Exception
	 */
	public String draft() throws Exception
	{
		ringiSho.setUser(ActionUtil.getCurLoginInfo());
		ringiSho.setDate(new Date());
		ringiSho.setState((short) 0);
		if (ringiSho.getFlowManStock() == null)
		{
			ringiSho.setFlag((short) 1);
		}
		else if (ringiSho.getFlowManFinance() == null)
		{
			ringiSho.setFlag((short) 0);
		}
		ringiShoService.startDraft(ringiSho, getUploadPath(), getUpload(), getUploadFileName());
		return ACTIVITYVIEW;
	}


	/**
	 * 驳回后修改禀议申请单
	 * 
	 * @return
	 * @throws Exception
	 */
	public String reDraft() throws Exception
	{
		ringiSho.setState((short) 0);
		if (ringiSho.getFlowManStock() == null)
		{
			ringiSho.setFlag((short) 1);
		}
		else if (ringiSho.getFlowManFinance() == null)
		{
			ringiSho.setFlag((short) 0);
		}
		ringiShoService.modifDraft(taskId, ringiSho, getUploadPath(), getUpload(), getUploadFileName());
		return ACTIVITYVIEW;
	}


	public void setTaskId(String taskId)
	{
		this.taskId = taskId;
	}


	public RingiSho getRingiSho()
	{
		return ringiSho;
	}


	public void setRingiSho(RingiSho ringiSho)
	{
		this.ringiSho = ringiSho;
	}


	public RingiShoDetail getRingiShoDetail()
	{
		return ringiShoDetail;
	}


	public void setRingiShoDetail(RingiShoDetail ringiShoDetail)
	{
		this.ringiShoDetail = ringiShoDetail;
	}


	public List<RingiShoTask> getRingiShoTaskList()
	{
		return ringiShoTaskList;
	}


	public RingiShoTask getRingiShoTask()
	{
		return ringiShoTask;
	}


	public List<Uploaded> getUploadeds()
	{
		return uploadeds;
	}


	public Map<String, Uploaded> getFlowSigns()
	{
		return flowSigns;
	}


	public void setRingiShoCode(String ringiShoCode)
	{
		this.ringiShoCode = ringiShoCode;
	}


	public void setState(String state)
	{
		this.state = state;
	}


	@Override
	public String delete() throws Exception
	{
		if (StringUtils.isNotEmpty(taskId))
		{
			ringiShoService.delete(taskId);
		}
		return REJECTRELOADVIEW;
	}


	@Override
	public String get() throws Exception
	{
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public String save() throws Exception
	{
		// TODO Auto-generated method stub
		return null;
	}
}
