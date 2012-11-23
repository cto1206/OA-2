package com.hanbang.oa.service;

import java.io.File;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.lang.StringUtils;
import org.jbpm.api.Execution;
import org.jbpm.api.ExecutionService;
import org.jbpm.api.TaskService;
import org.jbpm.api.task.Task;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.hanbang.core.dao.support.Page;
import com.hanbang.core.service.EntityService;
import com.hanbang.oa.dao.RingiShoDao;
import com.hanbang.oa.entity.security.ReportNo;
import com.hanbang.oa.entity.security.RingiSho;
import com.hanbang.oa.entity.security.RingiShoDetail;
import com.hanbang.oa.entity.security.User;
import com.hanbang.oa.model.RingiShoTask;




/**
 * 此类描述的是： 禀议报告管理类.
 * 
 * @author: 张敏明
 * @version: 2010-1-4 下午07:51:27
 */

@Service
public class RingiShoService extends EntityService<RingiSho, Long>
{
	// 禀议书标识
	protected static final String REPORT = "report-";

	@Resource
	private RingiShoDao ringiShoDao;

	@Resource
	private RingiShoDetailService ringiShoDetailService;

	@Resource
	private ReportNoService reportNoService;

	@Resource
	private UploadedService uploadedManager;

	@Resource
	private ExecutionService executionService;

	@Resource
	private TaskService taskService;



	@Override
	protected RingiShoDao getEntityDao()
	{
		return ringiShoDao;
	}


	/**
	 * 禀议申请单发起
	 * 
	 * @param ringiSho
	 */
	@Transactional
	public void startDraft(RingiSho ringiSho, String realPath, List<File> upload, List<String> uploadFileName) throws Exception
	{
		// 起草人
		String startUser = REPORT + ringiSho.getUser().getId();

		Map<String, Object> variables = new HashMap<String, Object>();
		variables.put("startUser", startUser);
		executionService.startProcessInstanceByKey("ringi", variables);

		saveOrUpdate(ringiSho);
		if (upload != null && upload.size() > 0)
			uploadedManager.saveFile(ringiSho.getId(), RingiSho.class.getSimpleName(), realPath, upload, uploadFileName);

		variables.put("riId", ringiSho.getId());
		variables.put("flowUser1", REPORT + ringiSho.getFlowMan1().getId());
		variables.put("flowUser2", REPORT + ringiSho.getFlowMan2().getId());

		// leType 为 1 则表示部外，需要进行三级和四级的合议
		if (ringiSho.getLeType() == 1)
		{

			if (ringiSho.getFlag() == 0)
			{
				variables.put("stockOrFinance", "采购类");
				variables.put("flowUserCG", REPORT + ringiSho.getFlowManStock().getId());
			}
			else if (ringiSho.getFlag() == 1)
			{
				variables.put("stockOrFinance", "经费类");
				variables.put("flowUserCW", REPORT + ringiSho.getFlowManFinance().getId());
			}
			variables.put("flowUser4", REPORT + ringiSho.getFlowMan4().getId());
		}

		Task task = taskService.findPersonalTasks(startUser).get(0);
		taskService.setVariables(task.getId(), variables);
		taskService.completeTask(task.getId());
	}


	/**
	 * 驳回后修改禀议申请单
	 * 
	 * @param ringiSho
	 * @param realPath
	 * @param upload
	 * @param uploadFileName
	 * @throws Exception
	 */
	@Transactional
	public void modifDraft(String taskId, RingiSho ringiSho, String realPath, List<File> upload, List<String> uploadFileName) throws Exception
	{
		Map<String, Object> variables = new HashMap<String, Object>();

		RingiSho temp = get(ringiSho.getId());
		temp.setCode(ringiSho.getCode());
		temp.setTitle(ringiSho.getTitle());
		temp.setFlag(ringiSho.getFlag());
		temp.setState(ringiSho.getState());
		temp.setSub(ringiSho.getSub());
		temp.setCause(ringiSho.getCause());
		temp.setSynopsis(ringiSho.getSynopsis());
		temp.setNeedDate(ringiSho.getNeedDate());
		temp.setLeType(ringiSho.getLeType());
		temp.setFlowDate1(null);
		temp.setFlowDate2(null);
		temp.setFlowDateStock(null);
		temp.setFlowDateFinance(null);
		temp.setFlowDate4(null);
		temp.setFlowMan1(ringiSho.getFlowMan1());
		temp.setFlowMan2(ringiSho.getFlowMan2());

		if (upload != null && upload.size() > 0)
			uploadedManager.saveFile(ringiSho.getId(), RingiSho.class.getSimpleName(), realPath, upload, uploadFileName);

		variables.put("flowUser1", REPORT + ringiSho.getFlowMan1().getId());
		variables.put("flowUser2", REPORT + ringiSho.getFlowMan2().getId());

		// leType 为 1 则表示部外，需要进行三级和四级的合议
		if (ringiSho.getLeType() == 1)
		{

			if (ringiSho.getFlag() == 0)
			{
				temp.setFlowManStock(ringiSho.getFlowManStock());
				variables.put("stockOrFinance", "采购类");
				variables.put("flowUserCG", REPORT + ringiSho.getFlowManStock().getId());
			}
			else if (ringiSho.getFlag() == 1)
			{
				temp.setFlowManFinance(ringiSho.getFlowManFinance());
				variables.put("stockOrFinance", "经费类");
				variables.put("flowUserCW", REPORT + ringiSho.getFlowManFinance().getId());
			}
			variables.put("flowUser4", REPORT + ringiSho.getFlowMan4().getId());
		}

		taskService.setVariables(taskId, variables);
		taskService.completeTask(taskId);

	}


	/**
	 * 根据当前用户取得待办禀议列表
	 * 
	 * @param userId
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<RingiShoTask> getPendingTasks(Long userId)
	{
		if (userId == null)
			return null;

		List<Task> taskList = taskService.findPersonalTasks(REPORT + userId);
		List<RingiShoTask> list = null;
		if (taskList != null && !taskList.isEmpty())
		{
			Long riId = null;
			list = new ArrayList<RingiShoTask>(taskList.size());
			RingiShoTask ringiShoTask = null;

			for (Task task : taskList)
			{
				if (task.getName().equalsIgnoreCase("填写禀议书"))
					continue;

				ringiShoTask = new RingiShoTask();
				ringiShoTask.setTask(task);
				riId = (Long) taskService.getVariable(task.getId(), "riId");
				if (riId != null)
				{
					ringiShoTask.setRingiSho(get(riId));
					list.add(ringiShoTask);
				}
			}
		}
		return list;
	}


	/**
	 * 根据当前用户取得驳回禀议任务列表
	 * 
	 * @param userId
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<RingiShoTask> getRejectTasks(Long userId)
	{
		if (userId == null)
			return null;

		List<Task> taskList = taskService.findPersonalTasks(REPORT + userId);
		List<RingiShoTask> list = null;
		if (taskList != null && !taskList.isEmpty())
		{
			Long riId = null;
			list = new ArrayList<RingiShoTask>(taskList.size());
			RingiShoTask ringiShoTask = null;

			for (Task task : taskList)
			{
				if (task.getName().equalsIgnoreCase("填写禀议书"))
				{
					ringiShoTask = new RingiShoTask();
					ringiShoTask.setTask(task);
					riId = (Long) taskService.getVariable(task.getId(), "riId");
					if (riId != null)
					{
						ringiShoTask.setRingiSho(get(riId));
						list.add(ringiShoTask);
					}
				}
			}
		}
		return list;
	}


	/**
	 * 根据当前任务号取得禀议详细信息
	 * 
	 * @param taskId
	 * @return
	 */
	@Transactional(readOnly = true)
	public RingiShoTask getRingiShoByTask(String taskId)
	{
		if (StringUtils.isEmpty(taskId))
			return null;
		RingiShoTask ringiShoTask = new RingiShoTask();
		ringiShoTask.setTask(taskService.getTask(taskId));
		Long riId = (Long) taskService.getVariable(taskId, "riId");
		ringiShoTask.setRingiSho(get(riId));
		return ringiShoTask;
	}


	/**
	 * 禀议批准通过
	 * 
	 * @param ringiShoDetail
	 */
	@Transactional
	public void confirm(RingiShoDetail ringiShoDetail, String taskId)
	{

		if (StringUtils.isNotEmpty(ringiShoDetail.getContent()))
			ringiShoDetailService.saveOrUpdate(ringiShoDetail);

		RingiSho ringiSho = get(ringiShoDetail.getRingiSho().getId());

		Task task = taskService.getTask(taskId);
		Execution execution = executionService.findExecutionById(task.getExecutionId());

		if (execution.getProcessInstance().isActive("部门主管"))
		{
			ringiSho.setFlowDate1(new Date());
			taskService.completeTask(taskId, "进入二级决裁");
		}
		else if (execution.getProcessInstance().isActive("项目经理"))
		{
			ringiSho.setFlowDate2(new Date());
			if (ringiSho.getLeType() == 0)
			{
				ringiSho.setState((short) 1);
				taskService.completeTask(taskId, "二级决裁通过");
				createReportNo(ringiSho);
			}
			else if (ringiSho.getLeType() == 1)
			{
				taskService.completeTask(taskId, "进入三级合议");
			}
		}
		else if (execution.getProcessInstance().isActive("采购主管"))
		{
			ringiSho.setCode(ringiShoDetail.getRingiSho().getCode());
			ringiSho.setFlowDateStock(new Date());
			taskService.completeTask(taskId, "采购主管通过");
		}
		else if (execution.getProcessInstance().isActive("财务主管"))
		{
			ringiSho.setCode(ringiShoDetail.getRingiSho().getCode());
			ringiSho.setFlowDateFinance(new Date());
			taskService.completeTask(taskId, "财务主管通过");
		}
		else if (execution.getProcessInstance().isActive("四级合议"))
		{
			// 如果设置了最终决裁则进入下一级审批
			ringiSho.setFlowDate4(new Date());
			User president = ringiShoDetail.getRingiSho().getPresidentMan();
			if (president != null && president.getId() != null)
			{
				ringiSho.setPresidentMan(president);
				Map<String, Object> variables = new HashMap<String, Object>(1);
				variables.put("flowUser5", REPORT + president.getId());
				taskService.setVariables(taskId, variables);
				taskService.completeTask(taskId, "最终决裁");
			}
			else
			{
				ringiSho.setState((short) 1);
				taskService.completeTask(taskId, "四级合议通过");
				createReportNo(ringiSho);
			}

		}
		else if (execution.getProcessInstance().isActive("董事长"))
		{
			ringiSho.setPresidentDate(new Date());
			ringiSho.setState((short) 1);
			taskService.completeTask(taskId, "最终决裁通过");
			createReportNo(ringiSho);
		}

	}


	/**
	 * 创建禀议编号
	 * 
	 * @param ringiSho
	 */
	protected void createReportNo(RingiSho ringiSho)
	{
		User user = ringiSho.getUser();
		StringBuffer code = new StringBuffer(user.getDept().getAlias());
		code.append("-");
		if (ringiSho.getLeType() == 0)
		{
			code.append("N");
		}
		else if (ringiSho.getLeType() == 1)
		{
			if (ringiSho.getFlag() == 0)
			{
				code.append("C");
			}
			else if (ringiSho.getFlag() == 1)
			{
				code.append("W");
			}

		}
		code.append("-");
		ReportNo reportNo = reportNoService.next();
		code.append(reportNo.getHour());
		code.append("-");
		DecimalFormat df = new DecimalFormat("000");
		code.append(df.format(reportNo.getAlignment()));
		ringiSho.setCode(code.toString());
	}


	/**
	 * 禀议驳回
	 * 
	 * @param taskId
	 */
	@Transactional
	public void reject(RingiShoDetail ringiShoDetail, String taskId)
	{
		if (StringUtils.isNotEmpty(ringiShoDetail.getContent()))
			ringiShoDetailService.saveOrUpdate(ringiShoDetail);
		RingiSho ringiSho = get(ringiShoDetail.getRingiSho().getId());
		ringiSho.setState((short) 2);
		Task task = taskService.getTask(taskId);
		Execution execution = executionService.findExecutionById(task.getExecutionId());
		System.out.println(execution.getProcessInstance().getName());
		if (execution.getProcessInstance().isActive("部门主管"))
		{
			taskService.completeTask(taskId, "主管驳回");
		}
		else if (execution.getProcessInstance().isActive("项目经理"))
		{
			taskService.completeTask(taskId, "项目经理驳回");
		}
		else if (execution.getProcessInstance().isActive("采购主管"))
		{
			taskService.completeTask(taskId, "采购主管驳回");
		}
		else if (execution.getProcessInstance().isActive("财务主管"))
		{
			taskService.completeTask(taskId, "财务主管驳回");
		}
		else if (execution.getProcessInstance().isActive("四级合议"))
		{
			taskService.completeTask(taskId, "四级合议驳回");
		}
		else if (execution.getProcessInstance().isActive("董事长"))
		{
			taskService.completeTask(taskId, "最终决裁驳回");
		}
	}


	/**
	 * 禀议撤销
	 * 
	 * @param taskId
	 */
	@Transactional
	public void delete(String taskId)
	{
		Task task = taskService.getTask(taskId);
		Execution execution = executionService.findExecutionById(task.getExecutionId());
		if (execution.getProcessInstance().isActive("填写禀议书"))
		{
			Long riId = (Long) taskService.getVariable(task.getId(), "riId");
			delete(riId);
			taskService.completeTask(taskId, "取消");
		}
	}


	/**
	 * 根据审批状态查询禀议报告
	 * 
	 * @param page
	 * @param userId
	 * @param state
	 */
	public void getRingiShoBy(Page<RingiSho> page, Long userId, Short state)
	{
		ringiShoDao.getRingiShoBy(page, userId, state);
	}


	/**
	 * 根据审批状态查询禀议报告
	 * 
	 * @param userId
	 * @param state
	 * @return
	 */
	public List<RingiSho> getRingiShoBy(Long userId, Short state)
	{
		return ringiShoDao.getRingiShoBy(userId, state);
	}


	public void getAllList(Page<RingiSho> page, Long uId)
	{
		this.ringiShoDao.getAllList(page, uId);
	}


	/**
	 * 查询所有完成的禀议书
	 * 
	 * @param page
	 */
	public void getCompleteList(Page<RingiSho> page, Long uId)
	{
		this.ringiShoDao.getCompleteList(page, uId);
	}

}
