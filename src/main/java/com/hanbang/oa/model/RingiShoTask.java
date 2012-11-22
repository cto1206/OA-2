package com.hanbang.oa.model;

import org.jbpm.api.task.Task;

import com.hanbang.oa.entity.security.RingiSho;




/**
 * 禀议任务列表模型
 * 
 * @author zmm
 * 
 */
public class RingiShoTask
{

	// 任务号
	private Task task;

	// 禀议申请书
	private RingiSho ringiSho;



	public Task getTask()
	{
		return task;
	}


	public void setTask(Task task)
	{
		this.task = task;
	}


	public RingiSho getRingiSho()
	{
		return ringiSho;
	}


	public void setRingiSho(RingiSho ringiSho)
	{
		this.ringiSho = ringiSho;
	}

}
