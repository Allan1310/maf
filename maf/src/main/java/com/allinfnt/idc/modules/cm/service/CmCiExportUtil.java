package com.allinfnt.idc.modules.cm.service;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.allinfnt.idc.common.utils.DateUtils;
import com.allinfnt.idc.common.utils.excel.POIExcelUtil;
import com.allinfnt.idc.modules.cm.entity.CmAuditApply;
import com.allinfnt.idc.modules.cm.entity.CmAuditTrack;

/**
 * 报销导出公共类
 * @author liujx
 * @version 2015-03-16
 */
@Component
public class CmCiExportUtil  extends AbstractExcelView {
	
	@SuppressWarnings("unchecked")
	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook hs, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		HSSFSheet sheet = hs.getSheetAt(0);
		createSheet((List<CmAuditTrack>) model.get("auditTrackList"),sheet,(CmAuditApply)model.get("cmAuditApply"));
		sheet.setForceFormulaRecalculation(true);
		String fileName = "审计报告_" + DateUtils.getDate("yyyyMMddHHmmss")
				+ ".xls";
		
		fileName = new String(fileName.getBytes("GBK"), "ISO-8859-1");
		response.setHeader("Content-Disposition", "attachment; filename="
				+ fileName);
		response.setContentType("application/octet-stream; charset=utf-8");
	}

	/*
	 * {@inheritDoc}
	 */
	@Override
	public void render(Map<String, ?> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String fileName= "audit_report.xls";// 文件名称
		String templatePath = "docx" + File.separator + fileName;// 模版文件目录
		String projectRootPath = this.getClass().getClassLoader()
				.getResource("").getPath(); // 主目录
		templatePath = projectRootPath + templatePath;

		setUrl(templatePath);
		super.render(model, request, response);
	}

	/*
	 * {@inheritDoc}
	 */
	@Override
	protected HSSFWorkbook getTemplateSource(String url,
			HttpServletRequest request) throws Exception {
		POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(url));
		return new HSSFWorkbook(fs);
	}
	
	private void createSheet(List<CmAuditTrack> auditTrackList,HSSFSheet sheet,CmAuditApply cmAuditApply){
		int j = 0;
		getCell(sheet, 1, 2).setCellValue(cmAuditApply.getAuditNumber());
		getCell(sheet, 1, 5).setCellValue(cmAuditApply.getAuditReport());
		getCell(sheet, 2, 2).setCellValue(cmAuditApply.getAuditProject());
		getCell(sheet, 2, 5).setCellValue(cmAuditApply.getAuditProject());
		getCell(sheet, 3, 2).setCellValue(cmAuditApply.getAuditPurpose());
		getCell(sheet, 3, 5).setCellValue(cmAuditApply.getAuditTime());
		getCell(sheet, 4, 2).setCellValue(cmAuditApply.getAuditUser());
		getCell(sheet, 6, 0).setCellValue(cmAuditApply.getAuditScope());
		if(auditTrackList.size()>0){
			for(int i=0;i<auditTrackList.size();i++){
				CmAuditTrack detail = auditTrackList.get(i);
				if(i<=2){
					getCell(sheet, 9+i, 0).setCellValue(i+1);
					getCell(sheet, 9+i, 1).setCellValue(detail.getCiName());
					getCell(sheet, 9+i, 2).setCellValue(detail.getQuestion());
					getCell(sheet, 9+i, 3).setCellValue(detail.getDutyOfficer().getName());
					getCell(sheet, 9+i, 4).setCellValue(detail.getSolveStatus());
					getCell(sheet, 9+i, 5).setCellValue(detail.getPlanSolveTime());
					getCell(sheet, 9+i, 6).setCellValue(detail.getRealitySolveTime());
				}else{
					POIExcelUtil.insertRow(sheet, 12+j, 1);
					getCell(sheet, 12+j, 0).setCellValue(i+1);
					getCell(sheet, 12+j, 1).setCellValue(detail.getCiName());
					getCell(sheet, 12+j, 2).setCellValue(detail.getQuestion());
					getCell(sheet, 12+j, 3).setCellValue(detail.getDutyOfficer().getName());
					getCell(sheet, 12+j, 4).setCellValue(detail.getSolveStatus());
					getCell(sheet, 12+j, 5).setCellValue(detail.getPlanSolveTime());
					getCell(sheet, 12+j, 6).setCellValue(detail.getRealitySolveTime());
					j++;
				}
				
			}
		}
		
		if(j == 0){
			if(cmAuditApply.getAuditResult().equals("1")){
				getCell(sheet, 15, 2).setCellValue("√");
			}else{
				getCell(sheet, 16, 2).setCellValue("×");
			}
			
			getCell(sheet, 17, 2).setCellValue(cmAuditApply.getAuditSign());
		}else{
			if(cmAuditApply.getAuditResult().equals("1")){
				getCell(sheet, 15+j, 2).setCellValue("√");
			}else{
				getCell(sheet, 16+j, 2).setCellValue("×");
			}
			
			getCell(sheet, 17+j, 2).setCellValue(cmAuditApply.getAuditSign());
			getCell(sheet, 17+j, 2).setCellType(HSSFCell.CELL_TYPE_STRING);
		}
	}
	
	public static void main(String[] args) {
		FileOutputStream fileOut = null; 
		BufferedImage bufferImg = null; 
		//先把读进来的图片放到一个ByteArrayOutputStream中，以便产生ByteArray    
        try {  
            ByteArrayOutputStream byteArrayOut = new ByteArrayOutputStream();     
            bufferImg = ImageIO.read(new File("E:/workspace/idc/src/main/webapp/static/images/chat-user1.png"));     
            ImageIO.write(bufferImg, "jpg", byteArrayOut);  
              
            HSSFWorkbook wb = new HSSFWorkbook();     
            HSSFSheet sheet1 = wb.createSheet("test picture");    
            //画图的顶级管理器，一个sheet只能获取一个（一定要注意这点）  
            HSSFPatriarch patriarch = sheet1.createDrawingPatriarch();     
            //anchor主要用于设置图片的属性  
            HSSFClientAnchor anchor = new HSSFClientAnchor(0, 0, 44, 44,(short) 1, 1, (short) 5, 8);     
            anchor.setAnchorType(3);     
            //插入图片    
            patriarch.createPicture(anchor, wb.addPicture(byteArrayOut.toByteArray(), HSSFWorkbook.PICTURE_TYPE_PNG));   
            fileOut = new FileOutputStream("D:/测试Excel.xls");     
            // 写入excel文件     
             wb.write(fileOut);     
             System.out.println("----Excle文件已生成------");  
        } catch (Exception e) {  
            e.printStackTrace();  
        }finally{  
            if(fileOut != null){  
                 try {  
                    fileOut.close();  
                } catch (IOException e) {  
                    e.printStackTrace();  
                }  
            }  
        }  
	}
	
}
