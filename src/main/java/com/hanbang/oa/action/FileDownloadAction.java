package com.hanbang.oa.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import javax.annotation.Resource;

import com.hanbang.core.action.BaseAction;
import com.hanbang.core.utils.Struts2Utils;
import com.hanbang.oa.entity.security.Uploaded;
import com.hanbang.oa.service.UploadedService;




/**
 * 下载组件Action
 * 
 * @author 张敏明
 * 
 */
public class FileDownloadAction extends BaseAction
{
	private static final long serialVersionUID = 1L;

	private InputStream downFile = null;;

	private String fileName;

	@Resource
	private UploadedService uploadedService;



	public InputStream getDownFile()
	{
		return downFile;
	}


	public String getFileName()
	{
		return fileName;
	}


	/**
	 * 下载附件方法
	 * 
	 * @return
	 * @throws Exception
	 */
	public String download() throws Exception
	{

		if (getKey() == null)
			return ERROR;

		Uploaded u = uploadedService.get(getKey());
		fileName = new String(u.getName().getBytes(), "ISO8859-1");
		downFile = new FileInputStream(u.getPath());
		return SUCCESS;
	}


	/**
	 * 删除附件方法
	 * 
	 * @return
	 * @throws Exception
	 */
	public String deleteFile() throws Exception
	{
		if (getKey() == null)
			return ERROR;
		Uploaded u = uploadedService.get(getKey());
		File file = new File(u.getPath());
		Boolean isDel = file.delete();
		if (isDel)
		{
			uploadedService.delete(u.getId());
		}
		return Struts2Utils.renderText(isDel.toString());
	}
}
