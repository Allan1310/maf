/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.service;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.config.Canstants;
import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.common.utils.Encodes;
import com.allinfnt.idc.common.utils.excel.ExportExcel;
import com.allinfnt.idc.common.utils.excel.POIExcelUtil;
import com.allinfnt.idc.modules.cm.dao.CmHandleLogDao;
import com.allinfnt.idc.modules.cm.entity.CmHandleLog;
import com.allinfnt.idc.modules.sys.utils.UserUtils;


/**
 * 配置管理操作日志Service
 * @author liuzk
 * @version 2015-02-09
 */
@Service
@Transactional(readOnly = true)
public class CmHandleLogService extends CrudService<CmHandleLogDao, CmHandleLog> {
	
	public CmHandleLog get(String id) {
		return super.get(id);
	}
	
	public List<CmHandleLog> findList(CmHandleLog cmHandleLog) {
		return super.findList(cmHandleLog);
	}
	
	public Page<CmHandleLog> findPage(Page<CmHandleLog> page, CmHandleLog cmHandleLog) {
		return super.findPage(page, cmHandleLog);
	}
	
	@Transactional(readOnly = false)
	public void save(CmHandleLog cmHandleLog) {
		super.save(cmHandleLog);
	}
	
	@Transactional(readOnly = false)
	public void delete(CmHandleLog cmHandleLog) {
		super.delete(cmHandleLog);
	}
	
	// 把一个字符串的第一个字母大写、效率是最高的、
	public String getMethodName(String fildeName) throws Exception{
		byte[] items = fildeName.getBytes();
		items[0] = (byte) ((char) items[0] - 'a' + 'A');
		return new String(items);
	}

	/**
	 * 操作日志保存
	 * @param entity
	 * @param content
	 */
	@Transactional(readOnly = false)
	public void saveLog(String entity,String content){
		CmHandleLog cmHandleLog = new CmHandleLog();
		cmHandleLog.setHandler(UserUtils.getUser().getName());
		cmHandleLog.setHandleTime(Canstants.DATEFORMAT.format(new Date()));
		cmHandleLog.setEntityId(Canstants.getNotNullString(entity));
		cmHandleLog.setRemarks(Canstants.getNotNullString(content));
		super.save(cmHandleLog);
	}
	
	@SuppressWarnings("static-access")
	public void export(List<CmHandleLog> logs,HttpServletResponse response){

		try {
			ExportExcel ee = new ExportExcel();
			SXSSFWorkbook wb = new SXSSFWorkbook(logs.size());
			Map<String, CellStyle> styles = ee.createStyles(wb);
			CellStyle cellStyle = wb.createCellStyle();
			cellStyle.setBorderBottom(cellStyle.BORDER_THIN);
			cellStyle.setBorderLeft(cellStyle.BORDER_THIN);
			cellStyle.setBorderRight(cellStyle.BORDER_THIN);
			cellStyle.setBorderTop(cellStyle.BORDER_THIN);
			
			Sheet sheet = wb.createSheet("配置项操作日志");
			Row ciRow1 = sheet.createRow(1);
			ciRow1.setHeightInPoints(16);
			POIExcelUtil.createCell(0,"操作人",ciRow1,styles.get("title2"));
			POIExcelUtil.createCell(1,"操作实体",ciRow1,styles.get("title2"));
			POIExcelUtil.createCell(2,"操作日期",ciRow1,styles.get("title2"));
			POIExcelUtil.createCell(3,"操作描述",ciRow1,styles.get("title2"));
			
			for (int i = 0; i < logs.size(); i++) {
				Row ciRow = sheet.createRow(i+2);
				ciRow.setHeightInPoints(16);
				POIExcelUtil.createCell(0,logs.get(i).getHandler(),ciRow,null);
				POIExcelUtil.createCell(1,logs.get(i).getEntityId(),ciRow,null);
				POIExcelUtil.createCell(2,logs.get(i).getHandleTime(),ciRow,null);
				POIExcelUtil.createCell(3,logs.get(i).getRemarks(),ciRow,null);
			}
			
			response.reset();
			response.setContentType("application/octet-stream; charset=utf-8");
			response.setHeader("Content-Disposition", "attachment; filename="+Encodes.urlEncode("配置项日志文件-"+Canstants.DATEFORMAT_3.format(new Date())+ ".xlsx"));
			wb.write(response.getOutputStream()); 
			wb.dispose();
		} catch (IOException e) {
			e.printStackTrace();
		}
	
	}
	
	
}