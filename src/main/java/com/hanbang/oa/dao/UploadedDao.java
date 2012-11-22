package com.hanbang.oa.dao;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.hanbang.core.dao.HibernateEntityDao;
import com.hanbang.oa.entity.security.Uploaded;




/**
 * 附件上传数据服务
 * 
 * @author zmm
 * 
 */
@Repository
public class UploadedDao extends HibernateEntityDao<Uploaded, Long>
{
	/**
	 * 根据表名和表的主键查询附件信息列表
	 * 
	 * @param tabId
	 * @param tab
	 * @return 附件列表
	 */
	public List<Uploaded> findBy(Long tabId, String tab)
	{
		return find("from Uploaded where tabId = ? and tab = ? order by RName desc", tabId, tab);
	}
}
