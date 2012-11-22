package com.hanbang.oa.action;

import java.util.List;
import javax.annotation.Resource;
import org.jbpm.api.ProcessDefinition;

import com.hanbang.core.action.BaseAction;
import com.hanbang.oa.service.FlowService;




/**
 * 流程版本管理
 * 
 * @author zmm
 * 
 */
public class JbpmAction extends BaseAction
{

	private static final long serialVersionUID = 1L;

	private String xml;

	private List<ProcessDefinition> pdList;

	@Resource
	private FlowService flowService;



	/**
	 * 发布流程
	 * 
	 * @return
	 * @throws Exception
	 */
	public String deploy() throws Exception
	{
		flowService.deploy(xml);
		return RELOADVIEW;
	}


	/**
	 * 删除流程
	 * 
	 * @return
	 * @throws Exception
	 */
	public String remove() throws Exception
	{
		if (getKey() != null)
		{
			flowService.delete(getKey().toString());
		}
		return RELOADVIEW;
	}


	public String prepare()
	{

		return FORMVIEW;
	}


	/**
	 * 查询流程列表
	 * 
	 * @return
	 */
	public String list()
	{
		pdList = flowService.pdList();
		return LISTVIEW;
	}


	public void setXml(String xml)
	{
		this.xml = xml;
	}


	public List<ProcessDefinition> getPdList()
	{
		return pdList;
	}
}
