package com.hanbang.oa.entity.security;

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
import java.math.BigDecimal;




/**
 * @author Owner 经费项目表
 */
@Entity
@Table(name = "BY_WIPEITEM")
public class WipeItem extends IdEntity
{

	// 经费项目
	private String iItem;
	// 金额
	private BigDecimal iMoney;
	// 经费报销表
	private Wipe wipe;
	// 经费项目详细
	private Set<WipeItemDetail> wipeItemDetial;
    

	// 双向多对一关系
	@ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER, optional = true)
	@JoinColumn(name = "W_ID")
	public Wipe getWipe()
	{
		return wipe;
	}


	// 双向一对多的关系
	@OneToMany(cascade = { CascadeType.MERGE, CascadeType.REMOVE, CascadeType.REFRESH }, fetch = FetchType.LAZY, mappedBy = "wipeItem")
	public Set<WipeItemDetail> getWipeItemDetial()
	{
		return wipeItemDetial;
	}


	public void setWipeItemDetial(Set<WipeItemDetail> wipeItemDetial)
	{
		this.wipeItemDetial = wipeItemDetial;
	}


	public void setWipe(Wipe wipe)
	{
		this.wipe = wipe;
	}


	@Column(name = "I_ITEM", nullable = true, length = 100)
	public String getiItem()
	{
		return iItem;
	}


	public void setiItem(String iItem)
	{
		this.iItem = iItem;
	}


	@Column(name = "I_MONEY", nullable = true)
	public BigDecimal getiMoney() {
		return iMoney;
	}


	public void setiMoney(BigDecimal money) {
		iMoney = money;
	}


	

}
