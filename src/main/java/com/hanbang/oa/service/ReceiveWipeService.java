package com.hanbang.oa.service;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hanbang.core.dao.HibernateEntityDao;
import com.hanbang.core.service.EntityService;
import com.hanbang.oa.dao.ReceiveWipeDao;
import com.hanbang.oa.entity.security.ReceiveWipe;
import com.hanbang.oa.entity.security.Wipe;


// Spring Service Bean的标识.
@Service
public class ReceiveWipeService extends EntityService<ReceiveWipe, Long>
{
	SimpleDateFormat f=new SimpleDateFormat("yyyy-MM-dd");
	@Resource
	private UserService userManager;

	@Resource
	private ReceiveWipeDao receiveWipeDao;

	@Override
	protected HibernateEntityDao<ReceiveWipe, Long> getEntityDao() {
		return receiveWipeDao;
	}
	
	//批量保存
	@Transactional
	public void batchSave(List<Long> uId,Wipe wipe)
	{
		ReceiveWipe receiveWipe=null;
		for(int i=0;i<uId.size();i++)
		{
			if(this.findReceiveBy(uId.get(i), wipe.getId())==null||this.findReceiveBy(uId.get(i), wipe.getId()).size()==0){
				
				if(uId.get(i)!=null){
					receiveWipe=new ReceiveWipe();
				    receiveWipe.setRUser(userManager.get(uId.get(i)));
					receiveWipe.setState((short)0);
					receiveWipe.setSentTime(f.format(new Date()));
					receiveWipe.setWipe(wipe);
					this.save(receiveWipe);
				}
			}
		}
	}
	
	//查询某份报销单是否已经传送给了某人
	public List<ReceiveWipe> findReceiveBy(Long uId, Long wId)
	{
		return receiveWipeDao.findReceiveBy(uId,wId);
	}		

	
	//查询接收报销列表
	public List<ReceiveWipe> selByUid(Long uId,Short state){	
		return receiveWipeDao.selByUid(uId,state);
	}
}
