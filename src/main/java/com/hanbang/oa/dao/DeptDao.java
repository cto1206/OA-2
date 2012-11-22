package com.hanbang.oa.dao;

import org.springframework.stereotype.Repository;
import com.hanbang.core.dao.HibernateEntityDao;
import com.hanbang.oa.entity.security.Dept;




/**
 * 部门信息数据服务
 * 
 * @author zmm
 * 
 */
@Repository
public class DeptDao extends HibernateEntityDao<Dept, Long>
{

}
