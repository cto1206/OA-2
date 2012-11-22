package com.hanbang.oa.action;

import java.io.File;

import com.hanbang.core.utils.Constants;
import com.hanbang.core.utils.ImgUtil;
import com.opensymphony.xwork2.ActionSupport;

public class UploadImageFileAction extends ActionSupport{
	private static final long serialVersionUID = 1L;

	private File file ;
	
	private String fileName ;
	
	private String fileContentType ;

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}
	
	public String upload()throws Exception {
		String str = null ;
		String detPath = Constants.REAL_IMG_UPLOAD + this.getFileName();
		if(ImgUtil.createImage(this.getFile(), detPath, Constants.INIT_IMG_WIDTH,Constants.INIT_IMG_HEIGHT)){
			str = SUCCESS ;
		}else{
			this.addFieldError("file","文件上传失败！") ;
			str = ERROR ;
		}
		return str ;
	}
	
}
