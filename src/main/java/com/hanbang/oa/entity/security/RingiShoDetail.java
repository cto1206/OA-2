package com.hanbang.oa.entity.security;

import java.io.Serializable;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import com.hanbang.core.entity.IdEntity;




/**
 * 禀议报告指示事项表
 * 
 * @author zmm
 * 
 */
@Entity
@Table(name = "BY_RINGISHODETAIL")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE, region = "BY_RINGISHODETAIL")
public class RingiShoDetail extends IdEntity implements Serializable
{

	private static final long serialVersionUID = 1L;

	// 禀议报告
	private RingiSho ringiSho;

	// 指示事项内容
	private String content;



	@ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.REFRESH })
	@JoinColumn(name = "RI_ID")
	public RingiSho getRingiSho()
	{
		return ringiSho;
	}


	public void setRingiSho(RingiSho ringiSho)
	{
		this.ringiSho = ringiSho;
	}


	@Column(name = "RD_CONTENT", length = 200, nullable = false)
	public String getContent()
	{
		return content;
	}


	public void setContent(String content)
	{
		this.content = content;
	}
}
