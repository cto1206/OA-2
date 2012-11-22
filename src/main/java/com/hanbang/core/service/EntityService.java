package com.hanbang.core.service;

import java.io.Serializable;
import java.util.List;
import org.springframework.transaction.annotation.Transactional;
import com.hanbang.core.dao.HibernateEntityDao;
import com.hanbang.core.dao.support.Page;




/**
 * Service操作基类 本Service层实现了通用的数据操作
 * 
 * @author zmm
 * @create 2009-12-16
 * 
 * @param <T>
 * @param <PK>
 */
@Transactional
public abstract class EntityService<T, PK extends Serializable>
{
	protected abstract HibernateEntityDao<T, PK> getEntityDao();


	/**
	 * 查找指定ID实体类对象,找不到时返回NULL
	 * 
	 * @param id
	 * @return
	 */
	@Transactional(readOnly = true)
	public T get(PK id)
	{
		return getEntityDao().get(id);
	}


	/**
	 * 查找指定ID实体类对象,找不到时会报错
	 * 
	 * @param id
	 * @return
	 */
	@Transactional(readOnly = true)
	public T load(PK id)
	{
		return getEntityDao().load(id);
	}


	/**
	 * 获取所有实体集合
	 * 
	 * @return 集合
	 */
	@Transactional(readOnly = true)
	public List<T> findAll()
	{
		return getEntityDao().findAll();
	}


	/**
	 * 查找指定属性的实体集合
	 * 
	 * @param propertyName
	 *            属性名
	 * @param value
	 *            条件
	 * @return 实体集合
	 */
	@Transactional(readOnly = true)
	public List<T> findByProperty(String propertyName, Object value)
	{
		return getEntityDao().findByProperty(propertyName, value);
	}


	/**
	 * 按HQL分页查询.
	 * 
	 * @param page
	 *            页面对象
	 * 
	 * @return 分页数据
	 */
	@Transactional(readOnly = true)
	public Page<T> pagedQuery(Page<T> page)
	{
		return getEntityDao().pagedQuery(page);
	}


	/**
	 * 保存指定实体类
	 * 
	 * @param entity
	 *            实体类
	 */
	public void save(T entity)
	{
		getEntityDao().save(entity);
	}


	/**
	 * 更新指定实体类
	 * 
	 * @param entity
	 *            实体类
	 */
	public void update(T entity)
	{
		getEntityDao().update(entity);
	}


	/**
	 * 更新或保存指定实体
	 * 
	 * @param entity
	 *            实体类
	 */
	public void saveOrUpdate(T entity)
	{
		getEntityDao().saveOrUpdate(entity);
	}


	/**
	 * 合并更新session中持久化对象
	 * 
	 * @param entity
	 *            实体类
	 * @return 持久后的实体类
	 */
	public T merge(T entity)
	{
		return getEntityDao().merge(entity);
	}


	/**
	 * 删除指定实体
	 * 
	 * @param entity
	 *            实体类
	 */
	public void delete(T entity)
	{
		getEntityDao().delete(entity);
	}


	/**
	 * 根据主键删除指定实体
	 * 
	 * @param entity
	 *            实体类
	 */
	public void delete(PK id)
	{
		getEntityDao().delete(id);
	}
}
