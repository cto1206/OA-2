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
 * @author Owner 决裁表
 * 
 */
@Entity
@Table(name = "BY_Judge")
public class Judge extends IdEntity implements Serializable{


	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// 经费报销表
	private Wipe wipe;

	// 双向关系
	@ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER, optional = true)
	@JoinColumn(name = "W_ID")
	public Wipe getWipe() {
		return wipe;
	}

	public void setWipe(Wipe wipe) {
		this.wipe = wipe;
	}
    //决裁时间
	private String judgeDate;
	// 决裁人员编号
	private User user;
	// 指示事项
	private String jDirect;

	// 单向关系
	@ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER, optional = true)
	@JoinColumn(name = "U_CODE")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Column(name = "J_DIRECT",nullable=true)
	public String getjDirect() {
		return jDirect;
	}

	public void setjDirect(String jDirect) {
		this.jDirect = jDirect;
	}
	@Column(name = "J_JUDGEDATE",nullable=true)
	public String getJudgeDate() {
		return judgeDate;
	}

	public void setJudgeDate(String judgeDate) {
		this.judgeDate = judgeDate;
	}
}
