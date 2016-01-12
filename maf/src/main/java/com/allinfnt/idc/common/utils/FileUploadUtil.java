package com.allinfnt.idc.common.utils;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest;

import com.allinfnt.idc.common.config.Global;
import com.allinfnt.idc.common.web.Servlets;
import com.allinfnt.idc.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.allinfnt.idc.modules.sys.utils.UserUtils;
import com.google.common.collect.Lists;

/**
 * 文件上传信息Service
 * 
 * @author allen
 * @version 2014-2-26
 */
@Service
@Transactional(readOnly = true)
public class FileUploadUtil {

	public static final String SUCCESS = "success";
	public static final String ERROR = "error";
	public static final String STATUS = "status";
	public static final String MESSAGE = "message";

	private static final Long MAX_FILE_SIZE = 1024 * 1024 * (Long
			.valueOf(Global.getConfig("upload_file_max_size")));// 5M

	private static final String PIC_EXT = Global
			.getConfig("upload_file_suffix");

	private static boolean uploadFileAndCallback(MultipartFile file,//new File("") new Map<>()
			Map<String, Object> jsonMap) throws IOException {
		if (validateFile(file, jsonMap)) {
			String filename = file.getOriginalFilename();
			String fileFullPath = jsonMap.get("filePath").toString();
			File dir = new File(fileFullPath);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			FileCopyUtils.copy(file.getBytes(), new File(fileFullPath + "/"
					+ filename));

			jsonMap.put("filePath", fileFullPath + "/" + filename);
			jsonMap.put("fileUrl", jsonMap.get("fileUrl").toString() + "/"
					+ filename);

			jsonMap.put(STATUS, SUCCESS);
			jsonMap.put(SUCCESS, "true");
			return true;
		} else {
			jsonMap.put(STATUS, ERROR);
			jsonMap.put(SUCCESS, "false");
			System.out.println("上传文件不符合规格");
			return false;
		}

	}

	private static boolean validateFile(MultipartFile file,
			Map<String, Object> jsonMap) {
		if (file.getSize() < 0 || file.getOriginalFilename().equals("")) {
			jsonMap.put(MESSAGE, "未找到文件");
			return false;
		}
		if (file.getSize() > MAX_FILE_SIZE) {
			jsonMap.put(MESSAGE, "文件超过大小限制");
			return false;
		}
		String filename = file.getOriginalFilename();
		String extName = filename.substring(filename.lastIndexOf("."))
				.toLowerCase();
		for (String ext : PIC_EXT.split(",")) {
			if (extName.equals(ext)) {
				return true;
			}
		}
		jsonMap.put(MESSAGE, "上传文件类型不符合规格");
		return false;

	}

	/**
	 * 通过CKFinder上传文件
	 * 
	 * @param request
	 * @param fileName
	 *            文件名
	 * @param type
	 *            文件类型 files、images、flash、thumb
	 * @param module
	 *            文件模块 photo
	 * @return
	 * @throws IOException
	 */
	public static List<String> uploadByCKFinder(
			DefaultMultipartHttpServletRequest request, String fileName,
			String type, String module) throws IOException {
		List<String> fileList = Lists.newArrayList();
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<MultipartFile> mfs = request.getFiles(fileName);

		Principal principal = UserUtils.getPrincipal();

		String path = Global.USERFILES_BASE_URL + principal + "/" + type + "/"
				+ module + "/" + DateUtils.getYear() + "/"
				+ DateUtils.getMonth();
		String filePath = FileUtils.path(Global.getUserfilesBaseDir() + "/"
				+ path);
		String fileUrl = FileUtils.path(Servlets.getRequest().getContextPath()
				+ "/" + path);
		jsonMap.put("filePath", filePath);
		jsonMap.put("fileUrl", fileUrl);
		for (MultipartFile mf : mfs) {
			Boolean ok = uploadFileAndCallback(mf, jsonMap);
			if (ok) {
				fileList.add("/"+jsonMap.get("fileUrl").toString());
			} else {
				String error = jsonMap.get(FileUploadUtil.MESSAGE).toString();
				if (error.equals("未找到文件")) {

				} else {
					throw new IOException(error);
				}

			}
		}
		return fileList;
	}
}
