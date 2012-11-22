package com.hanbang.oa.action;

import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.ActionSupport;

/**
 *@author ZoopNin 
 *文件下载
 */
public class DownloadFileAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	// 下载文件原始存放路径
	private final static String DOWNLOADFILEPATH = "/upload/";
	// 文件名参数变量
	private String fileName;

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	
	/**
	 *@return 
	 *从下载文件原始存放路径读取得到文件输出流
	 */
	public InputStream getDownloadFile() {
		
		return ServletActionContext.getServletContext().getResourceAsStream(
				DOWNLOADFILEPATH + fileName);
	}

	
	/**
	 * @return 
	 * 如果下载文件名为中文，进行字符编码转换
	 */
	public String getDownloadChineseFileName() {
		
		String downloadChineseFileName = fileName;

		try {
			downloadChineseFileName = new String(downloadChineseFileName
					.getBytes(), "ISO8859-1");

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return downloadChineseFileName;
	}

	public String execute() {
		return SUCCESS;
	}
}
