package com.hanbang.oa.service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.lang.StringUtils;
import org.jbpm.api.ProcessDefinition;
import org.jbpm.api.ProcessDefinitionQuery;
import org.jbpm.api.RepositoryService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;




/**
 * 流程管理
 * 
 * @author zmm
 * 
 */
@Service
@Transactional
public class FlowService
{

	@Resource
	private RepositoryService repositoryService;



	/**
	 * 查询流程发布列表
	 * 
	 * @return
	 */
	public List<ProcessDefinition> pdList()
	{
		List<ProcessDefinition> processDefinitions = repositoryService.createProcessDefinitionQuery().orderAsc(ProcessDefinitionQuery.PROPERTY_NAME).list();
		Map<String, ProcessDefinition> map = new LinkedHashMap<String, ProcessDefinition>();
		for (ProcessDefinition pd : processDefinitions)
		{
			String key = pd.getKey();
			ProcessDefinition definition = map.get(key);
			if ((definition == null) || (definition.getVersion() < pd.getVersion()))
			{
				map.put(key, pd);
			}
		}
		return new ArrayList<ProcessDefinition>(map.values());
	}


	/**
	 * 发布流程
	 * 
	 * @param xml
	 */
	public void deploy(String xml)
	{
		if (StringUtils.isNotEmpty(xml))
		{
			repositoryService.createDeployment().addResourceFromString("process.jpdl.xml", xml).deploy();
		}
	}


	/**
	 * 根据流程主键删除流程
	 * 
	 * @param key
	 */
	public void delete(String key)
	{
		if (StringUtils.isNotEmpty(key))
		{
			repositoryService.deleteDeploymentCascade(key);
		}
	}
}
