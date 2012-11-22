package com.hanbang.oa.dao;

import org.springframework.stereotype.Repository;
import com.hanbang.core.dao.HibernateEntityDao;
import com.hanbang.oa.entity.security.UserRoles;




/**
 * 角色数据服务
 * 
 * @author ZoopNin
 */

@Repository
public class UserRolesDao extends HibernateEntityDao<UserRoles, Long>
{

}
