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
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import com.hanbang.core.entity.IdEntity;




/**
 * 用户表
 * 
 * @author zmm
 * 
 */
@Entity
@Table(name = "BY_USER")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE, region = "BY_USER")
public class User extends IdEntity implements Serializable
{
	private static final long serialVersionUID = 1L;

	// 部门信息
	private Dept dept;

	// 角色信息
	private UserRoles role;

	// 用户账号
	private String name;

	// 真实姓名
	private String rName;

	// 用户性别
	private Short sex;

	// 用户密码
	private String pwd;

	// 联系电话
	private String tel;

	// 出生日期
	private Date birthday;

	// 禀议码
	private String byPwd;



	@Column(name = "USER_BYPWD", length = 50)
	public String getByPwd()
	{
		return byPwd;
	}


	public void setByPwd(String byPwd)
	{
		this.byPwd = byPwd;
	}


	@ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.REFRESH })
	@JoinColumn(name = "DEPT_ID")
	public Dept getDept()
	{
		return dept;
	}


	public void setDept(Dept dept)
	{
		this.dept = dept;
	}


	@ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.REFRESH })
	@JoinColumn(name = "ROLE_ID")
	public UserRoles getRole()
	{
		return role;
	}


	public void setRole(UserRoles role)
	{
		this.role = role;
	}


	@Column(name = "USER_NAME", length = 20, nullable = false, updatable = false)
	public String getName()
	{
		return name;
	}


	public void setName(String name)
	{
		this.name = name;
	}


	@Column(name = "USER_RNAME", length = 20, nullable = false)
	public String getRName()
	{
		return rName;
	}


	public void setRName(String name)
	{
		rName = name;
	}


	@Column(name = "USER_SEX")
	public Short getSex()
	{
		return sex;
	}


	public void setSex(Short sex)
	{
		this.sex = sex;
	}


	@Column(name = "USER_PWD", length = 50)
	public String getPwd()
	{
		return pwd;
	}


	public void setPwd(String pwd)
	{
		this.pwd = pwd;
	}


	@Column(name = "USER_TEL", length = 20)
	public String getTel()
	{
		return tel;
	}


	public void setTel(String tel)
	{
		this.tel = tel;
	}


	@Column(name = "USER_BIRTHDAY")
	public Date getBirthday()
	{
		return birthday;
	}


	public void setBirthday(Date birthday)
	{
		this.birthday = birthday;
	}

}
