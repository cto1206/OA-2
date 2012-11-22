package com.hanbang.oa.entity.security;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import com.hanbang.core.entity.IdEntity;




/**
 * 此类描述的是：禀议报告接收列表
 * 
 * @author: 张敏明
 * @version: 2010-3-9 上午10:27:07
 */

@Entity
@Table(name = "BY_RECEIVEREPORT")
public class ReceiveReport extends IdEntity implements Serializable
{

	private static final long serialVersionUID = 1L;

	// 禀议报告
	private RingiSho ringiSho;

	// 接收人员
	private User rUser;

	// 发送人员
	private User sUser;

	// 接收日期
	private Date date;

	// 阅读状态 0:未阅，1:已阅
	private Short state;



	@ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER, optional = true)
	@JoinColumn(name = "BR_RID", nullable = true)
	public RingiSho getRingiSho()
	{
		return ringiSho;
	}


	public void setRingiSho(RingiSho ringiSho)
	{
		this.ringiSho = ringiSho;
	}


	@ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.REFRESH })
	@JoinColumn(name = "BR_RUID", nullable = true, updatable = true)
	public User getRUser()
	{
		return rUser;
	}


	public void setRUser(User user)
	{
		rUser = user;
	}


	@ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.REFRESH })
	@JoinColumn(name = "BR_SUID", nullable = true, updatable = true)
	public User getSUser()
	{
		return sUser;
	}


	public void setSUser(User user)
	{
		sUser = user;
	}


	@Column(name = "BR_DATE", nullable = false, updatable = false)
	public Date getDate()
	{
		return date;
	}


	public void setDate(Date date)
	{
		this.date = date;
	}


	@Column(name = "BR_STATE", nullable = false)
	public Short getState()
	{
		return state;
	}


	public void setState(Short state)
	{
		this.state = state;
	}

}
