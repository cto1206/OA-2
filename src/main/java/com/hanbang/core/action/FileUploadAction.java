package com.hanbang.core.action;

import java.io.File;
import java.util.List;
import org.apache.struts2.ServletActionContext;




/**
 * 上传组件Action
 * 
 * @author 张敏明
 * 
 */
abstract public class FileUploadAction<T> extends CRUDActionSupport<T>
{
	private static final long serialVersionUID = 1L;

	// 上传文件对象列表
	private List<File> upload;

	// 上传文件名列表
	private List<String> uploadFileName;

	// 上传文件类型列表
	private List<String> uploadContentType;



	/**
	 * 获取上传路径
	 * 
	 * @return
	 */
	@SuppressWarnings("deprecation")
	protected String getUploadPath()
	{
		return ServletActionContext.getRequest().getRealPath("/upload");
	}


	public List<File> getUpload()
	{
		return upload;
	}


	public void setUpload(List<File> upload)
	{
		this.upload = upload;
	}


	public List<String> getUploadFileName()
	{
		return uploadFileName;
	}


	public void setUploadFileName(List<String> uploadFileName)
	{
		this.uploadFileName = uploadFileName;
	}


	public List<String> getUploadContentType()
	{
		return uploadContentType;
	}


	public void setUploadContentType(List<String> uploadContentType)
	{
		this.uploadContentType = uploadContentType;
	}

}
