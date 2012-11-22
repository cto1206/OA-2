package com.hanbang.oa.entity.security;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import com.hanbang.core.entity.IdEntity;




/**
 * 此类描述的是： 禀议编号表
 * 
 * @author: 张敏明
 * @version: 2010-1-6 上午09:31:54
 */

@Entity
@Table(name = "BY_REPORTNO")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE, region = "BY_REPORTNO")
public class ReportNo extends IdEntity implements Serializable
{

	private static final long serialVersionUID = 1L;

	// 禀议书提交的时间
	private String hour;

	// 禀议书提交的顺序
	private Integer alignment;



	@Column(name = "RN_HOUR", length = 4, nullable = false)
	public String getHour()
	{
		return hour;
	}


	public void setHour(String hour)
	{
		this.hour = hour;
	}


	@Column(name = "RN_ALIGNMENT", nullable = false)
	public Integer getAlignment()
	{
		return alignment;
	}


	public void setAlignment(Integer alignment)
	{
		this.alignment = alignment;
	}

}
