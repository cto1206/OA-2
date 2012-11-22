package com.hanbang.oa.entity.security;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.hanbang.core.entity.IdEntity;




/**
 * 禀议报告表
 * 
 * @author zmm
 * 
 */
@Entity
@Table(name = "BY_RINGISHO")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE, region = "BY_RINGISHO")
public class RingiSho extends IdEntity implements Serializable
{
	private static final long serialVersionUID = 1L;

	// 禀议编号
	private String code;

	// 禀议标题
	private Short title;

	// 作成者
	private User user;

	// 作成日期
	private Date date;

	// 电话
	private String tel;

	// 禀议主题
	private String sub;

	// 申请原因
	private String cause;

	// 详细内容
	private String synopsis;

	// 需求日期
	private Date needDate;

	// 一级审查人员
	private User flowMan1;

	// 一级审查时间
	private Date flowDate1;

	// 二级决裁人员
	private User flowMan2;

	// 二级决裁时间
	private Date flowDate2;

	// 三级合议人员(采购主管)
	private User flowManStock;

	// 三级合议人员(财务主管)
	private User flowManFinance;

	// 三级合议时间(采购主管)
	private Date flowDateStock;

	// 三级合议时间(财务主管)
	private Date flowDateFinance;

	// 四级合议人员
	private User flowMan4;

	// 四级合议时间
	private Date flowDate4;

	// 最终决裁人员
	private User presidentMan;

	// 最终决裁时间
	private Date presidentDate;

	// 禀议类型 0:采购类,1:经费类
	private Short flag;

	// 禀议审批级别,0:部内,1:部外
	private Short leType;

	// 禀议书状态,0:审批中,1:已结束,2:已驳回
	private Short state;

	// 该禀议报告的指示事项
	private List<RingiShoDetail> ringiShoDetails;



	@Column(name = "RI_CODE", length = 20)
	public String getCode()
	{
		return code;
	}


	public void setCode(String code)
	{
		this.code = code;
	}


	@Column(name = "RI_TITLE", nullable = false)
	public Short getTitle()
	{
		return title;
	}


	public void setTitle(Short title)
	{
		this.title = title;
	}


	@ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.REFRESH })
	@JoinColumn(name = "USER_ID", nullable = false, updatable = false)
	public User getUser()
	{
		return user;
	}


	public void setUser(User user)
	{
		this.user = user;
	}


	@Column(name = "RI_DATE", nullable = false, updatable = false)
	public Date getDate()
	{
		return date;
	}


	public void setDate(Date date)
	{
		this.date = date;
	}


	@Column(name = "RI_TEL", length = 20)
	public String getTel()
	{
		return tel;
	}


	public void setTel(String tel)
	{
		this.tel = tel;
	}


	@Column(name = "RI_SUB", length = 50, nullable = false)
	public String getSub()
	{
		return sub;
	}


	public void setSub(String sub)
	{
		this.sub = sub;
	}


	@Lob
	@Basic(fetch = FetchType.EAGER)
	@Column(name = "RI_CAUSE", columnDefinition = "LONGTEXT", nullable = false)
	public String getCause()
	{
		return cause;
	}


	public void setCause(String cause)
	{
		this.cause = cause;
	}


	@Lob
	@Basic(fetch = FetchType.EAGER)
	@Column(name = "RI_SYNOPSIS", columnDefinition = "LONGTEXT")
	public String getSynopsis()
	{
		return synopsis;
	}


	public void setSynopsis(String synopsis)
	{
		this.synopsis = synopsis;
	}


	@Column(name = "RI_NEEDDATE", nullable = false)
	public Date getNeedDate()
	{
		return needDate;
	}


	public void setNeedDate(Date needDate)
	{
		this.needDate = needDate;
	}


	@ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.REFRESH })
	@JoinColumn(name = "RI_FLOWMAN1")
	public User getFlowMan1()
	{
		return flowMan1;
	}


	public void setFlowMan1(User flowMan1)
	{
		this.flowMan1 = flowMan1;
	}


	@Column(name = "RI_FLOWDATE1")
	public Date getFlowDate1()
	{
		return flowDate1;
	}


	public void setFlowDate1(Date flowDate1)
	{
		this.flowDate1 = flowDate1;
	}


	@ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.REFRESH })
	@JoinColumn(name = "RI_FLOWMAN2")
	public User getFlowMan2()
	{
		return flowMan2;
	}


	public void setFlowMan2(User flowMan2)
	{
		this.flowMan2 = flowMan2;
	}


	@Column(name = "RI_FLOWDATE2")
	public Date getFlowDate2()
	{
		return flowDate2;
	}


	public void setFlowDate2(Date flowDate2)
	{
		this.flowDate2 = flowDate2;
	}


	@ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.REFRESH })
	@JoinColumn(name = "RI_FLOWMAN4")
	public User getFlowMan4()
	{
		return flowMan4;
	}


	public void setFlowMan4(User flowMan4)
	{
		this.flowMan4 = flowMan4;
	}


	@Column(name = "RI_FLOWDATE4")
	public Date getFlowDate4()
	{
		return flowDate4;
	}


	public void setFlowDate4(Date flowDate4)
	{
		this.flowDate4 = flowDate4;
	}


	@ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.REFRESH })
	@JoinColumn(name = "RI_FLOWMANSTOCK")
	public User getFlowManStock()
	{
		return flowManStock;
	}


	public void setFlowManStock(User flowManStock)
	{
		this.flowManStock = flowManStock;
	}


	@ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.REFRESH })
	@JoinColumn(name = "RI_FLOWMANFINANCE")
	public User getFlowManFinance()
	{
		return flowManFinance;
	}


	public void setFlowManFinance(User flowManFinance)
	{
		this.flowManFinance = flowManFinance;
	}


	@Column(name = "RI_FLOWDATESTOCK")
	public Date getFlowDateStock()
	{
		return flowDateStock;
	}


	public void setFlowDateStock(Date flowDateStock)
	{
		this.flowDateStock = flowDateStock;
	}


	@Column(name = "RI_FLOWDATEFINANCE")
	public Date getFlowDateFinance()
	{
		return flowDateFinance;
	}


	public void setFlowDateFinance(Date flowDateFinance)
	{
		this.flowDateFinance = flowDateFinance;
	}


	@ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.REFRESH })
	@JoinColumn(name = "RI_PRESIDENTMAN")
	public User getPresidentMan()
	{
		return presidentMan;
	}


	public void setPresidentMan(User presidentMan)
	{
		this.presidentMan = presidentMan;
	}


	@Column(name = "RI_PRESIDENTDATE")
	public Date getPresidentDate()
	{
		return presidentDate;
	}


	public void setPresidentDate(Date presidentDate)
	{
		this.presidentDate = presidentDate;
	}


	@Column(name = "RI_FLAG")
	public Short getFlag()
	{
		return flag;
	}


	public void setFlag(Short flag)
	{
		this.flag = flag;
	}


	@Column(name = "RI_LETYPE")
	public Short getLeType()
	{
		return leType;
	}


	public void setLeType(Short leType)
	{
		this.leType = leType;
	}


	@Column(name = "RI_STATE")
	public Short getState()
	{
		return state;
	}


	public void setState(Short state)
	{
		this.state = state;
	}


	@OneToMany(fetch = FetchType.LAZY, cascade = { CascadeType.REFRESH }, mappedBy = "ringiSho")
	public List<RingiShoDetail> getRingiShoDetails()
	{
		return ringiShoDetails;
	}


	public void setRingiShoDetails(List<RingiShoDetail> ringiShoDetails)
	{
		this.ringiShoDetails = ringiShoDetails;
	}

}
