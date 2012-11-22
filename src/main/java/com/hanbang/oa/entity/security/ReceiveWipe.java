package com.hanbang.oa.entity.security;

import java.io.Serializable;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import com.hanbang.core.entity.IdEntity;




/**
 * @author Owner 经费报销接收表
 * 
 */
@Entity
@Table(name = "BY_RECEIVEWIPE")
public class ReceiveWipe extends IdEntity implements Serializable
{
	private static final long serialVersionUID = 1L;	

	private Wipe wipe;
	
	private User rUser;
	
	private String sentTime;
	
	private Short state=0;//0未阅，1已经阅。
	
	@Column(name = "R_STATE",nullable=true)
	public Short getState() {
		return state;
	}

	public void setState(Short state) {
		this.state = state;
	}

	// 禀议编号
	// 双向关系
	@ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER, optional = true)
	@JoinColumn(name = "W_ID")
	public Wipe getWipe() {
		return wipe;
	}

	public void setWipe(Wipe wipe) {
		this.wipe = wipe;
	}

	// 接收编号
	// 单向关系
	@ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER, optional = true)
	@JoinColumn(name = "U_CODE")
	public User getRUser() {
		return rUser;
	}

	public void setRUser(User user) {
		rUser = user;
	}
	// 发送日期
	@Column(name = "R_SENTTIME",nullable=true)
	public String getSentTime() {
		return sentTime;
	}

	public void setSentTime(String sentTime) {
		this.sentTime = sentTime;
	}
	

}
