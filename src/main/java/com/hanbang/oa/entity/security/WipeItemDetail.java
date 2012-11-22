package com.hanbang.oa.entity.security;

import java.math.BigDecimal;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import com.hanbang.core.entity.IdEntity;




/**
 * @author Owner 经费报销明细表
 */
@Entity
@Table(name = "BY_WIPEITEMDETAIL")
public class WipeItemDetail extends IdEntity
{

	// 项目编号
	private WipeItem wipeItem;
	// 日期
	private String itemDetailDate;
	// 金额
	private BigDecimal itemDetailMoney;
	// 摘要
	private String itemDetailBrief;
	// 备注
	private String itemDetailRemark;
	


	// 双向多对一关系
	@ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER, optional = true)
	@JoinColumn(name = "I_CODE")
	public WipeItem getWipeItem()
	{
		return wipeItem;
	}


	public void setWipeItem(WipeItem wipeItem)
	{
		this.wipeItem = wipeItem;
	}


	@Column(name = "ITEMDETAIL_DATE", nullable = true)
	public String getItemDetailDate()
	{
		return itemDetailDate;
	}


	public void setItemDetailDate(String itemDetailDate)
	{
		this.itemDetailDate = itemDetailDate;
	}
	@Column(name = "ITEMDETAIL_MONEY", nullable = true)
	public BigDecimal getItemDetailMoney() {
		return itemDetailMoney;
	}


	public void setItemDetailMoney(BigDecimal itemDetailMoney) {
		this.itemDetailMoney = itemDetailMoney;
	}


	@Column(name = "ITEMDETAIL_BRIEF", nullable = true,length=500)
	public String getItemDetailBrief()
	{
		return itemDetailBrief;
	}


	public void setItemDetailBrief(String itemDetailBrief)
	{
		this.itemDetailBrief = itemDetailBrief;
	}


	@Column(name = "ITEMDETAIL_REMARK", nullable = true,length=500)
	public String getItemDetailRemark()
	{
		return itemDetailRemark;
	}


	public void setItemDetailRemark(String itemDetailRemark)
	{
		this.itemDetailRemark = itemDetailRemark;
	}
	
}
