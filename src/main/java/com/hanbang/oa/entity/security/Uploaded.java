package com.hanbang.oa.entity.security;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import com.hanbang.core.entity.IdEntity;




/**
 * 附件上传表
 * 
 * @author zmm
 * 
 */
@Entity
@Table(name = "BY_UPLOADED")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE, region = "BY_UPLOADED")
public class Uploaded extends IdEntity implements Serializable
{
	private static final long serialVersionUID = 1L;

	// 上传表名
	private String tab;

	// 上传表主键
	private Long tabId;

	// 上传路径
	private String path;

	// 上传名称
	private String name;

	// 真实附件名
	private String rName;



	@Column(name = "UP_TAB", length = 20, nullable = false)
	public String getTab()
	{
		return tab;
	}


	public void setTab(String tab)
	{
		this.tab = tab;
	}


	@Column(name = "UP_TABID", nullable = false)
	public Long getTabId()
	{
		return tabId;
	}


	public void setTabId(Long tabId)
	{
		this.tabId = tabId;
	}


	@Column(name = "UP_PATH", length = 100, nullable = false)
	public String getPath()
	{
		return path;
	}


	public void setPath(String path)
	{
		this.path = path;
	}


	@Column(name = "UP_NAME", length = 50, nullable = false)
	public String getName()
	{
		return name;
	}


	public void setName(String name)
	{
		this.name = name;
	}


	@Column(name = "UP_RNAME", length = 50, nullable = false)
	public String getRName()
	{
		return rName;
	}


	public void setRName(String name)
	{
		rName = name;
	}

}
