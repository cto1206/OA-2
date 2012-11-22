package com.hanbang.oa.service;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;
import javax.annotation.Resource;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import com.hanbang.core.service.EntityService;
import com.hanbang.oa.dao.UploadedDao;
import com.hanbang.oa.entity.security.Uploaded;




/**
 * 此类描述的是：附件上传管理类.
 * 
 * @author: 张敏明
 * @version: 2010-1-8 上午08:26:13
 */

@Service
public class UploadedService extends EntityService<Uploaded, Long>
{
	@Resource
	private UploadedDao uploadedDao;



	@Override
	protected UploadedDao getEntityDao()
	{
		return uploadedDao;
	}


	/**
	 * 为上传文件自动分配文件名称，避免重复
	 * 
	 * @param fileName
	 * @return
	 */
	protected String generateFileName(String fileName)
	{
		// 获得当前时间
		DateFormat format = new SimpleDateFormat("yyMMddHHmmss");
		// 转换为字符串
		String formatDate = format.format(new Date());
		// 随机生成文件编号
		int random = new Random().nextInt(10000);
		// 获得文件后缀名称
		int position = fileName.lastIndexOf(".");
		String extension = fileName.substring(position);
		// 组成一个新的文件名称
		return formatDate + random + extension;
	}


	/**
	 * 上传文件并保存文件到数据库
	 * 
	 * @return
	 * @throws Exception
	 */
	public void saveFile(Long tabId, String tab, String realPath, List<File> upload, List<String> uploadFileName) throws Exception
	{

		String[] mydir = new String[upload.size()];
		String[] tname = new String[upload.size()];

		for (int i = 0; i < upload.size(); i++)
		{
			// 生成保存文件的文件名称
			tname[i] = generateFileName(uploadFileName.get(i));

			// 保存文件的路径
			mydir[i] = realPath + "\\" + tname[i];

			// 建立一个目标文件
			File target = new File(realPath, tname[i]);

			// 将临时文件复制到目标文件
			FileUtils.copyFile(upload.get(i), target);
		}

		Uploaded uploaded = null;
		for (int i = 0; i < uploadFileName.size(); i++)
		{
			uploaded = new Uploaded();
			uploaded.setName(uploadFileName.get(i));
			uploaded.setRName(tname[i]);
			uploaded.setPath(mydir[i]);
			uploaded.setTabId(tabId);
			uploaded.setTab(tab);
			save(uploaded);
		}
	}


	/**
	 * 根据表名和表的主键查询附件信息列表
	 * 
	 * @param tabId
	 * @param tab
	 * @return 附件列表
	 */
	public List<Uploaded> findBy(Long tabId, String tab)
	{
		if (tabId == null || StringUtils.isEmpty(tab))
			return null;
		return getEntityDao().findBy(tabId, tab);
	}
}
