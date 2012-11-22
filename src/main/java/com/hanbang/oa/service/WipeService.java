package com.hanbang.oa.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.zip.ZipInputStream;

import javax.annotation.Resource;

import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.lang.StringUtils;
import org.jbpm.api.Execution;
import org.jbpm.api.ExecutionService;
import org.jbpm.api.HistoryService;
import org.jbpm.api.ProcessDefinition;
import org.jbpm.api.ProcessEngine;
import org.jbpm.api.ProcessInstance;
import org.jbpm.api.RepositoryService;
import org.jbpm.api.TaskService;
import org.jbpm.api.history.HistoryProcessInstance;
import org.jbpm.api.task.Task;
import org.jbpm.pvm.internal.env.Environment;
import org.jbpm.pvm.internal.env.EnvironmentFactory;
import org.jbpm.pvm.internal.model.ExecutionImpl;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hanbang.core.dao.support.Page;
import com.hanbang.core.service.EntityService;
import com.hanbang.core.utils.ActionUtil;
import com.hanbang.oa.dao.WipeDao;
import com.hanbang.oa.entity.security.Judge;
import com.hanbang.oa.entity.security.User;
import com.hanbang.oa.entity.security.Wipe;
import com.hanbang.oa.entity.security.WipeItem;
import com.hanbang.oa.entity.security.WipeItemDetail;
import com.hanbang.oa.model.WipeTask;




/**
 * 经费报销项目管理类.
 * 
 * 实现领域对象部门的所有业务管理函数. 演示派生DAO层子类的模式,由注入的RingiShoDao封装数据库访问.
 * 
 * 通过泛型声明继承EntityManager,默认拥有CRUD管理方法. 使用Spring annotation定义事务管理.
 * 
 * @author zx
 */
// Spring Service Bean的标识.
@Service
public class WipeService extends EntityService<Wipe, Long>
{
	@Resource
	private WipeDao wipeDao;

	SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");

	private Map<String, Object> map = null;

	@Resource
	private ExecutionService executionService = null;

	@Resource
	private RepositoryService repositoryService = null;

	@Resource
	private TaskService taskService = null;

	private Execution execution = null;

	private List<Task> taskList = null;

	private Task task = null;

	SimpleDateFormat sf = new SimpleDateFormat("yy-MM-dd");

	List<ProcessInstance> processList = null;

	@Resource
	private HistoryService historyService = null;

	@Resource
	@Qualifier("processEngine")
	private ProcessEngine processEngine = null;

	@Resource
	private JudgeService judgeManager;

	@Resource
	private UserService userManager;

	@Resource
	private WipeItemService wipeItemService;

	@Resource
	private WipeItemDetailService wipeItemDetailService;



	@Override
	protected WipeDao getEntityDao()
	{
		return wipeDao;
	}


	// 根据当前任务号取得禀议详细信息
	@Transactional(readOnly = true)
	public WipeTask getWipeByTask(String taskId)
	{
		if (StringUtils.isEmpty(taskId))
			return null;

		WipeTask wipeTask = new WipeTask();
		wipeTask.setTask(taskService.getTask(taskId));

		String wCode = (String) taskService.getVariable(taskId, "wCode");
		if (wCode != null)
			wipeTask.setWipe(wipeDao.findByProperty("wCode", wCode) == null ? null : wipeDao.findByProperty("wCode", wCode).get(0));
		return wipeTask;
	}


	// 根据当前任务号取得禀议详细信息
	@Transactional(readOnly = true)
	public Task getWipeByTid(String taskId)
	{
		if (StringUtils.isEmpty(taskId))
			return null;

		Task task = taskService.getTask(taskId);

		return task;
	}


	// 禀议撤销
	@Transactional
	public void delete(String taskId)
	{
		Task task = taskService.getTask(taskId);
		Execution execution = executionService.findExecutionById(task.getExecutionId());
		if (execution.getProcessInstance().isActive("填写经费报销"))
		{
			String wCode = (String) taskService.getVariable(taskId, "wCode");
			this.delete(wipeDao.getWipe(wCode));
			taskService.completeTask(taskId, "cancel");
		}
	}


	// 查询所有完成的禀议书
	public void getCompleteList(Page<Wipe> page)
	{
		wipeDao.getCompleteList(page);
	}


	// 查询某个人所写的经费报销
	public Page<Wipe> getMyAll(User curUser, Page<Wipe> page)
	{
		return wipeDao.getMyAll(curUser, page);
	}


	// 查询某个人某天所写的经费报销
	public Page<Wipe> getMyAll(User curUser, Page<Wipe> page, String selDate)
	{
		return wipeDao.getMyAll(curUser, page, selDate);
	}


	// 查询所有某天所写的经费报销
	public Page<Wipe> getMyAll(Page<Wipe> page, String selDate)
	{
		return wipeDao.getMyAll(page, selDate);
	}


	// 根据禀议编号查询禀议详细内容
	public List<Wipe> selWipeByCode(String wCode)
	{
		return wipeDao.findByProperty("wCode", wCode);
	}


	// 根据任务编号查询流程变量
	public Map<String, Object> reApply(String taskId) throws Exception
	{
		Set<String> set = taskService.getVariableNames(taskId);
		map = taskService.getVariables(taskId, set);
		return map;
	}


	// 驳回后重新申请的时候的修改方法
	@Transactional
	public Wipe myReapply(Wipe wipe)
	{
		Map<String, Object> variables = new HashMap<String, Object>();
		Integer type = wipe.getWType();// 0部内，1部外。
		String yiji = String.valueOf(wipe.getJudgeSet().get(0).getUser().getId());
		String erji = String.valueOf(wipe.getJudgeSet().get(1).getUser().getId());
		String sanji = null, siji = null, wuji = null;
		if (type == 1)
		{
			if (wipe.getJudgeSet().get(2).getUser() == null)
			{
				sanji = null;
			}
			else
			{
				sanji = String.valueOf(wipe.getJudgeSet().get(2).getUser().getId());
			}
			if (wipe.getJudgeSet().get(3).getUser() == null)
			{
				siji = null;
			}
			else
			{
				siji = String.valueOf(wipe.getJudgeSet().get(3).getUser().getId());
			}
			if (wipe.getJudgeSet().get(4).getUser() == null)
			{
				wuji = null;
			}
			else
			{
				wuji = String.valueOf(wipe.getJudgeSet().get(4).getUser().getId());
			}
		}
		variables.put("wCode", wipe.getwCode());// 把禀议编号存储在变量中。
		variables.put("deptUser", yiji);
		variables.put("projUser", erji);
		variables.put("sanJiUser", sanji);
		variables.put("manager", siji);
		variables.put("topUser", wuji);
		variables.put("fillUser", String.valueOf(ActionUtil.getCurLoginInfo().getId()));
		executionService.startProcessInstanceByKey("jingfeibaoxiao", variables);
		taskList = taskService.findPersonalTasks(String.valueOf(ActionUtil.getCurLoginInfo().getId()));
		task = taskList.get(taskList.size() - 1);
		taskService.completeTask(task.getId());
		execution = executionService.findExecutionById(task.getExecutionId());
		wipe.getJudgeSet().get(0).setWipe(wipe);
		wipe.getJudgeSet().get(1).setWipe(wipe);

		// 全公司
		if (type == 1)
		{
			if (wipe.getJudgeSet().get(2) == null)
			{
				wipe.getJudgeSet().set(2, null);
			}
			else
			{
				wipe.getJudgeSet().get(2).setWipe(wipe);
			}
			if (wipe.getJudgeSet().get(3) == null)
			{
				wipe.getJudgeSet().set(3, null);
			}
			else
			{
				wipe.getJudgeSet().get(3).setWipe(wipe);
			}
			if (wipe.getJudgeSet().get(4) == null)
			{
				wipe.getJudgeSet().set(4, null);
			}
			else
			{
				wipe.getJudgeSet().get(4).setWipe(wipe);
			}
		}
		// 部内
		if (type == 0)
		{
			wipe.getJudgeSet().set(2, null);
			wipe.getJudgeSet().set(3, null);
			wipe.getJudgeSet().set(4, null);
		}
		wipe.setPId(execution.getProcessInstance().getId());// 获得流程实例ID;

		this.save(wipe);
		return wipe;
	}


	// 添加wipe的方法
	@Transactional
	public Wipe saveWipe(Wipe wipe)
	{
		Map<String, Object> variables = new HashMap<String, Object>();
		Integer type = wipe.getWType();// 0部内，1部外。
		String yiji = String.valueOf(wipe.getJudgeSet().get(0).getUser().getId());
		String erji = String.valueOf(wipe.getJudgeSet().get(1).getUser().getId());
		String sanji = null, siji = null, wuji = null;
		if (type == 1)
		{
			if (wipe.getJudgeSet().get(2).getUser() == null)
			{
				sanji = null;
			}
			else
			{
				sanji = String.valueOf(wipe.getJudgeSet().get(2).getUser().getId());
			}
			if (wipe.getJudgeSet().get(3).getUser() == null)
			{
				siji = null;
			}
			else
			{
				siji = String.valueOf(wipe.getJudgeSet().get(3).getUser().getId());
			}
			if (wipe.getJudgeSet().get(4).getUser() == null)
			{
				wuji = null;
			}
			else
			{
				wuji = String.valueOf(wipe.getJudgeSet().get(4).getUser().getId());
			}
		}
		variables.put("wCode", wipe.getwCode());// 把禀议编号存储在变量中。
		variables.put("deptUser", yiji);
		variables.put("projUser", erji);
		variables.put("sanJiUser", sanji);
		variables.put("manager", siji);
		variables.put("topUser", wuji);
		variables.put("fillUser", String.valueOf(ActionUtil.getCurLoginInfo().getId()));
		executionService.startProcessInstanceByKey("jingfeibaoxiao", variables);
		taskList = taskService.findPersonalTasks(String.valueOf(ActionUtil.getCurLoginInfo().getId()));
		task = taskList.get(taskList.size() - 1);
		taskService.completeTask(task.getId());
		execution = executionService.findExecutionById(task.getExecutionId());
		wipe.getJudgeSet().get(0).setWipe(wipe);
		wipe.getJudgeSet().get(1).setWipe(wipe);

		// 全公司
		if (type == 1)
		{
			if (wipe.getJudgeSet().get(2) == null)
			{
				wipe.getJudgeSet().set(2, null);
			}
			else
			{
				wipe.getJudgeSet().get(2).setWipe(wipe);
			}
			if (wipe.getJudgeSet().get(3) == null)
			{
				wipe.getJudgeSet().set(3, null);
			}
			else
			{
				wipe.getJudgeSet().get(3).setWipe(wipe);
			}
			if (wipe.getJudgeSet().get(4) == null)
			{
				wipe.getJudgeSet().set(4, null);
			}
			else
			{
				wipe.getJudgeSet().get(4).setWipe(wipe);
			}
		}
		// 部内
		if (type == 0)
		{
			wipe.getJudgeSet().set(2, null);
			wipe.getJudgeSet().set(3, null);
			wipe.getJudgeSet().set(4, null);
		}
		wipe.setPId(execution.getProcessInstance().getId());// 获得流程实例ID;

		this.save(wipe);

		return wipe;
	}


	// 添加wipe的方法
	@Transactional
	public Wipe saveWipe(Wipe wipe, List<WipeItem> itemList, List<WipeItemDetail> detailList)
	{
		Map<String, Object> variables = new HashMap<String, Object>();
		Integer type = wipe.getWType();// 0部内，1部外。
		String yiji = String.valueOf(wipe.getJudgeSet().get(0).getUser().getId());
		String erji = String.valueOf(wipe.getJudgeSet().get(1).getUser().getId());
		String sanji = null, siji = null, wuji = null;
		if (type == 1)
		{
			if (wipe.getJudgeSet().get(2).getUser() == null)
			{
				sanji = null;
			}
			else
			{
				sanji = String.valueOf(wipe.getJudgeSet().get(2).getUser().getId());
			}
			if (wipe.getJudgeSet().get(3).getUser() == null)
			{
				siji = null;
			}
			else
			{
				siji = String.valueOf(wipe.getJudgeSet().get(3).getUser().getId());
			}
			if (wipe.getJudgeSet().get(4).getUser() == null)
			{
				wuji = null;
			}
			else
			{
				wuji = String.valueOf(wipe.getJudgeSet().get(4).getUser().getId());
			}
		}
		variables.put("wCode", wipe.getwCode());// 把禀议编号存储在变量中。
		variables.put("deptUser", yiji);
		variables.put("projUser", erji);
		variables.put("sanJiUser", sanji);
		variables.put("manager", siji);
		variables.put("topUser", wuji);
		variables.put("fillUser", String.valueOf(ActionUtil.getCurLoginInfo().getId()));
		executionService.startProcessInstanceByKey("jingfeibaoxiao", variables);
		taskList = taskService.findPersonalTasks(String.valueOf(ActionUtil.getCurLoginInfo().getId()));
		task = taskList.get(taskList.size() - 1);
		taskService.completeTask(task.getId());
		execution = executionService.findExecutionById(task.getExecutionId());
		wipe.getJudgeSet().get(0).setWipe(wipe);
		wipe.getJudgeSet().get(1).setWipe(wipe);

		// 全公司
		if (type == 1)
		{
			if (wipe.getJudgeSet().get(2) == null)
			{
				wipe.getJudgeSet().set(2, null);
			}
			else
			{
				wipe.getJudgeSet().get(2).setWipe(wipe);
			}
			if (wipe.getJudgeSet().get(3) == null)
			{
				wipe.getJudgeSet().set(3, null);
			}
			else
			{
				wipe.getJudgeSet().get(3).setWipe(wipe);
			}
			if (wipe.getJudgeSet().get(4) == null)
			{
				wipe.getJudgeSet().set(4, null);
			}
			else
			{
				wipe.getJudgeSet().get(4).setWipe(wipe);
			}
		}

		wipe.setPId(execution.getProcessInstance().getId());// 获得流程实例ID;

		this.save(wipe);
		if (itemList != null && itemList.size() != 0)
		{
			for (WipeItem wipeItem : itemList)
			{
				wipeItem.setWipe(wipe);
				if (detailList != null && detailList.size() != 0)
				{
					for (WipeItemDetail wipeItemDetail : detailList)
					{
						if (wipeItem.getiItem().equals(wipeItemDetail.getWipeItem().getiItem()))
						{
							wipeItemDetail.setWipeItem(wipeItem);
							wipeItemDetailService.save(wipeItemDetail);
						}
					}
				}

				wipeItemService.save(wipeItem);
			}
		}
		return wipe;
	}


	// 监测流程是否可以修改（如果相同的人批两次可能就会出问题。还没测试两个人是否会有问题。）
	public Task checkUpd(Wipe wipe) throws Exception
	{
		List<Judge> judgeList = judgeManager.selJudgeByCode(wipe.getId());
		Integer size = 0;
		if (judgeList != null)
		{
			size = judgeList.size();
		}
		this.task = null;
		taskList = taskService.findPersonalTasks(String.valueOf(wipe.getJudgeSet().get(0).getUser().getId()));
		if (taskList != null && !taskList.isEmpty())
		{
			String wCode = null;
			for (Task task : taskList)
			{
				wCode = (String) taskService.getVariable(task.getId(), "wCode");
				if (wCode != null)
				{
					if (wCode.equals(wipe.getwCode()) && size < 1)// 还需要一个条件判断，审批人数必须小于=0；
					{
						this.task = task;
					}
				}
			}
		}
		return this.task;
	}


	// 撤回流程的界面
	public Task updWipe(Wipe wipe, Long ju1) throws Exception
	{
		taskList = taskService.findPersonalTasks(String.valueOf(ju1));
		if (taskList != null && !taskList.isEmpty())
		{
			String wCode = null;
			for (Task task : taskList)
			{
				wCode = (String) taskService.getVariable(task.getId(), "wCode");
				if (wCode != null)
				{
					if (wCode.equals(wipe.getwCode()))
					{
						this.task = task;
						taskService.completeTask(task.getId(), "To主管驳回");
					}
				}

			}

		}
		return this.task;
	}


	// 撤回流程的操作
	@Transactional
	public void upd(Wipe wipe, String isCom, Long ju1, List<WipeItem> itemList, List<WipeItemDetail> detailList, String itemString, String detailString) throws Exception
	{
		judgeManager.del(wipe.getId());
		wipe.setwUser(userManager.get(wipe.getwUser().getId()));
		List<Judge> judgeSet = wipe.getJudgeSet();
		for (Judge judge : judgeSet)
		{
			if (judge.getUser().getId() == null)
				judge.setUser(null);
			else
				judge.setUser(userManager.get(judge.getUser().getId()));
		}
		wipe.setJudgeSet(judgeSet);
		wipe.setState((short) 0);

		if ("false".equals(isCom) && ju1 != null)
			updWipe(wipe, ju1);

		Map<String, Object> variables = new HashMap<String, Object>();
		Integer type = wipe.getWType();// 0部内，1部外。
		String yiji = String.valueOf(wipe.getJudgeSet().get(0).getUser().getId());
		String erji = String.valueOf(wipe.getJudgeSet().get(1).getUser().getId());
		String sanji = null, siji = null, wuji = null;
		if (type == 1)
		{
			if (wipe.getJudgeSet().get(2).getUser() == null)
			{
				sanji = null;
			}
			else
			{
				sanji = String.valueOf(wipe.getJudgeSet().get(2).getUser().getId());
			}
			if (wipe.getJudgeSet().get(3).getUser() == null)
			{
				siji = null;
			}
			else
			{
				siji = String.valueOf(wipe.getJudgeSet().get(3).getUser().getId());
			}
			if (wipe.getJudgeSet().get(4).getUser() == null)
			{
				wuji = null;
			}
			else
			{
				wuji = String.valueOf(wipe.getJudgeSet().get(4).getUser().getId());
			}
		}
		variables.put("wCode", wipe.getwCode());// 把禀议编号存储在变量中。
		variables.put("deptUser", yiji);
		variables.put("projUser", erji);
		variables.put("sanJiUser", sanji);
		variables.put("manager", siji);
		variables.put("topUser", wuji);
		variables.put("fillUser", String.valueOf(ActionUtil.getCurLoginInfo().getId()));

		wipe.getJudgeSet().get(0).setWipe(wipe);
		wipe.getJudgeSet().get(1).setWipe(wipe);

		// 全公司
		if (type == 1)
		{
			if (wipe.getJudgeSet().get(2) == null)
			{
				wipe.getJudgeSet().set(2, null);
			}
			else
			{
				wipe.getJudgeSet().get(2).setWipe(wipe);
			}
			if (wipe.getJudgeSet().get(3) == null)
			{
				wipe.getJudgeSet().set(3, null);
			}
			else
			{
				wipe.getJudgeSet().get(3).setWipe(wipe);
			}
			if (wipe.getJudgeSet().get(4) == null)
			{
				wipe.getJudgeSet().set(4, null);
			}
			else
			{
				wipe.getJudgeSet().get(4).setWipe(wipe);
			}
		}

		taskList = taskService.findPersonalTasks(String.valueOf(wipe.getwUser().getId()));
		if (taskList != null && !taskList.isEmpty())
		{
			String wCode = null;
			for (Task task : taskList)
			{
				wCode = (String) taskService.getVariable(task.getId(), "wCode");
				if (wCode != null)
				{
					if (wCode.equals(wipe.getwCode()))
					{
						taskService.setVariables(task.getId(), variables);
						taskService.completeTask(task.getId());
					}
				}
			}

		}
		wipeDao.mery(wipe);

		String[] itemIds = itemString.split(",");
		String[] detailIds = detailString.split(",");

		for (int d = 0; d < detailIds.length; d++)
		{
			if (!detailIds[d].equals(""))
				wipeItemDetailService.delete(Long.parseLong(detailIds[d]));
		}
		for (int i = 0; i < itemIds.length; i++)
		{
			if (!itemIds[i].equals(""))
				wipeItemService.delete(Long.parseLong(itemIds[i]));
		}
		if (itemList != null && itemList.size() != 0)
		{
			for (WipeItem wipeItem : itemList)
			{
				wipeItem.setWipe(wipe);// 这里有错误，为什么为空。
				if (wipeItem.getId() == null || "".equals(wipeItem.getId()))
					wipeItemService.save(wipeItem);
				else
					wipeItemService.merge(wipeItem);
				if (detailList != null && detailList.size() != 0)
				{
					for (WipeItemDetail wipeItemDetail : detailList)
					{
						if (wipeItem.getiItem().equals(wipeItemDetail.getWipeItem().getiItem()))
						{
							wipeItemDetail.setWipeItem(wipeItem);
							if (wipeItemDetail.getId() == null || "".equals(wipeItemDetail.getId()))
								wipeItemDetailService.save(wipeItemDetail);
							else
								wipeItemDetailService.merge(wipeItemDetail);
						}
					}
				}
			}
		}

	}


	// 查看详细内容
	public Map<String, Object> view(String taskId, String piId)
	{
		if (taskId == null || "".equals(taskId))
		{
			map = executionService.getVariables(piId, executionService.getVariableNames(piId));
		}
		else
		{
			Set<String> set = taskService.getVariableNames(taskId);
			map = taskService.getVariables(taskId, set);
		}
		return map;
	}


	// 查询某个人的待办任务。
	public List<WipeTask> weiShenPiList() throws Exception
	{
		taskList = taskService.findPersonalTasks(String.valueOf(ActionUtil.getCurLoginInfo().getId()));
		List<WipeTask> list = null;
		if (taskList != null && !taskList.isEmpty())
		{
			String wCode = null;
			list = new ArrayList<WipeTask>(taskList.size());
			WipeTask wipeTask = null;
			for (Task task : taskList)
			{

				if (task.getName().equalsIgnoreCase("填写经费报销"))
					continue;

				wipeTask = new WipeTask();
				wipeTask.setTask(task);
				wCode = (String) taskService.getVariable(task.getId(), "wCode");
				if (wCode != null)
				{
					if (wipeDao.getWipe(wCode) != null)
					{
						wipeTask.setWipe(wipeDao.getWipe(wCode));
						list.add(wipeTask);
					}
				}
			}
		}
		return list;
	}


	// 查询某个人的已办任务(具体到某个人)
	public List<Wipe> yiShenPiList() throws Exception
	{
		List<Wipe> wipeList = null;
		if (ActionUtil.getCurLoginInfo() != null && ActionUtil.getCurLoginInfo().getId() != null)
			wipeList = judgeManager.findWipeByUser(ActionUtil.getCurLoginInfo().getId());// 当前登录编号。
		return wipeList;
	}


	// 审核待办任务
	@Transactional
	public Wipe confirm(String taskId, String topJudge, Wipe wipe)
	{

		task = taskService.getTask(taskId);
		execution = executionService.findExecutionById(task.getExecutionId());
		if (execution.getProcessInstance().isActive("部门主管审批"))
		{// 部门主管审批
			taskService.completeTask(taskId, "To");// To二级决裁
		}
		else if (execution.getProcessInstance().isActive("项目经理审批"))
		{// 项目经理审批
			String variable = (String) taskService.getVariable(taskId, "sanJiUser");
			if (variable == null || "".equals(variable))
			{
				taskService.completeTask(taskId, "To项目经理不批准");
				wipe.setState((short) 1);
			}
			else
			{
				taskService.completeTask(taskId, "To三级合议");
			}
		}
		else if (execution.getProcessInstance().isActive("三级合议"))
		{// 总经理审批的过程
			taskService.completeTask(taskId, "To四级合议");
		}
		else if (execution.getProcessInstance().isActive("四级合议"))
		{// 四级议论
			if (topJudge != null)
			{
//				if (topJudge.equals("1"))
//				{
					Map<String, Object> variables = new HashMap<String, Object>();
					variables.put("topUser", topJudge);
					taskService.setVariables(taskId, variables);
					taskService.completeTask(taskId, "To最终决裁");// 这里还要根据经理是否需要老板决裁。
					wipe.setTopJudge(topJudge);
					wipe.setState((short) 1);
//				}
//				else if (topJudge.equals("0"))
//				{
//					wipe.setState((short) 1);
//					taskService.completeTask(taskId, "To四级不批准");
//				}
			}
			else
				taskService.completeTask(taskId, "To最终决裁");
		}
		else if (execution.getProcessInstance().isActive("最终决裁"))
		{
			wipe.setState((short) 1);
			// 五级审批
			taskService.completeTask(taskId, "To流程结束");
		}
		else
		{
			taskService.completeTask(taskId);
		}

		this.save(wipe);
		return wipe;
	}


	// 不批准
	public void dissent(String taskId)
	{
		task = taskService.getTask(taskId);
		execution = executionService.findExecutionById(task.getExecutionId());

		if (execution.getProcessInstance().isActive("部门主管审批"))
		{// 部门主管不批准
			taskService.completeTask(taskId, "To主管不批准");
		}
		else if (execution.getProcessInstance().isActive("项目经理审批"))
		{// 项目经理不批准
			taskService.completeTask(taskId, "To项目经理不批准");
		}
		else if (execution.getProcessInstance().isActive("三级合议"))
		{// 总经理审批的过程
			taskService.completeTask(taskId, "To三级不批准");
		}
		else if (execution.getProcessInstance().isActive("四级合议"))
		{// 四级议论
			taskService.completeTask(taskId, "To四级不批准");
		}
		else if (execution.getProcessInstance().isActive("最终决裁"))
		{ // 五级审批
			taskService.completeTask(taskId, "To最终驳回");
		}
		else
		{
			taskService.completeTask(taskId);
		}
	}


	// 驳回
	public void reject(String taskId)
	{
		task = taskService.getTask(taskId);
		Set<String> set = taskService.getVariableNames(taskId);
		map = taskService.getVariables(taskId, set);
		map.put("reject", task.getAssignee());// 驳回人
		taskService.setVariables(task.getId(), map);
		execution = executionService.findExecutionById(task.getExecutionId());
		if (execution.getProcessInstance().isActive("部门主管审批"))
		{// 部门主管不批准
			taskService.completeTask(taskId, "To主管驳回");
		}
		else if (execution.getProcessInstance().isActive("项目经理审批"))
		{// 项目经理不批准
			taskService.completeTask(taskId, "To项目经理驳回");
		}
		else if (execution.getProcessInstance().isActive("三级合议"))
		{// 总经理不批准的过程
			taskService.completeTask(taskId, "To三级驳回");
		}
		else if (execution.getProcessInstance().isActive("四级合议"))
		{// 四级议论
			taskService.completeTask(taskId, "To四级驳回");
		}
		else if (execution.getProcessInstance().isActive("最终决裁"))
		{ // 五级审批
			taskService.completeTask(taskId, "To最终驳回");
		}
		else
		{
			taskService.completeTask(taskId);
		}
	}


	// 根据经费状态查询经费报告
	public void getWipeBy(Page<Wipe> page, Long userId, Short state)
	{
		wipeDao.getWipeBy(page, userId, state);
	}


	// 根据当前用户取得驳回报销列表
	@Transactional(readOnly = true)
	public List<WipeTask> getRejectTasks(Long userId)
	{
		taskList = taskService.findPersonalTasks(String.valueOf(ActionUtil.getCurLoginInfo().getId()));
		List<WipeTask> list = null;
		if (taskList != null && !taskList.isEmpty())
		{
			String wCode = null;
			list = new ArrayList<WipeTask>(taskList.size());
			WipeTask wipeTask = null;
			for (Task task : taskList)
			{
				if (task.getName().equalsIgnoreCase("填写经费报销"))
				{
					wipeTask = new WipeTask();
					wipeTask.setTask(task);
					wCode = (String) taskService.getVariable(task.getId(), "wCode");
					if (wCode != null)
					{
						wipeTask.setWipe(wipeDao.getWipe(wCode));
						list.add(wipeTask);
					}
				}
			}
		}
		return list;
	}


	// 根据流程实例ID获得流程定义。
	public ProcessDefinition getProcessDefinitionByProcessInstanceId(String processInstanceId)
	{
		EnvironmentFactory environmentFactory = (EnvironmentFactory) processEngine;
		Environment environment = environmentFactory.openEnvironment();
		try
		{
			ProcessInstance pi = executionService.findProcessInstanceById(processInstanceId);
			if (pi != null)
			{
				return ((ExecutionImpl) pi).getProcessDefinition();
			}
			else
			{
				HistoryProcessInstance hpi = this.historyService.createHistoryProcessInstanceQuery().processInstanceId(processInstanceId).uniqueResult();
				ProcessDefinition pd = this.repositoryService.createProcessDefinitionQuery().processDefinitionId(hpi.getProcessDefinitionId()).uniqueResult();
				return pd;
			}
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
		}
		finally
		{
			environment.close();
		}
		return null;
	}


	public void deployWithImage(ZipInputStream myFile) throws FileUploadException, IOException
	{
		repositoryService.createDeployment().addResourcesFromZipInputStream(myFile).deploy();
	}


	// 进入开始审批的界面
	public Map<String, Object> prepareJudge(String taskId)
	{
		Set<String> set = taskService.getVariableNames(taskId);
		map = taskService.getVariables(taskId, set);
		return map;
	}
}
