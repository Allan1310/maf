package com.allinfnt.idc.modules.sys.utils;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.web.multipart.MultipartFile;

import com.allinfnt.idc.common.utils.excel.ImportExcel;

/**
 * @author 作者 E-mail: 蒋斌
 * @version 创建时间：2015年1月29日 下午2:30:48
 * @memo 说明：导入文件工具类
 */
public class ImportUtils {
	
	/**
	 * @author 作者：蒋斌
	 * @version 创建时间：2015年1月29日下午2:43:35
	 * @params 参数:工作日excel文件
	 * @return: List
	 * @memo 说明:返回工作日集合
	 */
	public static List<String> encapsulationData(MultipartFile multipartFile){
		List<String> dataList = new ArrayList();
		try{
			ImportExcel ei = new ImportExcel(multipartFile, 0, 0);
			for (int i = ei.getDataRowNum(); i <= ei.getLastDataRowNum(); i++) {
				Row row = ei.getRow(i);
				for (int j = 0; j <= ei.getLastCellNum(); j++) {
					Cell cell = row.getCell(j);
					if(cell != null){
						//判断是否为日期格式数据
						if(HSSFDateUtil.isCellDateFormatted(cell)){
							DateFormat formater = new SimpleDateFormat("yyyy-MM-dd");
							dataList.add(formater.format(cell.getDateCellValue()));
						}else{
							if(cell.getStringCellValue() != null && !"".equals(cell.getStringCellValue())){
								dataList.add(cell.getStringCellValue());
							}
						}
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return dataList;
	}
}
