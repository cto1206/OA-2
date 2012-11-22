package com.hanbang.core.dao;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.sql.SQLException;
import java.util.Collection;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import com.hanbang.core.dao.support.Page;




/**
 * DAO操作基类 本DAO层实现了通用的数据操作
 * 
 * @author zmm
 * @create 2009-12-16
 * 
 * @param <T>
 * @param <PK>
 */
@SuppressWarnings("unchecked")
public class HibernateEntityDao<T, PK extends Serializable> extends HibernateDaoSupport
{
	@Resource
	private SessionFactory sessionFacotry;



	@PostConstruct
	public void injectSessionFactory()
	{
		super.setSessionFactory(sessionFacotry);
	}



	protected Class<T> entityClass;



	protected Class<T> getEntityClass()
	{
		if (entityClass == null)
		{
			entityClass = (Class<T>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
		}
		return entityClass;
	}


	/**
	 * 加载指定ID实体类对象
	 * 
	 * @param id
	 *            实体ID
	 * 
	 * @return 实体对象
	 * @throws DataAccessException
	 */
	public T load(PK id) throws DataAccessException
	{
		return (T) getHibernateTemplate().load(getEntityClass(), id);
	}


	/**
	 * 查找指定ID实体类对象
	 * 
	 * @param id
	 *            实体ID
	 * 
	 * @return 实体对象
	 * @throws DataAccessException
	 */
	public T get(PK id) throws DataAccessException
	{
		return (T) getHibernateTemplate().get(getEntityClass(), id);
	}


	/**
	 * 根据条件表达式查询实体集合
	 * 
	 * @param criterion
	 * 
	 * @return 集合
	 * @throws DataAccessException
	 */
	protected List<T> findByCriteria(Criterion... criterion) throws DataAccessException
	{
		DetachedCriteria detachedCrit = DetachedCriteria.forClass(getEntityClass());
		for (Criterion c : criterion)
		{
			detachedCrit.add(c);
		}
		return getHibernateTemplate().findByCriteria(detachedCrit);
	}


	/**
	 * 获取所有实体集合
	 * 
	 * @return 集合
	 * @throws DataAccessException
	 */
	public List<T> findAll() throws DataAccessException
	{
		return getHibernateTemplate().find("from " + getEntityClass().getName());
	}


	/**
	 * 加载所有实体集合
	 * 
	 * @return 集合
	 * @throws DataAccessException
	 */
	public List<T> list() throws DataAccessException
	{
		return getHibernateTemplate().loadAll(getEntityClass());
	}


	/**
	 * 查询指定HQL，并返回集合
	 * 
	 * @param hql
	 *            HQL语句
	 * @param values
	 *            可变的参数列表
	 * @return 集合
	 * @throws DataAccessException
	 */
	public List<T> find(String hql, Object... values) throws DataAccessException
	{
		return getHibernateTemplate().find(hql, values);
	}


	/**
	 * 根据命名参数查询
	 * 
	 * @param hql
	 *            带有命名参数的hql语句
	 * @param paramNames
	 *            命名参数的名字
	 * @param values
	 *            命名参数的值<br>
	 *            <b>例如:</b><br>
	 *            findByNamedParams("from Test where t1 = :t",new
	 *            String[]{"t"},tValue);
	 * @return 集合
	 * @throws DataAccessException
	 */
	public List<T> findByNamedParams(String hql, String[] paramNames, Object... values) throws DataAccessException
	{
		return getHibernateTemplate().findByNamedParam(hql, paramNames, values);
	}


	/**
	 * 按照HQL语句查询唯一对象.
	 * 
	 * @param hql
	 *            HQL语句
	 * @param values
	 *            可变参数集合
	 * @return OBJECT对象
	 * @throws DataAccessException
	 */
	public Object findUnique(final String hql, final Object... values) throws DataAccessException
	{

		return getHibernateTemplate().execute(new HibernateCallback()
		{
			@Override
			public Object doInHibernate(Session s) throws HibernateException, SQLException
			{
				Query query = createQuery(s, hql, values);
				return query.uniqueResult();
			}
		});
	}


	/**
	 * 查找指定HQL并返回Long型
	 * 
	 * @param hql
	 *            HQL语句
	 * @param values
	 *            可变参数列表
	 * @return Long
	 * @throws DataAccessException
	 */
	public Long findLong(final String hql, final Object... values) throws DataAccessException
	{
		return (Long) findUnique(hql, values);
	}


	/**
	 * 获取指定实体Class指定条件的记录总数
	 * 
	 * @param where
	 *            HQL的查询条件,支持参数列表
	 * @param values
	 *            可变参数列表
	 * @return 记录总数
	 * @throws DataAccessException
	 */
	public Long findTotalCount(final String where, final Object... values) throws DataAccessException
	{
		String hql = "select count(e) from " + getEntityClass().getName() + " as e " + where;
		return findLong(hql, values);
	}


	/**
	 * 获取指定实体Class的记录总数
	 * 
	 * @return 记录总数
	 * @throws DataAccessException
	 */
	public Long findTotalCount() throws DataAccessException
	{
		return findTotalCount("");
	}


	/**
	 * 查找指定属性的实体集合
	 * 
	 * @param propertyName
	 *            属性名
	 * @param value
	 *            条件
	 * @return 实体集合
	 * @throws DataAccessException
	 */
	public List<T> findByProperty(String propertyName, Object value) throws DataAccessException
	{

		String queryStr = "from " + getEntityClass().getName() + " as model where model." + propertyName + "=?";
		return getHibernateTemplate().find(queryStr, value);
	}


	/**
	 * 模糊查询指定条件对象集合 用法：可以实例化一个空的T对象，需要查询某个字段，就set该字段的条件然后调用本方法
	 * 缺点：目前测试貌似只能支持String的模糊查询，虽然有办法重写，但没必要，其他用HQL
	 * 
	 * @param entity
	 *            条件实体
	 * @return 结合
	 * @throws DataAccessException
	 */
	public List<T> findByExample(T entity) throws DataAccessException
	{
		return getHibernateTemplate().findByExample(entity);
	}


	/**
	 * 按HQL分页查询.稳定性待测
	 * 
	 * @param page
	 *            页面对象
	 * @param hql
	 *            HQL语句
	 * @param values
	 *            可变参数列表
	 * @return 分页数据
	 * @throws DataAccessException
	 */
	public Page<T> pagedQuery(final Page<T> page, final String hql, final Object... values) throws DataAccessException
	{

		return (Page<T>) getHibernateTemplate().execute(new HibernateCallback()
		{
			@Override
			public Object doInHibernate(Session s) throws HibernateException, SQLException
			{
				StringBuffer q = new StringBuffer(hql);
				if (StringUtils.isNotEmpty(page.getOrderBy()) && StringUtils.isNotEmpty(page.getOrder()))
				{
					q.append(" order by ").append(page.getOrderBy());
					q.append(" ").append(page.getOrder());
				}
				Query query = null;
				query = createQuery(s, "select count(*) " + hql, values);
				page.setTotalCount(((Long) query.uniqueResult()).intValue());
				query = createQuery(s, q.toString(), values);
				if (page.isFirstSetted())
				{
					query.setFirstResult(page.getFirst());
				}
				if (page.isPageSizeSetted())
				{
					query.setMaxResults(page.getPageSize());
				}
				page.setResult(query.list());
				return page;
			}
		});
	}


	/**
	 * 按条件表达式分页查询.
	 * 
	 * @param page
	 *            页面对象
	 * @param detachedCriteria
	 *            条件
	 * @return 分页数据
	 * @throws DataAccessException
	 */
	public Page<T> pagedQuery(final Page<T> page, final DetachedCriteria detachedCriteria) throws DataAccessException
	{

		return (Page<T>) getHibernateTemplate().execute(new HibernateCallback()
		{
			@Override
			public Object doInHibernate(Session s) throws HibernateException, SQLException
			{
				Criteria cr = detachedCriteria.getExecutableCriteria(s);
				int totalCount = ((Integer) cr.setProjection(Projections.rowCount()).uniqueResult()).intValue();
				cr.setProjection(null);
				cr.setResultTransformer(CriteriaSpecification.ROOT_ENTITY);
				if (StringUtils.isNotEmpty(page.getOrderBy()))
				{
					if (StringUtils.isNotEmpty(page.getOrder()))
					{
						if ("asc".equalsIgnoreCase(page.getOrder()))
						{
							cr.addOrder(Order.asc(page.getOrderBy()));
						}
						else
						{
							cr.addOrder(Order.desc(page.getOrderBy()));
						}
					}
				}
				if (page.isFirstSetted())
				{
					cr.setFirstResult(page.getFirst());
				}
				if (page.isPageSizeSetted())
				{
					cr.setMaxResults(page.getPageSize());
				}
				page.setTotalCount(totalCount);
				page.setResult(cr.list());
				return page;
			}
		});
	}


	/**
	 * 按HQL分页查询.
	 * 
	 * @param page
	 *            页面对象
	 * 
	 * @return 分页数据
	 * @throws DataAccessException
	 */
	public Page<T> pagedQuery(Page<T> page) throws DataAccessException
	{
		return pagedQuery(page, DetachedCriteria.forClass(getEntityClass()));
	}


	/**
	 * 根据查询条件与参数列表创建Query对象
	 * 
	 * @param session
	 *            Hibernate会话
	 * @param hql
	 *            HQL语句
	 * @param objects
	 *            参数列表
	 * @return Query对象
	 * @throws DataAccessException
	 */
	public Query createQuery(Session session, String hql, Object... objects) throws DataAccessException
	{
		Query query = session.createQuery(hql);
		if (objects != null)
		{
			for (int i = 0; i < objects.length; i++)
			{
				query.setParameter(i, objects[i]);
			}
		}
		return query;
	}


	/**
	 * 保存指定实体类
	 * 
	 * @param entity
	 *            实体类
	 * @throws DataAccessException
	 */
	public void save(T entity) throws DataAccessException
	{
		getHibernateTemplate().save(entity);
	}


	/**
	 * 更新指定实体类
	 * 
	 * @param entity
	 *            实体类
	 * @throws DataAccessException
	 */
	public void update(T entity) throws DataAccessException
	{
		getHibernateTemplate().update(entity);
	}


	/**
	 * 删除指定实体
	 * 
	 * @param entity
	 *            实体类
	 * @throws DataAccessException
	 */
	public void delete(T entity) throws DataAccessException
	{
		getHibernateTemplate().delete(entity);
	}


	/**
	 * 根据主键删除指定实体
	 * 
	 * @param entity
	 *            实体类
	 * @throws DataAccessException
	 */
	public void delete(PK id) throws DataAccessException
	{
		getHibernateTemplate().delete(load(id));
	}


	/**
	 * 删除实体列表
	 * 
	 * @param entities
	 *            实体类
	 * @throws DataAccessException
	 */
	public void deleteAll(Collection<T> entities) throws DataAccessException
	{
		getHibernateTemplate().deleteAll(entities);
	}


	/**
	 * 更新或保存指定实体
	 * 
	 * @param entity
	 *            实体类
	 * @throws DataAccessException
	 */
	public void saveOrUpdate(T entity) throws DataAccessException
	{
		getHibernateTemplate().saveOrUpdate(entity);
	}


	/**
	 * 合并更新session中持久化对象
	 * 
	 * @param entity
	 *            实体类
	 * @return 持久后的实体类
	 * @throws DataAccessException
	 */
	public T merge(T entity) throws DataAccessException
	{
		return (T) getHibernateTemplate().merge(entity);
	}


	/**
	 * 清除实体的锁定状态 方法未测
	 * 
	 * @param entity
	 *            实体
	 * @throws DataAccessException
	 */
	public void attachClean(T entity) throws DataAccessException
	{
		getHibernateTemplate().lock(entity, LockMode.NONE);
	}
}
