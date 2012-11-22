package com.hanbang.oa.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import com.hanbang.core.action.CRUDActionSupport;
import com.hanbang.core.dao.support.Page;
import com.hanbang.core.utils.ActionUtil;
import com.hanbang.core.utils.Struts2Utils;
import com.hanbang.oa.entity.security.Wipe;
import com.hanbang.oa.entity.security.WipeItem;
import com.hanbang.oa.entity.security.WipeItemDetail;
import com.hanbang.oa.service.WipeItemService;
import com.hanbang.oa.service.WipeService;




public class WipeItemAction extends CRUDActionSupport<WipeItem>
{

	private static final long serialVersionUID = 1L;

	private WipeItem wipeItem;

	private Long wId;

	@Resource
	private WipeItemService wipeItemService;

	@Resource
	private WipeService wipeService;

	private List<Wipe> wipelist;

	private Wipe wipe;

	private List<WipeItem> wipeItemList;
	
	private List<WipeItemDetail> wipeItemDetailList;
	
	private String reApply;

	private String itemDisable;

	private String disalbe;

	private WipeItemDetail wipeItemDetail;

	private String mybtn;

	private String isCom;
	
	private String iItemId;



	public String getIItemId() {
		return iItemId;
	}


	public void setIItemId(String itemId) {
		iItemId = itemId;
	}


	public String getIsCom()
	{
		return isCom;
	}


	public void setIsCom(String isCom)
	{
		this.isCom = isCom;
	}


	public String getMybtn()
	{
		return mybtn;
	}


	public String getReApply()
	{
		return reApply;
	}


	public void setReApply(String reApply)
	{
		this.reApply = reApply;
	}


	public List<Wipe> getWipelist()
	{
		return wipelist;
	}


	public void setWipelist(List<Wipe> wipelist)
	{
		this.wipelist = wipelist;
	}


	@Override
	protected void list(Page<WipeItem> page) throws Exception
	{
		if (ActionUtil.getCurLoginInfo().getRole().getRoleId() == 1)
		{
			wipeItemService.pagedQuery(page);

		}
		else
		{
			if (reApply != null)
			{
				wipeItemService.selItemByWid(wId, page);
			}
			else
			{
				wipeItemService.getMyAll(ActionUtil.getCurLoginInfo(), page, wId);
			}
		}
	}


	@Override
	public String delete() throws Exception
	{
		wipe = wipeItemService.get(super.getKey()).getWipe();
		
		Long wId = wipe.getId();

		wipeItemService.delete(super.getKey());

		wipeItemList = wipeItemService.selItemByWid(wId);

		wipeItem = new WipeItem();
		
		wipeItem.setWipe(wipe);

		wipeItemDetail = new WipeItemDetail();
		
		if (wipeItemList.size() == 0)
		{
			wipeItemDetail.setWipeItem(null);
		}
		else
		{
			wipeItemDetail.setWipeItem(wipeItemList.get(wipeItemList.size() - 1));
		}
		mybtn = "ok";
		
		itemDisable = "false";
		
		disalbe = "false";
		
		return "addWipe";
	}


	public String reDel() throws Exception
	{
		wipe = wipeItemService.get(super.getKey()).getWipe();

		wipeItemService.delete(super.getKey());

		wipeItemList = new ArrayList<WipeItem>();
		
		wipeItemDetailList = new ArrayList<WipeItemDetail>();
		
		if (wipe.getWipeItemSet() != null)
		{
			for (WipeItem wipeItem : wipe.getWipeItemSet())
			{
				if (wipeItem.getWipeItemDetial() != null)
				{
					for (WipeItemDetail wipeItemDetail : wipeItem.getWipeItemDetial())
					{
						wipeItemDetailList.add(wipeItemDetail);
					}
				}
				wipeItemList.add(wipeItem);
			}
		}
		wipeItem = new WipeItem();
		
		wipeItem.setWipe(wipe);
	
		return "reDel";
	}


	@SuppressWarnings("unchecked")
	@Override
	public String get() throws Exception
	{
		wipeItem = wipeItemService.get(super.getKey());
		
		Map map = new HashMap();
		
		map.put("id", wipeItem.getId());
		
		map.put("item", wipeItem.getiItem());
		
		return Struts2Utils.renderJson(map);
	}


	public String prepareForAdd() throws Exception
	{
		wipelist = wipeService.findAll();
		
		return FORMVIEW;
	}


	public String prepareForEdit() throws Exception
	{
		wipelist = wipeService.findAll();
		
		wipeItem = wipeItemService.get(super.getKey());
		
		return FORMVIEW;
	}


	@Override
	public String save() throws Exception
	{
		wipe = wipeService.get(wipeItem.getWipe().getId());
		
		wipeItem.setWipe(wipe);
		
		if(iItemId!=null&&!"".equals(iItemId))
		{
			wipeItem.setId(Long.parseLong(iItemId));
		}
		wipeItemService.saveOrUpdate(wipeItem);	
		
		
		
		wipeItemList = wipeItemService.selItemByWid(wipeItem.getWipe().getId());
		
		wipeItemDetail = new WipeItemDetail();
		
		wipeItemDetail.setWipeItem(wipeItem);
		
		iItemId=null;
		
		itemDisable = "false";
		
		disalbe = "false";
		
		mybtn = "ok";
		
		return "addWipe";
	}


	public String reSave() throws Exception
	{
		wipe = wipeService.get(wipeItem.getWipe().getId());
		
		wipeItem.setWipe(wipe);
		

		if(iItemId!=null&&!"".equals(iItemId))
		{
			wipeItem.setId(Long.parseLong(iItemId));
		}
		
		wipeItemService.saveOrUpdate(wipeItem);

		wipeItemList = new ArrayList<WipeItem>();
		
		wipeItemDetailList = new ArrayList<WipeItemDetail>();
		
		if (wipe.getWipeItemSet() != null)
		{
			for (WipeItem wipeItem2 : wipe.getWipeItemSet())
			{
				if (wipeItem2.getWipeItemDetial() != null)
				{
					for (WipeItemDetail wipeItemDetail : wipeItem2.getWipeItemDetial())
					{
						wipeItemDetailList.add(wipeItemDetail);
					}
				}
				wipeItemList.add(wipeItem2);
			}
		}
		wipeItem = new WipeItem();
		
		wipeItem.setWipe(wipe);
		
		return "reDel";
	}


	public WipeItem getWipeItem()
	{
		return wipeItem;
	}


	public void setWipeItem(WipeItem wipeItem)
	{
		this.wipeItem = wipeItem;
	}


	public Long getWId()
	{
		return wId;
	}


	public void setWId(Long id)
	{
		wId = id;
	}


	public List<WipeItem> getWipeItemList()
	{
		return wipeItemList;
	}


	public void setWipeItemList(List<WipeItem> wipeItemList)
	{
		this.wipeItemList = wipeItemList;
	}


	public Wipe getWipe()
	{
		return wipe;
	}


	public void setWipe(Wipe wipe)
	{
		this.wipe = wipe;
	}


	public String getItemDisable()
	{
		return itemDisable;
	}


	public void setItemDisable(String itemDisable)
	{
		this.itemDisable = itemDisable;
	}


	public WipeItemDetail getWipeItemDetail()
	{
		return wipeItemDetail;
	}


	public String getDisalbe()
	{
		return disalbe;
	}


	public List<WipeItemDetail> getWipeItemDetailList()
	{
		return wipeItemDetailList;
	}

}
