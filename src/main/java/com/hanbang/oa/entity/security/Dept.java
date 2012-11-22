package com.hanbang.oa.entity.security;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import com.hanbang.core.entity.IdEntity;




/**
 * 部门表
 * 
 * @author zmm
 * 
 */
@Entity
@Table(name = "BY_DEPT")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE, region = "BY_DEPT")
public class Dept extends IdEntity implements Serializable
{
	private static final long serialVersionUID = 1L;

	// 部门名称
	private String name;

	// 联系电话
	private String tel;

	// 上级部门
	private Long parent;

	// 部门代号
	private String alias;

	// 该部门的人员列表
	private List<User> users;



	@Column(name = "DEPT_NAME", length = 50, nullable = false)
	public String getName()
	{
		return name;
	}


	public void setName(String name)
	{
		this.name = name;
	}


	@Column(name = "DEPT_TEL", length = 50)
	public String getTel()
	{
		return tel;
	}


	public void setTel(String tel)
	{
		this.tel = tel;
	}


	@Column(name = "DEPT_PARENT", nullable = false)
	public Long getParent()
	{
		return parent;
	}


	public void setParent(Long parent)
	{
		this.parent = parent;
	}


	@Column(name = "DEPT_ALIAS", length = 10)
	public String getAlias()
	{
		return alias;
	}


	public void setAlias(String alias)
	{
		this.alias = alias;
	}


	@OneToMany(fetch = FetchType.LAZY, cascade = { CascadeType.REFRESH }, mappedBy = "dept")
	public List<User> getUsers()
	{
		return users;
	}


	public void setUsers(List<User> users)
	{
		this.users = users;
	}

}
