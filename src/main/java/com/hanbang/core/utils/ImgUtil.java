package com.hanbang.core.utils;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.util.Iterator;

import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.FileImageOutputStream;

/**
 * 
 *@author nzp 图片处理类
 */
public class ImgUtil {

	public static boolean createImage(File fileSrc, String pathDest,
			int widthDest, int heightDest) {
		return createImage(false, fileSrc, pathDest, widthDest, heightDest);
	}

	/**
	 *@return
	 *@param isForceWidthHeigthToDest
	 *            是否按设定目标的宽高强制生成图片
	 *@param fileSrc
	 *            源文件
	 *@param pathDest
	 *            生成图片的路径
	 *@param widthDest
	 *            目标图片宽（如果为-1，表示按原图比率设定宽度）
	 *@param heightDest
	 *            目标图片高（如果为-1，表示按原图比率设定高度）
	 */
	public static boolean createImage(boolean isForceWidthHeigthToDest,
			File fileSrc, String pathDest, int widthDest, int heightDest) {
		boolean flag = false;
		File out = null;

		try {
			// 如果目标宽高均小于0，则无法生成图片
			if (widthDest <= 0 && heightDest <= 0)
				return false;
			else if (widthDest <= 0 || heightDest <= 0)
				isForceWidthHeigthToDest = false;

			int w = 1;
			int h = 1;
			// 读取源图片
			Image imgSrc = javax.imageio.ImageIO.read(fileSrc);
			if (isForceWidthHeigthToDest) {
				w = widthDest;
				h = heightDest;
			} else {
				int width = imgSrc.getWidth(null);
				int height = imgSrc.getHeight(null);
				double imgRatio = width * 1.0 / height;
				if (widthDest > 0 && heightDest > 0) {
					w = widthDest;
					h = (int) (widthDest / imgRatio);
					if (h > heightDest) {
						w = (int) (heightDest * imgRatio);
						h = heightDest;
					}
				} 
				// 宽度无限制
				else if (widthDest <= 0) {
					w = (int) (heightDest * imgRatio);
					h = heightDest;
				} 
				// 高无限制
				else {
					w = widthDest;
					h = (int) (widthDest / imgRatio);
				}
			}
			BufferedImage tag = new BufferedImage(w, h,
					BufferedImage.TYPE_INT_RGB);
			tag.getGraphics().drawImage(imgSrc, 0, 0, w, h, null);
			out = new File(pathDest);
			flag = writeImageFile(out, tag, 80);

		} catch (Exception e) {
			flag = false;
			e.printStackTrace();
		} finally {
			try {
				if (out != null)
					out = null;
			} catch (Exception e) {

			}
		}
		return flag;
	}

	/**
	 *BufferedImage 编码输出硬盘上的图像文件
	 * 
	 * @param fileDest
	 *            编码输出的目标图像文件，文件名的后缀确定编码格式
	 *@param imageSrc
	 *            待编码的图像对象
	 *@param quality
	 *            编码的压缩比分比 return 返回编码输出成功与否
	 */
	public static boolean writeImageFile(File fileDest, BufferedImage imageSrc,
			int quality) {

		try {
			Iterator<ImageWriter> it = ImageIO.getImageWritersBySuffix("jpg");
			if (it.hasNext()) {
				FileImageOutputStream fileImageOutputStream = new FileImageOutputStream(
						fileDest);
				ImageWriter iw = (ImageWriter) it.next();

				ImageWriteParam iwp = iw.getDefaultWriteParam();
				iwp.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
				iwp.setCompressionQuality(quality / 100.0f);
				iw.setOutput(fileImageOutputStream);

				iw.write(null,
						new javax.imageio.IIOImage(imageSrc, null, null), iwp);
				iw.dispose();

				fileImageOutputStream.flush();
				fileImageOutputStream.close();

			}
		} catch (Exception ex) {
			ex.printStackTrace();
			return false;
		}
		return true;
	}
}
