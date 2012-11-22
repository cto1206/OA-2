package com.hanbang.oa.model;

import org.jbpm.api.task.Task;
import com.hanbang.oa.entity.security.Wipe;




public class WipeTask
{

	private Task task;

	private Wipe wipe;



	public Task getTask()
	{
		return task;
	}


	public void setTask(Task task)
	{
		this.task = task;
	}


	public Wipe getWipe()
	{
		return wipe;
	}


	public void setWipe(Wipe wipe)
	{
		this.wipe = wipe;
	}
}
