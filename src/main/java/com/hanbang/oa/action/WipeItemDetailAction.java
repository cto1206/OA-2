package com.hanbang.oa.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import com.hanbang.core.action.CRUDActionSupport;
import com.hanbang.core.dao.support.Page;
import com.hanbang.core.utils.ActionUtil;
import com.hanbang.oa.entity.security.Wipe;
import com.hanbang.oa.entity.security.WipeItem;
import com.hanbang.oa.entity.security.WipeItemDetail;
import com.hanbang.oa.service.WipeItemDetailService;
import com.hanbang.oa.service.WipeItemService;
import com.hanbang.oa.service.WipeService;




public class WipeItemDetailAction extends CRUDActionSupport<WipeItemDetail>
{

	private static final long serialVersionUID = 1L; 
	
	private WipeItemDetail wipeItemDetail;
	
	@Resource
	private WipeItemDetailService wipeItemDetailService;

	@Resource
	private WipeItemService wipeItemService;

	private List<WipeItem> wipeItemList;

	private List<WipeItemDetail> wipeItemDetailList;

	private String itemDetailDisable;

	private String itemDisable;
	
	private String disalbe;

	private Wipe wipe;

	private String isCom;
	
	private WipeItem wipeItem;
	
	@Resource
	private WipeService wipeService;
	
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

	private String mybtn;

	public String getMybtn()
	{
		return mybtn;
	}


	public WipeItem getWipeItem()
	{
		return wipeItem;
	}


	public Wipe getWipe()
	{
		return wipe;
	}


	public String getItemDisable()
	{
		return itemDisable;
	}


	public String getItemDetailDisable()
	{
		return itemDetailDisable;
	}


	public void setItemDetailDisable(String itemDetailDisable)
	{
		this.itemDetailDisable = itemDetailDisable;
	}


	public List<WipeItem> getWipeItemList()
	{
		return wipeItemList;
	}



	private String reApply;
	private Long wId;



	public String getReApply()
	{
		return reApply;
	}


	public void setReApply(String reApply)
	{
		this.reApply = reApply;
	}


	public Long getWId()
	{
		return wId;
	}


	public void setWId(Long id)
	{
		wId = id;
	}


	@Override
	protected void list(Page<WipeItemDetail> page) throws Exception
	{
		if (ActionUtil.getCurLoginInfo().getRole().getRoleId() == 1)
		{
			wipeItemDetailService.pagedQuery(page);
		}
		else
		{
			if (reApply != null)
			{
				wipeItemDetailService.selItemByWid(wId, page);
			}
			else
			{
				wipeItemDetailService.getMyAll(ActionUtil.getCurLoginInfo(), page, wId);
			}
		}
	}


	@Override
	public String delete() throws Exception
	{

		wipeItem = wipeItemDetailService.get(super.getKey()).getWipeItem();
		
		Long iId = wipeItem.getId();
		
		wipeItemDetailService.delete(super.getKey());// 删除wipeItemDetail;

		wipe = wipeService.get(wipeItemService.get(iId).getWipe().getId());

		wipeItemList = wipeItemService.getMyAll(ActionUtil.getCurLoginInfo(), wipe.getId());

		wipeItemDetailList = wipeItemDetailService.selItemByWid(wipe.getId());

		if (wipeItemDetailList.size() == 0)
		{
			wipeItemDetail = new WipeItemDetail();
			
			wipeItemDetail.setWipeItem(wipeItem);
		}
		else
		{
			wipeItemDetail = wipeItemDetailList.get(wipeItemDetailList.size() - 1);
		}
		
		itemDetailDisable = "false";
		
		itemDisable = "false";
		
		disalbe = "false";
		
		mybtn = "ok";

		return "addWipe";

	}


	public String reDel() throws Exception
	{

		wipeItem = wipeItemDetailService.get(super.getKey()).getWipeItem();
		
		Long iId = wipeItem.getId();
		
		wipeItemDetailService.delete(super.getKey());// 删除wipeItemDetail;

		wipe = wipeService.get(wipeItemService.get(iId).getWipe().getId());

		wipeItemList = wipeItemService.getMyAll(ActionUtil.getCurLoginInfo(), wipe.getId());

		wipeItemDetailList = wipeItemDetailService.selItemByWid(wipe.getId());

		return "reDel";
	}


	@Override
	public String get() throws Exception
	{
		return null;
	}


	public String prepareForAdd() throws Exception
	{
		wipeItemList = wipeItemService.findAll();
		
		if (wipeItemList == null)
			
			return null;
		
		return FORMVIEW;
	}


	public String prepareForEdit() throws Exception
	{
		wipeItemList = wipeItemService.findAll();
		
		wipeItemDetail = wipeItemDetailService.get(super.getKey());
		
		return FORMVIEW;
	}


	@Override
	public String save() throws Exception
	{
		wipeItem = wipeItemService.get(wipeItemDetail.getWipeItem().getId());
		
		wipeItemDetail.setWipeItem(wipeItem);

		wipeItemDetail.setItemDetailDate(wipeItemDetail.getItemDetailDate());

		wipeItemDetailService.save(wipeItemDetail);

		wipe = wipeService.get(wipeItem.getWipe().getId());

		wipeItemList = wipeItemService.getMyAll(ActionUtil.getCurLoginInfo(), wipe.getId());

		wipeItemDetailList = wipeItemDetailService.selItemByWid(wipeItemService.get(wipeItemDetail.getWipeItem().getId()).getWipe().getId());
		
		itemDetailDisable = "false";
		
		itemDisable = "false";
		
		disalbe = "false";
		
		mybtn = "ok";

		return "addWipe";

	}


	public String reSave() throws Exception
	{
		wipeItem = wipeItemService.get(wipeItemDetail.getWipeItem().getId());
		
		wipeItemDetail.setWipeItem(wipeItem);

		wipeItemDetail.setItemDetailDate(wipeItemDetail.getItemDetailDate());

		wipeItemDetailService.save(wipeItemDetail);

		wipe = wipeService.get(wipeItem.getWipe().getId());
		
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


	public WipeItemDetail getWipeItemDetail()
	{
		return wipeItemDetail;
	}


	public void setWipeItemDetail(WipeItemDetail wipeItemDetail)
	{
		this.wipeItemDetail = wipeItemDetail;
	}


	public List<WipeItemDetail> getWipeItemDetailList()
	{
		return wipeItemDetailList;
	}


	public void setWipeItemDetailList(List<WipeItemDetail> wipeItemDetailList)
	{
		this.wipeItemDetailList = wipeItemDetailList;
	}


	public String getDisalbe()
	{
		return disalbe;
	}


	public String getIsCom()
	{
		return isCom;
	}


	public void setIsCom(String isCom)
	{
		this.isCom = isCom;
	}
}
