package com.hanbang.core.action;

import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.ecside.table.limit.Limit;
import org.ecside.table.limit.Sort;
import org.ecside.util.RequestUtils;
import com.hanbang.core.dao.support.Page;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;




/**
 * 通用CRUDActionSupport的分页类
 * 
 * @author zmm
 * @create 2009-12-16
 * 
 * @param <T>
 */
public abstract class CRUDActionSupport<T> extends ActionSupport implements Preparable,CRUDAction
{

	// 主键
	private Long key;

	private Integer totalRows;

	private Page<T> page = new Page<T>();



	public Integer getTotalRows()
	{
		return totalRows;
	}


	public Page<T> getPage()
	{
		return page;
	}


	public void prepare() throws Exception
	{
	}


	/**
	 * 默认返回增加页面方法
	 * 
	 * @return
	 * @throws Exception
	 */
	public String view() throws Exception
	{
		return FORMVIEW;
	}


	/**
	 * 保存方法
	 * 
	 * @return
	 * @throws Exception
	 */
	public abstract String save() throws Exception;


	/**
	 * 删除方法
	 * 
	 * @return
	 * @throws Exception
	 */
	public abstract String delete() throws Exception;


	/**
	 * 根据主键查询方法
	 * 
	 * @return
	 * @throws Exception
	 */
	public abstract String get() throws Exception;


	/**
	 * 分页查询实现
	 * 
	 * @return
	 * @throws Exception
	 */
	protected abstract void list(Page<T> p) throws Exception;


	/**
	 * 通用分页查询方法
	 * 
	 * @return
	 * @throws Exception
	 */
	public String list() throws Exception
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		Limit limit = RequestUtils.getLimit(request);
		int pageSize = 20;// 默认每页显示数量
		int pageNo = 1;// 初始化页码，如果获取参数失败就是第一页了

		String ec_crd = request.getParameter("ec_crd");
		String ec_p = request.getParameter("ec_p");
		if (StringUtils.isNumeric(ec_crd))
			pageSize = Integer.parseInt(ec_crd);
		if (StringUtils.isNumeric(ec_p))
			pageNo = Integer.parseInt(ec_p);

		Sort sort = limit.getSort();
		if (sort != null && StringUtils.isNotEmpty(sort.getSortOrder()) && StringUtils.isNotEmpty(sort.getProperty()))
		{
			page.setOrder(sort.getSortOrder());
			page.setOrderBy(sort.getProperty());
		}
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		list(page);
		limit.setRowAttributes((int) page.getTotalCount(), pageNo);
		totalRows = page.getTotalCount();
		return LISTVIEW;
	}


	public Long getKey()
	{
		return key;
	}


	public void setKey(Long key)
	{
		this.key = key;
	}
}
