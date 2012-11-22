package com.hanbang.oa.entity.security;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import com.hanbang.core.entity.IdEntity;




/**
 * @author Owner 经费报销表
 * 
 */
@Entity
@Table(name = "BY_WIPE")
public class Wipe extends IdEntity implements Serializable
{

	private static final long serialVersionUID = 1L;
	
	// 禀议编号
	private String wCode;
	
	// 报销担当编号
	private User wUser;
	
	// 填写日期
	private String wApTime;
	
	// 类别（部内或者公司：部内：0；部外：1）
	private Integer wType;
	
	// 合计金额
	private BigDecimal wTotal ;
	
	// 备注说明
	private String wRemark;

	// 经费项目
	private Set<WipeItem> wipeItemSet;

	// 电话
	private String tel;
	
	// 禀议标题
	private Short title;
	
	// 是否需要董事长审批
	private String topJudge = "0";// 1需要，0不需要。
	
	// 经费报销状态状态,0:审批中,1:已结束,2:已驳回,3:不批准
	private Short state=0;

	 
	public String getTopJudge()
	{
		return topJudge;
	}

	public void setTopJudge(String topJudge)
	{
		this.topJudge = topJudge;
	}

	@Column(name = "W_TITLE", nullable = false)
	public Short getTitle()
	{
		return title;
	}

	public String pId;// 流程实例ID



	public void setTitle(Short title)
	{
		this.title = title;
	}


	@Column(name = "W_TEL", length = 20)
	public String getTel()
	{
		return tel;
	}


	public void setTel(String tel)
	{
		this.tel = tel;
	}

	// 决裁
	private List<Judge> judgeSet;


	// 传收人
	private List<Judge> receiveWipeSet;

	
	// 双向一对多的关系
	@OneToMany(cascade = { CascadeType.REFRESH, CascadeType.MERGE, CascadeType.REMOVE }, fetch = FetchType.LAZY, mappedBy = "wipe")
	public Set<WipeItem> getWipeItemSet()
	{
		return wipeItemSet;
	}

	public void setWipeItemSet(Set<WipeItem> wipeItemSet)
	{
		this.wipeItemSet = wipeItemSet;
	}

	// 单向关系
	@ManyToOne(fetch = FetchType.EAGER, cascade = { CascadeType.REFRESH })
	@JoinColumn(name = "USER_ID")
	public User getwUser()
	{
		return wUser;
	}

	public void setwUser(User wUser)
	{
		this.wUser = wUser;
	}


	@Column(name = "W_APTIME", nullable = false)
	public String getwApTime()
	{
		return wApTime;
	}


	public void setwApTime(String wApTime)
	{
		this.wApTime = wApTime;
	}

	@Column(name = "W_TOTAL", nullable = true)
	public BigDecimal getwTotal() {
		return wTotal;
	}

	public void setwTotal(BigDecimal total) {
		wTotal = total;
	}

	@Column(name = "W_REMARK", nullable = true,length=500)
	public String getwRemark()
	{
		return wRemark;
	}


	public void setwRemark(String wRemark)
	{
		this.wRemark = wRemark;
	}

	@Column(name = "W_CODE", nullable = true, length = 50)
	public String getwCode()
	{
		return wCode;
	}


	public void setwCode(String wCode)
	{
		this.wCode = wCode;
	}

	// 双向一对多的关系
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "wipe")
	public List<Judge> getJudgeSet()
	{
		return judgeSet;
	}


	public void setJudgeSet(List<Judge> judgeSet)
	{
		this.judgeSet = judgeSet;
	}

	@Column(name = "W_TYPE", nullable = false)
	public Integer getWType()
	{
		return wType;
	}


	public void setWType(Integer type)
	{
		wType = type;
	}

	@Column(name = "W_PID")
	public String getPId()
	{
		return pId;
	}

	public void setPId(String id)
	{
		pId = id;
	}

	@Column(name = "W_STATE")
	public Short getState() {
		return state;
	}

	public void setState(Short state) {
		this.state = state;
	}

	// 双向一对多的关系
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "wipe")
	public List<Judge> getReceiveWipeSet() {
		return receiveWipeSet;
	}

	public void setReceiveWipeSet(List<Judge> receiveWipeSet) {
		this.receiveWipeSet = receiveWipeSet;
	}

}
