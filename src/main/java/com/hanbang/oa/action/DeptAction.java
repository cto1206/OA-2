package com.hanbang.oa.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.hanbang.core.action.CRUDActionSupport;
import com.hanbang.core.dao.support.Page;
import com.hanbang.core.utils.Struts2Utils;
import com.hanbang.oa.entity.security.Dept;
import com.hanbang.oa.service.DeptService;




/**
 * 此类描述的是： 部门信息控制器
 * 
 * @author: 张敏明
 * @version: 2010-1-7 下午01:30:08
 */

public class DeptAction extends CRUDActionSupport<Dept>
{
	private static final long serialVersionUID = 1L;

	private Dept dept;

	private Dept parentDept;

	private List<Dept> deptList;

	@Resource
	private DeptService deptService;



	@Override
	public String list()
	{
		deptList = deptService.findAll();
		return LISTVIEW;
	}


	@Override
	public String delete()
	{
		Map<Object, Object> msg = new HashMap<Object, Object>();
		try
		{
			deptService.delete(getKey());
			msg.put("del", true);
		}
		catch (Exception ex)
		{
			msg.put("error", ex.getMessage());
		}
		return Struts2Utils.renderJson(msg);
	}


	@Override
	public String get() throws Exception
	{
		return null;
	}


	@Override
	public String save() throws Exception
	{
		deptService.saveOrUpdate(dept);
		return Struts2Utils.renderHtml("<script type=\"text/javascript\">window.alert(\"保存成功\");parent.parent.location.reload();</script>");
	}


	public String prepareForAdd() throws Exception
	{
		if (dept != null && dept.getParent() > 0)
		{
			parentDept = deptService.get(dept.getParent());
		}
		return FORMVIEW;
	}


	public String prepareForEdit() throws Exception
	{
		dept = deptService.get(getKey());
		return FORMVIEW;
	}


	public Dept getDept()
	{
		return dept;
	}


	public void setDept(Dept dept)
	{
		this.dept = dept;
	}


	public Dept getParentDept()
	{
		return parentDept;
	}


	public List<Dept> getDeptList()
	{
		return deptList;
	}


	@Override
	protected void list(Page<Dept> p) throws Exception
	{

	}

}
