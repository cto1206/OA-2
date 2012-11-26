package com.hanbang.oa.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipInputStream;
import javax.annotation.Resource;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.lang.StringUtils;
import org.jbpm.api.ProcessInstance;
import org.jbpm.api.task.Task;
import com.hanbang.core.action.CRUDActionSupport;
import com.hanbang.core.dao.support.Page;
import com.hanbang.core.utils.ActionUtil;
import com.hanbang.core.utils.Struts2Utils;
import com.hanbang.oa.entity.security.Dept;
import com.hanbang.oa.entity.security.Judge;
import com.hanbang.oa.entity.security.ReceiveWipe;
import com.hanbang.oa.entity.security.Uploaded;
import com.hanbang.oa.entity.security.User;
import com.hanbang.oa.entity.security.Wipe;
import com.hanbang.oa.entity.security.WipeItem;
import com.hanbang.oa.entity.security.WipeItemDetail;
import com.hanbang.oa.model.WipeTask;
import com.hanbang.oa.service.JudgeService;
import com.hanbang.oa.service.ReceiveWipeService;
import com.hanbang.oa.service.UploadedService;
import com.hanbang.oa.service.UserService;
import com.hanbang.oa.service.WipeItemDetailService;
import com.hanbang.oa.service.WipeItemService;
import com.hanbang.oa.service.WipeService;




public class WipeAction extends CRUDActionSupport<Wipe>
{

	private Map<String, Object> map = null;

	private String taskId;

	private List<Task> taskList = null;

	private Task task = null;

	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

	private static final long serialVersionUID = 1L;

	private Wipe wipe;

	private List<Dept> deptList;

	private String state;

	@Resource
	private WipeService wipeManager;

	List<ProcessInstance> processList = null;

	private File myFile;

	private String myFileContentType;

	private String myFileFileName;

	private String imageFileName;

	private List<Judge> judgeList;

	// 判断流程是否在流转中，一边查看能否修改。
	String divString = null;

	private String dire = null;

	private List<Wipe> wipeList = null;

	@Resource
	private JudgeService judgeManager;

	@Resource
	private ReceiveWipeService receiveWipeService;

	@Resource
	private WipeItemService wipeItemManager;

	private List<WipeItem> wipeItemList;

	@Resource
	private WipeItemDetailService wipeItemDetailManager;

	private List<WipeItemDetail> wipeItemDetailList;

	private String reApply;

	private String judge;

	private Long wId;

	private String wCode;

	private WipeItem wipeItem;
	@Resource
	private UploadedService uploadedManager;

	private Map<String, Uploaded> flowSigns;

	@Resource
	private UserService userManager;

	private String selDate;

	private User user;

	private String topJudge;

	SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmssSS");

	private String isCom;

	private List<WipeTask> weiTaskList;

	private Long ju1;

	private String compelete;

	private List<ReceiveWipe> receiveWipeList;

	// 已查看，未看，垃圾站标志。
	private Long rId;



	public void setRId(Long id)
	{
		rId = id;
	}



	private String itemString;// 要删除的经费项目编号；

	private String detailString;// 要删除的经费项目详细；



	public List<ReceiveWipe> getReceiveWipeList()
	{
		return receiveWipeList;
	}


	public void setCompelete(String compelete)
	{
		this.compelete = compelete;
	}


	public List<WipeTask> getWeiTaskList()
	{
		return weiTaskList;
	}


	public String getTopJudge()
	{
		return topJudge;
	}


	public void setTopJudge(String topJudge)
	{
		this.topJudge = topJudge;
	}


	public void setUser(User user)
	{
		this.user = user;
	}


	public User getUser()
	{
		return user;
	}


	public String getSelDate()
	{
		return selDate;
	}


	public void setSelDate(String selDate)
	{
		this.selDate = selDate;
	}


	public String getWCode()
	{
		return wCode;
	}


	public void setWCode(String code)
	{
		wCode = code;
	}


	public Long getWId()
	{
		return wId;
	}


	public void setWId(Long id)
	{
		wId = id;
	}


	public String getJudge()
	{
		return judge;
	}


	public List<WipeItem> getWipeItemList()
	{
		return wipeItemList;
	}


	public String getDivString()
	{
		return divString;
	}


	public String getImageFileName()
	{
		return imageFileName;
	}


	public void setImageFileName(String imageFileName)
	{
		this.imageFileName = imageFileName;
	}


	@Override
	public String delete() throws Exception
	{
		if (StringUtils.isNotEmpty(taskId))
		{
			wipeManager.delete(taskId);
		}
		return rejectTasks();
	}


	@Override
	public String get() throws Exception
	{
		return null;
	}


	// 开始发送报销
	public String prepareForSend() throws Exception
	{
		if (super.getKey() != null)
		{
			wipe = wipeManager.get(super.getKey());
		}

		wipeItemList = wipeItemManager.selItemByWid(wipe.getId());
		wipeItemDetailList = new ArrayList<WipeItemDetail>();
		List<WipeItemDetail> wipeItemDetailList2 = new ArrayList<WipeItemDetail>();
		for (WipeItem wipeItem : wipeItemList)
		{
			wipeItemDetailList2 = wipeItemDetailManager.selItemByIid(wipeItem.getId());
			for (WipeItemDetail itemDetail : wipeItemDetailList2)
			{
				wipeItemDetailList.add(itemDetail);
			}
		}
		judgeList = judgeManager.selJudgeByCode(wipe.getId());
		return "sendWipe";
	}


	// 报销传送中
	public String sendWipe() throws Exception
	{
		if (receiveWipeService.findReceiveBy(user.getId(), wipe.getId()).size() == 0)
		{
			SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
			if (wipe == null || wipe.getId() == null)
				return null;

			if (user == null || user.getId() == null)
				return null;

			ReceiveWipe receiveWipe = new ReceiveWipe();
			receiveWipe.setRUser(user);
			receiveWipe.setState((short) 0);
			receiveWipe.setSentTime(f.format(new Date()));
			receiveWipe.setWipe(wipe);
			receiveWipeService.save(receiveWipe);
			state = "1";
			return Struts2Utils.renderText("true");
		}
		else
			return null;
	}


	// 接收报销列表
	public String receiveWipe() throws Exception
	{
		receiveWipeList = receiveWipeService.selByUid(ActionUtil.getCurLoginInfo().getId(), Short.parseShort(state));
		return "receiveWipe";
	}


	// 开始添加报销单的方法
	public String prepareForAdd() throws Exception
	{
		Date date = new Date();
		if (wipe == null)
		{
			wipe = new Wipe();
			wipe.setwCode("JF" + format.format(date));
			wipe.setwUser(ActionUtil.getCurLoginInfo());
			wipe.setwApTime(sf.format(new Date()));
		}
		return FORMVIEW;
	}


	// 跳转到驳回后重新申请界面的方法
	public String reApply() throws Exception
	{
		wipe = wipeManager.get(super.getKey());
		wipeItemList = new ArrayList<WipeItem>();
		wipeItemDetailList = new ArrayList<WipeItemDetail>();
		if (wipe.getWipeItemSet() != null)
		{
			for (WipeItem wipeItem : wipe.getWipeItemSet())
			{
				if (wipeItem.getWipeItemDetial() != null)
				{
					for (WipeItemDetail wipeItemDetail : wipeItem.getWipeItemDetial())
					{
						wipeItemDetailList.add(wipeItemDetail);
					}
				}
				wipeItemList.add(wipeItem);
			}
		}
		wipeItem = new WipeItem();
		wipeItem.setWipe(wipe);
		return "upd";
	}


	// 编辑wipe的方法
	public String prepareForEdit() throws Exception
	{
		isCom = "false";
		wipe = wipeManager.get(super.getKey());
		task = wipeManager.checkUpd(wipe);
		if (task == null)
		{
			divString = "该流程正在流转中或者已经完成，不能修改。。。";
			return "drawImage";
		}
		ju1 = wipe.getJudgeSet().get(0).getUser().getId();
		wipeItemList = new ArrayList<WipeItem>();
		wipeItemDetailList = new ArrayList<WipeItemDetail>();
		if (wipe.getWipeItemSet() != null)
		{
			for (WipeItem wipeItem : wipe.getWipeItemSet())
			{
				if (wipeItem.getWipeItemDetial() != null)
				{
					for (WipeItemDetail wipeItemDetail : wipeItem.getWipeItemDetial())
					{
						wipeItemDetailList.add(wipeItemDetail);
					}
				}
				wipeItemList.add(wipeItem);
			}
		}
		wipeItem = new WipeItem();
		wipeItem.setWipe(wipe);
		return "upd";
	}


	// 保存wipe的方法
	@Override
	public String save() throws Exception
	{
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
		wipeManager.saveWipe(wipe, wipeItemList, wipeItemDetailList);
		return "activityView";
	}


	// 重新申请的方法
	public String myreapply() throws Exception
	{
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
		wipe = wipeManager.myReapply(wipe);

		wipeItem = new WipeItem();
		wipeItem.setWipe(wipe);
		return FORMVIEW;
	}


	// 修改的时候，还必须要撤回流程。
	public String upd() throws Exception
	{
		wipeManager.upd(wipe, isCom, ju1, wipeItemList, wipeItemDetailList, itemString, detailString);
		return "activityView";
	}


	// 保存重新申请表单
	public void saveReapply() throws Exception
	{
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
		wipe = wipeManager.saveWipe(wipe);
		wipeManager.save(wipe);
	}


	// 查看详细内容
	public String view() throws Exception
	{
		if (wId == null)
		{
			map = wipeManager.prepareJudge(taskId);
			// 根据wCode查询禀议详细。
			List<Wipe> wipeList = wipeManager.selWipeByCode((String) map.get("wCode"));
			wipe = wipeList.get(0);

		}
		else
		{
			wipe = wipeManager.get(wId);
		}

		wipeItemList = wipeItemManager.selItemByWid(wipe.getId());
		wipeItemDetailList = new ArrayList<WipeItemDetail>();
		List<WipeItemDetail> wipeItemDetailList2 = new ArrayList<WipeItemDetail>();
		for (WipeItem wipeItem : wipeItemList)
		{
			wipeItemDetailList2 = wipeItemDetailManager.selItemByIid(wipeItem.getId());
			for (WipeItemDetail itemDetail : wipeItemDetailList2)
			{
				wipeItemDetailList.add(itemDetail);
			}
		}

		return "view";
	}


	// 放入回收站
	public String recycle() throws Exception
	{
		if (rId != null)
		{
			ReceiveWipe receiveWipe = receiveWipeService.get(rId);
			receiveWipe.setState((short) 2);
			receiveWipeService.merge(receiveWipe);
			return Struts2Utils.renderJson("true");
		}
		else
			return null;

	}


	// 监控
	public String monitor() throws Exception
	{
		if (rId != null)
		{
			ReceiveWipe receiveWipe = receiveWipeService.get(rId);
			receiveWipe.setState((short) 1);
			receiveWipeService.merge(receiveWipe);
		}

		if (wId == null)
		{
			map = wipeManager.prepareJudge(taskId);
			// 根据wCode查询禀议详细。
			List<Wipe> wipeList = wipeManager.selWipeByCode((String) map.get("wCode"));
			wipe = wipeList.get(0);
		}
		else
		{
			wipe = wipeManager.get(wId);
		}
		wipeItemList = wipeItemManager.selItemByWid(wipe.getId());
		wipeItemDetailList = new ArrayList<WipeItemDetail>();
		List<WipeItemDetail> wipeItemDetailList2 = new ArrayList<WipeItemDetail>();
		for (WipeItem wipeItem : wipeItemList)
		{
			wipeItemDetailList2 = wipeItemDetailManager.selItemByIid(wipeItem.getId());
			for (WipeItemDetail itemDetail : wipeItemDetailList2)
			{
				wipeItemDetailList.add(itemDetail);
			}
		}
		judgeList = judgeManager.selJudgeByCode(wipe.getId());
		return "monitor";
	}


	// 打印
	public String print() throws Exception
	{
		// 根据wCode查询禀议详细。
		List<Wipe> wipeList = wipeManager.selWipeByCode(wCode);
		wipe = wipeList.get(0);
		wipeItemList = wipeItemManager.selItemByWid(wipe.getId());
		wipeItemDetailList = new ArrayList<WipeItemDetail>();
		judgeList = wipe.getJudgeSet();
		List<WipeItemDetail> wipeItemDetailList2 = new ArrayList<WipeItemDetail>();
		for (WipeItem wipeItem : wipeItemList)
		{
			wipeItemDetailList2 = wipeItemDetailManager.selItemByIid(wipeItem.getId());
			for (WipeItemDetail itemDetail : wipeItemDetailList2)
			{
				wipeItemDetailList.add(itemDetail);
			}
		}

		flowSigns = new HashMap<String, Uploaded>();
		User flowMan = null;
		List<Uploaded> signs = null;

		// 一级审查人员签名
		flowMan = wipe.getJudgeSet().get(0).getUser();
		if (flowMan != null && flowMan.getId() != null)
		{
			signs = uploadedManager.findBy(flowMan.getId(), User.class.getSimpleName());
			if (signs != null && !signs.isEmpty())
				flowSigns.put("flowMan1", signs.get(0));
		}
		// 二级决裁人员签名
		flowMan = wipe.getJudgeSet().get(1).getUser();
		if (flowMan != null && flowMan.getId() != null)
		{
			signs = uploadedManager.findBy(flowMan.getId(), User.class.getSimpleName());
			if (signs != null && !signs.isEmpty())
				flowSigns.put("flowMan2", signs.get(0));
		}
		if (wipe.getWType() == 1)
		{
			// 三级人员签名
			flowMan = wipe.getJudgeSet().get(2).getUser();
			if (flowMan != null && flowMan.getId() != null)
			{
				signs = uploadedManager.findBy(flowMan.getId(), User.class.getSimpleName());
				if (signs != null && !signs.isEmpty())
					flowSigns.put("flowManFinance", signs.get(0));
			}
			// 四级决裁人员签名
			flowMan = wipe.getJudgeSet().get(3).getUser();
			if (flowMan != null && flowMan.getId() != null)
			{
				signs = uploadedManager.findBy(flowMan.getId(), User.class.getSimpleName());
				if (signs != null && !signs.isEmpty())
					flowSigns.put("flowMan4", signs.get(0));
			}
			// 董事长决裁签名
			flowMan = wipe.getJudgeSet().get(4).getUser();

			if (flowMan != null && flowMan.getId() != null && wipe.getTopJudge().equals("1"))
			{
				signs = uploadedManager.findBy(flowMan.getId(), User.class.getSimpleName());
				if (signs != null && !signs.isEmpty())
					flowSigns.put("presidentMan", signs.get(0));
			}
		}
		return "print";
	}


	// 查询某个人的待办任务。
	public String weiShenPiList() throws Exception
	{
		// roleName = ActionUtil.getCurLoginInfo().getRole().getRoleName();
		weiTaskList = wipeManager.weiShenPiList();
		return "weiShenPiList";
	}


	// 查询某个人的已办任务(具体到某个人)
	public String yiShenPiList() throws Exception
	{
		wipeList = wipeManager.yiShenPiList();
		return "yiShenPiList";
	}


	// 审核待办任务
	public String confirm() throws Exception
	{
		if (wipe != null && wipe.getId() != null)
		{
			wipe = wipeManager.get(wipe.getId());
			List<Judge> jdList = wipe.getJudgeSet();
			judgeList = judgeManager.selJudgeByCode(wipe.getId());
			if (jdList.size() > judgeList.size())
			{
				Judge jd = jdList.get(judgeList.size());
				jd.setJudgeDate(sf.format(new Date()));
				jd.setUser(ActionUtil.getCurLoginInfo());
				jd.setWipe(wipe);
				jd.setjDirect(dire);
			}
			wipe = wipeManager.confirm(taskId, topJudge, wipe);
		}
		return weiShenPiList();
	}


	// 不批准
	public String dissent() throws Exception
	{
		wipe = wipeManager.get(wipe.getId());
		wipe.setState((short) 3);
		List<Judge> jdList = wipe.getJudgeSet();
		judgeList = judgeManager.selJudgeByCode(wipe.getId());
		if (jdList.size() > judgeList.size())
		{
			Judge jd = jdList.get(judgeList.size());
			jd.setJudgeDate(sf.format(new Date()));
			jd.setUser(ActionUtil.getCurLoginInfo());
			jd.setWipe(wipe);
			jd.setjDirect(dire);
		}
		wipeManager.dissent(taskId);
		return weiShenPiList();
	}


	// 驳回
	public String reject() throws Exception
	{
		wipe = wipeManager.get(wipe.getId());
		wipe.setState((short) 2);
		List<Judge> jdList = wipe.getJudgeSet();
		judgeList = judgeManager.selJudgeByCode(wipe.getId());
		if (jdList.size() > judgeList.size())
		{
			Judge jd = jdList.get(judgeList.size());
			jd.setJudgeDate(sf.format(new Date()));
			jd.setUser(ActionUtil.getCurLoginInfo());
			jd.setWipe(wipe);
			jd.setjDirect(dire);
		}
		wipeManager.reject(taskId);
		return weiShenPiList();
	}


	// 部署流程的方法
	public String deployWithImage() throws FileUploadException, IOException
	{
		ZipInputStream st = new ZipInputStream(new FileInputStream(myFile));
		wipeManager.deployWithImage(st);
		return null;
	}


	public Wipe getWipe()
	{
		return wipe;
	}


	public void setWipe(Wipe wipe)
	{
		this.wipe = wipe;
	}


	public WipeService getWipeManager()
	{
		return wipeManager;
	}


	public void setWipeManager(WipeService wipeManager)
	{
		this.wipeManager = wipeManager;
	}


	// 显示wipe列表的方法(已经完成)
	@Override
	protected void list(Page<Wipe> page) throws Exception
	{
		if ("compelete".equals(compelete))
		{
			wipeManager.getCompleteList(page);
		}
		else
		{
			// 根据权限来分页。
			if (selDate == null)
			{
				if (ActionUtil.getCurLoginInfo().getRole().getRoleName().equals("管理员") || ActionUtil.getCurLoginInfo().getRole().getRoleName().equals("经营监察"))
				{
					wipeManager.getWipeBy(page, null, Short.parseShort(state));
				}
				else
				{
					wipeManager.getWipeBy(page, ActionUtil.getCurLoginInfo().getId(), Short.parseShort(state));
				}
			}
			else
			{
				if (ActionUtil.getCurLoginInfo().getRole().getRoleName().equals("管理员") || ActionUtil.getCurLoginInfo().getRole().getRoleName().equals("经营监察"))
				{
					wipeManager.getWipeBy(page, null, Short.parseShort(state));
				}
				else
				{
					wipeManager.getWipeBy(page, ActionUtil.getCurLoginInfo().getId(), Short.parseShort(state));
				}
			}
		}
	}


	// 驳回任务列表
	public String rejectTasks() throws Exception
	{
		User user = ActionUtil.getCurLoginInfo();
		weiTaskList = wipeManager.getRejectTasks(user.getId());
		return "REJECTTASKVIEW";
	}


	// 进入开始审批的界面的方法
	public String prepareJudge() throws Exception
	{
		map = wipeManager.prepareJudge(taskId);
		List<Wipe> wipeList = wipeManager.selWipeByCode((String) map.get("wCode"));
		wipe = wipeList.get(0);
		task = wipeManager.getWipeByTid(taskId);

		judgeList = judgeManager.selJudgeByCode(wipe.getId());

		wipeItemList = wipeItemManager.selItemByWid(wipe.getId());
		wipeItemDetailList = new ArrayList<WipeItemDetail>();
		List<WipeItemDetail> wipeItemDetailList2 = new ArrayList<WipeItemDetail>();
		for (WipeItem wipeItem : wipeItemList)
		{
			wipeItemDetailList2 = wipeItemDetailManager.selItemByIid(wipeItem.getId());
			for (WipeItemDetail itemDetail : wipeItemDetailList2)
			{
				wipeItemDetailList.add(itemDetail);
			}
		}
		return "judge";
	}


	public List<Dept> getDeptList()
	{
		return deptList;
	}


	public void setJudge(String judge)
	{
		this.judge = judge;
	}


	public Map<String, Object> getMap()
	{
		return map;
	}


	public void setMap(Map<String, Object> map)
	{
		this.map = map;
	}


	public String getTaskId()
	{
		return taskId;
	}


	public void setTaskId(String taskId)
	{
		this.taskId = taskId;
	}


	public List<Task> getTaskList()
	{
		return taskList;
	}


	public void setTaskList(List<Task> taskList)
	{
		this.taskList = taskList;
	}


	public Task getTask()
	{
		return task;
	}


	public void setTask(Task task)
	{
		this.task = task;
	}


	public File getMyFile()
	{
		return myFile;
	}


	public void setMyFile(File myFile)
	{
		this.myFile = myFile;
	}


	public String getMyFileContentType()
	{
		return myFileContentType;
	}


	public void setMyFileContentType(String myFileContentType)
	{
		this.myFileContentType = myFileContentType;
	}


	public String getMyFileFileName()
	{
		return myFileFileName;
	}


	public void setMyFileFileName(String myFileFileName)
	{
		this.myFileFileName = myFileFileName;
	}


	public void setJudgeList(List<Judge> judgeList)
	{
		this.judgeList = judgeList;
	}


	public List<Judge> getJudgeList()
	{
		return judgeList;
	}


	public String getDire()
	{
		return dire;
	}


	public void setDire(String dire)
	{
		this.dire = dire;
	}


	public List<Wipe> getWipeList()
	{
		return wipeList;
	}


	public List<WipeItemDetail> getWipeItemDetailList()
	{
		return wipeItemDetailList;
	}


	public String getReApply()
	{
		return reApply;
	}


	public void setReApply(String reApply)
	{
		this.reApply = reApply;
	}


	public UploadedService getUploadedManager()
	{
		return uploadedManager;
	}


	public void setUploadedManager(UploadedService uploadedManager)
	{
		this.uploadedManager = uploadedManager;
	}


	public Map<String, Uploaded> getFlowSigns()
	{
		return flowSigns;
	}


	public void setFlowSigns(Map<String, Uploaded> flowSigns)
	{
		this.flowSigns = flowSigns;
	}


	public WipeItem getWipeItem()
	{
		return wipeItem;
	}


	public void setWipeItemDetailList(List<WipeItemDetail> wipeItemDetailList)
	{
		this.wipeItemDetailList = wipeItemDetailList;
	}


	public void setWipeItemList(List<WipeItem> wipeItemList)
	{
		this.wipeItemList = wipeItemList;
	}


	public String getIsCom()
	{
		return isCom;
	}


	public void setIsCom(String isCom)
	{
		this.isCom = isCom;
	}


	public Long getJu1()
	{
		return ju1;
	}


	public void setJu1(Long ju1)
	{
		this.ju1 = ju1;
	}


	public void setState(String state)
	{
		this.state = state;
	}


	public void setDetailString(String detailString)
	{
		this.detailString = detailString;
	}


	public void setItemString(String itemString)
	{
		this.itemString = itemString;
	}

}
