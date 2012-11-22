package com.hanbang.oa.entity.security;

import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * 角色表
 *@author ZoopNin 
 */

@Entity
@Table(name = "TB_ROLE")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE, region = "TB_ROLE")
public class UserRoles implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	
	private Long roleId ;
	
	//角色名称
	private String roleName ;
	
	//该角色具有的功能
	private String content ;
	
	//权限描述
	private String memo ;
	
	private List<User> users  ;

	public UserRoles(){}
	

	public UserRoles(String roleName, String content, String memo,
			List<User> users) {
		super();
		this.roleName = roleName;
		this.content = content;
		this.memo = memo;
		this.users = users;
	}

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "id")
	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	
	@Column(name = "roleName",length=30) 
	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	
	@Column(name = "content")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	
	@Column(name = "memo")
	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}
	

	@OneToMany(cascade = CascadeType.ALL,fetch=FetchType.LAZY,mappedBy="role")
	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}
	
	
	
}
