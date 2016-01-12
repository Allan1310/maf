/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.allinfnt.idc.common.config.Canstants;
import com.allinfnt.idc.common.mapper.JsonMapper;
import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.common.utils.Encodes;
import com.allinfnt.idc.common.utils.JsonUtils;
import com.allinfnt.idc.common.utils.excel.ExportExcel;
import com.allinfnt.idc.common.utils.excel.POIExcelUtil;
import com.allinfnt.idc.modules.cm.dao.CmCiInstanceDao;
import com.allinfnt.idc.modules.cm.dao.CmCiInstanceHiDao;
import com.allinfnt.idc.modules.cm.dao.CmCiPropertyDao;
import com.allinfnt.idc.modules.cm.dao.CmCiPropertyHiDao;
import com.allinfnt.idc.modules.cm.entity.CmCiGroup;
import com.allinfnt.idc.modules.cm.entity.CmCiInstance;
import com.allinfnt.idc.modules.cm.entity.CmCiInstanceHi;
import com.allinfnt.idc.modules.cm.entity.CmCiProperty;
import com.allinfnt.idc.modules.cm.entity.CmCiRelation;
import com.allinfnt.idc.modules.cm.entity.CmPropertyManage;
import com.allinfnt.idc.modules.sys.dao.UserDao;
import com.allinfnt.idc.modules.sys.entity.Dict;
import com.allinfnt.idc.modules.sys.entity.User;
import com.allinfnt.idc.modules.sys.utils.DictUtils;
import com.allinfnt.idc.modules.sys.utils.UserUtils;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 配置项管理Service
 * @author liuzk
 * @version 2015-01-22
 */
@Service
@Transactional(readOnly = true)
public class CmCiInstanceService extends CrudService<CmCiInstanceDao, CmCiInstance> {
	
	@Autowired
	private UserDao userDao;
	@Autowired
	private CmCiPropertyDao cmCiPropertyDao;
	@Autowired
	private CmCiInstanceDao cmCiInstanceDao;
	@Autowired
	private CmCiPropertyHiDao cmCiPropertyHiDao;
	@Autowired
	private CmCiInstanceHiDao cmCiInstanceHiDao;
	@Autowired
	private CmHandleLogService cmHandleLogService;
	@Autowired
	private CmCiRelationService cmCiRelationService;
	
	public CmCiInstance get(String id) {
		return super.get(id);
	}
	
	public List<CmCiInstance> findList(CmCiInstance cmCiInstance) {
		return super.findList(cmCiInstance);
	}
	
	public Page<CmCiInstance> findPage(Page<CmCiInstance> page, CmCiInstance cmCiInstance) {
		if(cmCiInstance!=null&&cmCiInstance.getCreateBy()!=null&&!Canstants.getNotNullString(cmCiInstance.getCreateBy().getName()).equals("")){
			cmCiInstance.setCreateBy(userDao.getUserByName(cmCiInstance.getCreateBy().getName()));
		}
		cmCiInstance.getSqlMap().put("dsf", dataScopeFilter(UserUtils.getUser(), "o", "u","cm"));
		return super.findPage(page, cmCiInstance);
	}
	
	@Transactional(readOnly = false)
	public void save(CmCiInstance cmCiInstance) {
		super.save(cmCiInstance);
	}
	
	@Transactional(readOnly = false)
	public void delete(CmCiInstance cmCiInstance) {
		super.delete(cmCiInstance);
	}
	
	/**
	 * 根据参数查询配置项列表
	 * @author liuzk
	 * @param page
	 * @param cmCiInstance
	 * @return
	 */
	public Page<CmCiInstance> findListByParam(Page<CmCiInstance> page, CmCiInstance cmCiInstance) {
		cmCiInstance.setPage(page);
		page.setList(dao.findListByParam(cmCiInstance));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(CmCiProperty entity){
		if (entity.getIsNewRecord()){
			entity.preInsert();
			cmCiPropertyDao.insert(entity);
		}else{
			entity.preUpdate();
			cmCiPropertyDao.update(entity);
		}
	}
	
	/**
	 * 根据配置项编号查询配置项属性
	 * @param ciId
	 * @return
	 */
	public List<CmCiProperty> findEntityByCiId(String ciId){
		return cmCiPropertyDao.findEntityByCiId(ciId);
		
	}
	
	/**
	 * 查询配置项模型
	 * 
	 * @param page
	 * @param ciInstance
	 * @return
	 */
	public Page<CmCiInstance> findPageIsModel(Page<CmCiInstance> page,
			CmCiInstance cmCiInstance) {
		cmCiInstance.setPage(page);
		page.setList(cmCiInstanceDao.findPageIsModel(cmCiInstance));
		return page;
	}

	/**
	 * 导出配置项模型
	 * 
	 * @param cmCiInstance
	 * @param request
	 * @param response
	 * @param TYSXList
	 * @param propertyNameList
	 */
	@SuppressWarnings("static-access")
	public void exportModel(CmCiInstance cmCiInstance,
			HttpServletRequest request, HttpServletResponse response,
			List<CmPropertyManage> TYSXList, List<String> propertyNameList) {
		try {
			ExportExcel ee = new ExportExcel();
			SXSSFWorkbook wb = new SXSSFWorkbook(500);
			Sheet sheet = wb.createSheet(cmCiInstance.getCmCiGroup().getGroupName()+"类配置项模型");
			
			CellStyle cellStyle = wb.createCellStyle();
			cellStyle.setBorderBottom(cellStyle.BORDER_THIN);
			cellStyle.setBorderLeft(cellStyle.BORDER_THIN);
			cellStyle.setBorderRight(cellStyle.BORDER_THIN);
			cellStyle.setBorderTop(cellStyle.BORDER_THIN);
			for(int i = 2; i<50; i++){
				Row row = sheet.createRow(i);
				for (int j = 0; j < propertyNameList.size(); j++) {
					Cell cell = row.createCell(j);
					cell.setCellStyle(cellStyle);
				}
			}
			
			Map<String, CellStyle> styles = ee.createStyles(wb);
			Row titleRow = sheet.createRow(0);
			titleRow.setHeightInPoints(30);
			Cell titleCell = titleRow.createCell(0);
			titleCell.setCellStyle(styles.get("title"));
			titleCell.setCellValue(cmCiInstance.getCiName());
			sheet.addMergedRegion(new CellRangeAddress(titleRow.getRowNum(),
					titleRow.getRowNum(), titleRow.getRowNum(),
					propertyNameList.size() -1));
			
			Row headerRow = sheet.createRow(1);
			headerRow.setHeightInPoints(16);
			for (int j = 0; j < propertyNameList.size(); j++) {
				POIExcelUtil.createCell(j, propertyNameList.get(j), headerRow, styles.get("header"));
			}
			
			List<Dict> dictList = Lists.newArrayList();
			dictList = DictUtils.getDictList("ci_status_a");
			POIExcelUtil.setValidationData(dictList, sheet, 2, 100, 1, 1);
			dictList = DictUtils.getDictList("ci_status_b");
			POIExcelUtil.setValidationData(dictList, sheet, 2, 100, 2, 2);
			
			for (int j = 0; j < TYSXList.size(); j++) {
				if ("2".equals(TYSXList.get(j).getDataType())) {
					dictList = DictUtils.getDictList(TYSXList.get(j).getExt1());
					POIExcelUtil.setValidationData(dictList, sheet, 2, 100, j+3, j+3);
				}
			}
			for (int i = 0; i < propertyNameList.size(); i++) {
				int colWidth = sheet.getColumnWidth(i) * 2;
				sheet.setColumnWidth(i, colWidth < 3000 ? 3000 : colWidth);
			}
			
			response.reset();
			response.setContentType("application/octet-stream; charset=utf-8");
			response.setHeader("Content-Disposition", "attachment; filename="
					+ Encodes.urlEncode(cmCiInstance.getCiName() +"-"+cmCiInstance.getCmCiGroup().getId()+ ".xlsx"));
			wb.write(response.getOutputStream()); 
			wb.dispose();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 更新配置项
	 * @param id
	 * @param handle 操作类型 （0：新增，1：修改）
	 */
	@Transactional(readOnly = false)
	public void updateCiInstance(String id,String handle){
		CmCiInstance entity = super.get(id);
		entity.setStatus("1");
		if(handle.equals("1")){
			List<CmCiProperty> ciPropertys = findEntityByCiId(id);
			//保存配置项到历史表
			cmCiInstanceDao.saveInstanceHi(id);
			
			//保存属性历史版本
			cmCiPropertyDao.savePropertyHi(id);
			cmCiPropertyDao.updatePropertyHi(id,entity.getCiVersion());
			
			String version = Canstants.getStringFromFinal(entity.getRemarks(),"version");
			if(!Canstants.getNotNullString(version).equals("")){
				entity.setCiVersion(Canstants.getNewVersionStr(version));
			}else{
				entity.setCiVersion(Canstants.getVersionString(entity.getCiVersion()));
			}
			
			//循环更新属性数据
			for(CmCiProperty ciProperty:ciPropertys){
				if(ciProperty.getHandleStatus().equals("1")){
					//更新数据
					ciProperty.setPropertyValue(ciProperty.getPropertyUpdateValue());
					if(ciProperty.getProperty().getPropertyName().equals("设备名称")){
						entity.setCiName(ciProperty.getPropertyUpdateValue());
					}
					if(ciProperty.getProperty().getPropertyName().equals("设备编号")){
						entity.setCiNumber(ciProperty.getPropertyUpdateValue());
					}
					ciProperty.setHandle("0");
					ciProperty.setHandleStatus("0");
					ciProperty.setPropertyUpdateValue("");
				}
				ciProperty.setCiVersion(entity.getCiVersion());
				save(ciProperty);
			}
			
			
			String statusA = Canstants.getStringFromFinal(entity.getRemarks(),"statusA");
			if(!Canstants.getNotNullString(statusA).equals("")){
				entity.setCiStatusA(statusA);
			}
			
			String statusB = Canstants.getStringFromFinal(entity.getRemarks(),"statusB");
			if(!Canstants.getNotNullString(statusB).equals("")){
				entity.setCiStatusB(statusB);
			}
			
			entity.setRemarks("");
		}else if(handle.equals("2")){
			List<CmCiRelation> reRelations = Lists.newArrayList();
			CmCiRelation cmCiRelation = new CmCiRelation();
			cmCiRelation.setCiInstance(entity);
			reRelations.addAll(cmCiRelationService.findList(cmCiRelation));
			reRelations.addAll(cmCiRelationService.findListByReid(entity.getId()));
			if(reRelations.size()>0){
				for(CmCiRelation relation:reRelations){
					cmCiRelationService.delete(relation);
				}
			}
			super.delete(entity);
		}
		super.save(entity);
	}
	
	@Transactional(readOnly = false)
	public void insert(CmCiInstance entity){
		entity.preInsert();
		cmCiInstanceDao.insert(entity);
	}
	
	
	/**
	 * 配置项报表导出
	 * @param cmCiInstance
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @param ids
	 */
	@SuppressWarnings("static-access")
	@Transactional(readOnly = false)
	public void exportReport(CmCiInstance cmCiInstance,HttpServletRequest request, 
									HttpServletResponse response,RedirectAttributes redirectAttributes, String ids) {
		try {
			ExportExcel ee = new ExportExcel();
			SXSSFWorkbook wb = new SXSSFWorkbook(500);
			Map<String, CellStyle> styles = ee.createStyles(wb);
			CellStyle cellStyle = wb.createCellStyle();
			cellStyle.setBorderBottom(cellStyle.BORDER_THIN);
			cellStyle.setBorderLeft(cellStyle.BORDER_THIN);
			cellStyle.setBorderRight(cellStyle.BORDER_THIN);
			cellStyle.setBorderTop(cellStyle.BORDER_THIN);
			
			String[] id = ids.split(",");
			Map<String ,Object> sheetMap = new HashMap<String ,Object>();
			Map<String ,String> rowMap = new HashMap<String ,String>();
			for (int i = 0; i < id.length; i++) {
				
				List<CmCiProperty> ciPropertys = Lists.newArrayList();
				List<CmCiProperty> TYProperty = Lists.newArrayList();
				List<CmCiProperty> ZYProperty = Lists.newArrayList();
				cmCiInstance = this.get(id[i]);
				
				//导出时记录日志
				cmHandleLogService.saveLog(cmCiInstance.getCiName() ,"配置项报表导出："+cmCiInstance.getCiName());
				
				ciPropertys = this.findEntityByCiId(id[i]);
				for(CmCiProperty cmCiProperty : ciPropertys){
					if(cmCiProperty.getProperty().getPropertyType().equals(Canstants.cm_property_TY)){
						TYProperty.add(cmCiProperty);
					}else{
						ZYProperty.add(cmCiProperty);
					}
				}
				List<CmCiProperty> newTYProperty = Lists.newArrayList();
				for(CmCiProperty ciProperty:TYProperty){
					if (ciProperty.getProperty().getPropertyName().indexOf("维护人员") > -1) {
						User user = userDao.get(ciProperty.getPropertyValue());;
						ciProperty.setPropertyValue(user.getName()); 
					}
					newTYProperty.add(ciProperty);
				}
				
				//判断分类sheet是否存在
				Sheet sheet = null;
				short rowNum = 0;
				if(sheetMap.get(cmCiInstance.getCmCiGroup().getGroupName()) != null){
					sheet = (Sheet) sheetMap.get(cmCiInstance.getCmCiGroup().getGroupName());
					rowNum = Integer.valueOf(rowMap.get(cmCiInstance.getCmCiGroup().getGroupName())).shortValue();
					rowMap.put(cmCiInstance.getCmCiGroup().getGroupName(), String.valueOf(rowNum+1));
				}else{
					sheet = wb.createSheet(cmCiInstance.getCmCiGroup().getGroupName());
					sheetMap.put(cmCiInstance.getCmCiGroup().getGroupName(), sheet);
					
					//新sheet设置头标题
					Row titleRow = sheet.createRow(0);
					titleRow.setHeightInPoints(30);
					cellStyle = wb.createCellStyle();
					cellStyle.setFillForegroundColor(IndexedColors.TEAL.getIndex());//设置背景颜色
					cellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
					POIExcelUtil.setAlignment(cellStyle);
					POIExcelUtil.setFont(wb, cellStyle, (short)18,"");
					POIExcelUtil.createCell(0,cmCiInstance.getCmCiGroup().getGroupName()+"类配置项详细属性信息",titleRow,cellStyle);
					sheet.addMergedRegion(new CellRangeAddress(titleRow.getRowNum(),titleRow.getRowNum(), titleRow.getRowNum(), 4+ZYProperty.size()+newTYProperty.size()));
					
					//生成全部字段名称
					Row ciRow1 = sheet.createRow(1);
					ciRow1.setHeightInPoints(16);
					POIExcelUtil.createCell(0,"编号",ciRow1,styles.get("title2"));
					POIExcelUtil.createCell(1,"配置项名称",ciRow1,styles.get("title2"));
					POIExcelUtil.createCell(2,"配置项分类",ciRow1,styles.get("title2"));
					POIExcelUtil.createCell(3,"运行状态",ciRow1,styles.get("title2"));
					POIExcelUtil.createCell(4,"使用状态",ciRow1,styles.get("title2"));
					
					for(int j = 0;j<newTYProperty.size();j++){
						POIExcelUtil.createCell(4+j+1,newTYProperty.get(j).getProperty().getPropertyName(),ciRow1,styles.get("title2"));
					}
					
					for(int k = 0;k<ZYProperty.size();k++){
						POIExcelUtil.createCell(4+k+newTYProperty.size()+1,ZYProperty.get(k).getProperty().getPropertyName(),ciRow1,styles.get("title2"));
					}
				
					rowMap.put(cmCiInstance.getCmCiGroup().getGroupName(), "3");
					rowNum = 2;
				}
				
				Row ciRow = sheet.createRow(rowNum);
				ciRow.setHeightInPoints(16);
				POIExcelUtil.createCell(0,String.valueOf(rowNum-1),ciRow,null);
				POIExcelUtil.createCell(1,cmCiInstance.getCiName(),ciRow,null);
				POIExcelUtil.createCell(2,cmCiInstance.getCmCiGroup().getGroupName(),ciRow,null);
				POIExcelUtil.createCell(3,DictUtils.getDictLabel(cmCiInstance.getCiStatusA(), "ci_status_a", ""),ciRow,null);
				POIExcelUtil.createCell(4,DictUtils.getDictLabel(cmCiInstance.getCiStatusB(), "ci_status_b", ""),ciRow,null);
				
				for(int j = 0;j<newTYProperty.size();j++){
					POIExcelUtil.createCell(4+j+1,newTYProperty.get(j).getPropertyValue(),ciRow,null);
				}
				
				for(int k = 0;k<ZYProperty.size();k++){
					POIExcelUtil.createCell(4+k+newTYProperty.size()+1,ZYProperty.get(k).getPropertyValue(),ciRow,null);
				}
			}
			
			response.reset();
			response.setContentType("application/octet-stream; charset=utf-8");
			response.setHeader("Content-Disposition", "attachment; filename="+Encodes.urlEncode("配置项报表文件"+new SimpleDateFormat("yyyyMMddHHmss").format(new Date())+ ".xlsx"));
			wb.write(response.getOutputStream()); 
			wb.dispose();
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 根据分类ID查询配置项
	 * @param groupId
	 * @return
	 */
	public List<CmCiInstance> findEntityByGroupId(String groupId){
		return dao.findEntityByGroupId(groupId);
		
	}
	
	/**
	 * 查询Ci实例信息
	 * @param jsonData
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String findCIByParameters(String jsonData){
		
		String jsonResult = "";
		Map<String, Object> jsonMap = JsonUtils.readJson2Map(jsonData);
		
		if(!Canstants.getNotNullString(jsonMap.get("serviceType")).equals("idc_cm_find_service")){
			return "NOT THE THRID PARTY";
		}
		
		Map<String, Object> paramMap = (Map<String, Object>)jsonMap.get("opDetail");
		if(jsonMap.get("selectType").equals("0")){
			CmCiInstance instance = get(Canstants.getNotNullString(paramMap.get("id")));
			jsonResult = JsonMapper.toJsonString(instance);
			
		}else if(jsonMap.get("selectType").equals("1")){
			CmCiInstance instance = new CmCiInstance();
			instance.setCiName(Canstants.getNotNullString(paramMap.get("ciName")));
			instance.setCiNumber(Canstants.getNotNullString(paramMap.get("ciNumber")));
			instance.setCmCiGroup(new CmCiGroup(Canstants.getNotNullString(paramMap.get("groupId"))));
			List<CmCiInstance> ciList = cmCiInstanceDao.findList(instance);
			jsonResult = JsonMapper.toJsonString(ciList);
		}
		
		return jsonResult;
		
	}
	
	/**
	 * 查询配置项属性
	 * @param jsonData
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String findCiProperty(String jsonData){
		
		String jsonResult = "";
		
		Map<String, Object> jsonMap = JsonUtils.readJson2Map(jsonData);
		
		if(!Canstants.getNotNullString(jsonMap.get("serviceType")).equals("idc_cm_property_service")){
			return "NOT THE THRID PARTY";
		}
		
		Map<String, Object> paramMap = (Map<String, Object>)jsonMap.get("opDetail");
		
		List<CmCiProperty> ciPropertys = findEntityByCiId(Canstants.getNotNullString(paramMap.get("id")));
		List<CmCiProperty> TYProperty = Lists.newArrayList();
		List<CmCiProperty> ZYProperty = Lists.newArrayList();
		for(CmCiProperty cmCiProperty : ciPropertys){
			if(cmCiProperty.getProperty().getPropertyType().equals(Canstants.cm_property_TY)){
				TYProperty.add(cmCiProperty);
			}else{
				ZYProperty.add(cmCiProperty);
			}
		}
		
		Map<String, Object> resultMap = Maps.newHashMap();
		resultMap.put("TYProperty", TYProperty);
		resultMap.put("ZYProperty", ZYProperty);
		jsonResult = JsonMapper.toJsonString(resultMap);
		return jsonResult;
		
	}
	
	/**
	 * 创建新的配置项基线
	 * @param baseLineV
	 */
	@Transactional(readOnly = false)
	public void createNewBaseLine(String baseLineV){
		List<CmCiInstance> ciList = cmCiInstanceDao.findList(new CmCiInstance());
		if(ciList.size()>0){
			for(CmCiInstance ciInstance:ciList){
				CmCiInstanceHi ciInstanceHi = new CmCiInstanceHi();
				ciInstanceHi.setId(ciInstance.getId());
				ciInstanceHi.setCiNumber(ciInstance.getCiNumber());
				ciInstanceHi.setCiName(ciInstance.getCiName());
				ciInstanceHi.setCiVersion(baseLineV);
				ciInstanceHi.setCmCiGroup(ciInstance.getCmCiGroup());
				ciInstanceHi.setStatus(ciInstance.getStatus());
				ciInstanceHi.setCiStatusA(ciInstance.getCiStatusA());
				ciInstanceHi.setCiStatusB(ciInstance.getCiStatusB());
				ciInstanceHi.setExt1(ciInstance.getExt1());
				ciInstanceHi.setExt2(ciInstance.getExt2());
				ciInstanceHi.setCreateBy(ciInstance.getCreateBy());
				ciInstanceHi.setCreateDate(ciInstance.getCreateDate());
				ciInstanceHi.setUpdateBy(ciInstance.getUpdateBy());
				ciInstanceHi.setUpdateDate(ciInstance.getUpdateDate());
				ciInstanceHi.setRemarks(ciInstance.getRemarks());
				ciInstanceHi.setDelFlag(ciInstance.getDelFlag());
				cmCiInstanceHiDao.insert(ciInstanceHi);
			}
		}
	}

	/**
	 * 更改配置项属性
	 * @param groupId 分类ID
	 * @param propertyIds 属性ID
	 * @param handle 操作（del：删除，add：增加）
	 */
	@Transactional(readOnly = false)
	public void updateInstanceProperty(String groupId ,List<String> propertyIds ,String handle){
		
		try {
			CmCiInstance ciInstance = new CmCiInstance();
			CmCiGroup group = new CmCiGroup();
			group.setId(groupId);
			ciInstance.setCmCiGroup(group);
			List<CmCiInstance> instances = cmCiInstanceDao.findList(ciInstance);
			if(instances.size()>0){
				for(CmCiInstance instance : instances){
					//保存配置项到历史表
					cmCiInstanceDao.saveInstanceHi(instance.getId());
					
					//保存属性历史版本
					cmCiPropertyDao.savePropertyHi(instance.getId());
					
					if(handle.equals("del")){
						for(String propertyId:propertyIds){
							cmCiPropertyDao.delProperty(instance.getId(), propertyId);
						}
					}else if(handle.equals("add")){
						for(String propertyId:propertyIds){
							CmPropertyManage propertyM = new CmPropertyManage();
							propertyM.setId(propertyId);
							CmCiProperty ciProperty = new CmCiProperty();
							ciProperty.setCiId(instance.getId());
							ciProperty.setCiVersion(Canstants.getVersionString(instance.getCiVersion()));
							ciProperty.setProperty(propertyM);
							ciProperty.setPropertyValue("");
							ciProperty.setStatus("0");
							ciProperty.setHandle("0");
							ciProperty.setHandleStatus("0");
							save(ciProperty);
						}
					}
					instance.setCiVersion(Canstants.getVersionString(instance.getCiVersion()));
					save(instance);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 配置项版本回退
	 * @param cmCiInstance
	 */
	@Transactional(readOnly = false)
	public void versionRollback(CmCiInstance cmCiInstance){
		
		//查询要回退的历史版本信息
		CmCiInstanceHi hiInstance = cmCiInstanceHiDao.findEntityHiByCiId(cmCiInstance.getId(),cmCiInstance.getCiVersion());
		List<CmCiProperty> hiPropertys = cmCiPropertyHiDao.findEntityHiByCiId(cmCiInstance.getId(),cmCiInstance.getCiVersion());
		
		CmCiInstance instance = this.get(hiInstance.getId());
		List<CmCiProperty> propertys = this.findEntityByCiId(cmCiInstance.getId());
		
		//保存配置项到历史表
		cmCiInstanceDao.saveInstanceHi(cmCiInstance.getId());
		//保存属性历史版本
		cmCiPropertyDao.savePropertyHi(cmCiInstance.getId());
		
		//更新配置项信息
		instance.setCiName(hiInstance.getCiName());
		instance.setCiNumber(hiInstance.getCiNumber());
		instance.setCiStatusA(hiInstance.getCiStatusA());
		instance.setCiStatusB(hiInstance.getCiStatusB());
		instance.setCmCiGroup(hiInstance.getCmCiGroup());
		instance.setCiVersion(Canstants.getVersionString(instance.getCiVersion()));
		instance.setUpdateDate(new Date());
		this.save(instance);
		
		//更新配置项属性信息
		for(CmCiProperty property : propertys){
			for(CmCiProperty hiProperty : hiPropertys){
				if((property.getProperty().getId().equals(hiProperty.getProperty().getId()))&&
							(!hiProperty.getPropertyValue().equals(property.getPropertyValue()))){
					property.setPropertyValue(hiProperty.getPropertyValue());
					property.setCiVersion(instance.getCiVersion());
					this.save(property);
				}
			}
		}
		
	}
}