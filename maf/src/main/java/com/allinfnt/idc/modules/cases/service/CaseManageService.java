/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cases.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.modules.cases.entity.CaseManage;
import com.allinfnt.idc.modules.cases.entity.CaseSteps;
import com.allinfnt.idc.modules.item.entity.ItemPath;
import com.allinfnt.idc.modules.item.service.ItemPathService;
import com.allinfnt.idc.modules.obj.entity.ObjManage;
import com.allinfnt.idc.modules.obj.entity.ObjMethod;
import com.allinfnt.idc.modules.obj.service.ObjManageService;
import com.allinfnt.idc.modules.obj.service.ObjMethodService;
import com.allinfnt.idc.modules.cases.dao.CaseManageDao;
import com.allinfnt.idc.modules.cases.dao.CaseStepsDao;

/**
 * 用例管理Service
 * @author xusuojian
 * @version 2015-12-08
 */
@Service
@Transactional(readOnly = true)
public class CaseManageService extends CrudService<CaseManageDao, CaseManage> {

	@Autowired
	private CaseStepsDao caseStepsDao;
	@Autowired
	private ObjManageService objManageService;
	@Autowired
	private CaseManageDao caseManageDao;
	@Autowired
	private ItemPathService itemPathService;
	@Autowired
	private ObjMethodService objMethodService;
	
	
	public CaseManage get(String id) {
		 return super.get(id);
	}
	
	public List<CaseManage> findList(CaseManage caseManage) {
		return super.findList(caseManage);
	}
	
	public Page<CaseManage> findPage(Page<CaseManage> page, CaseManage caseManage) {
		return super.findPage(page, caseManage);
	}
	
	@Transactional(readOnly = false)
	public void save(CaseManage caseManage,HttpServletRequest request) {
		
		super.save(caseManage);
		
		//用例步骤
		String[] objIds = request.getParameterValues("objId");  //关联对象的id
		String[] sorts = request.getParameterValues("sort");
	//	String[] objNames = request.getParameterValues("objName");
		String[] types = request.getParameterValues("type");
		String[] params = request.getParameterValues("param");
		String[] motions = request.getParameterValues("motion");
		String[] screenshots = request.getParameterValues("screenshot"); 
		String[] waitTimes = request.getParameterValues("waitTime");
		
		String motionData = request.getParameter("motionData");
		String[] motionDatas = motionData.split(","); //动态参数的数据
		
		String stepDetail = "";
		int p = 1;
	//	String flag = ""; //不需要进行切换iframe操作
		for (int i = 0; i < sorts.length; i++) { //用例步骤
			//取到所有用例步骤 拼成一个字符串
			//种接方式      s = sort$唯一值$type+值$motion$param$screenshot || sort$caseId$type+值$motion$param$screenshot ||...
			ObjManage objManage = objManageService.get(objIds[i]); 
			ItemPath itemPath = itemPathService.get(objManage.getPathId());
			String methodName = motionDatas[Integer.valueOf(motions[i]).intValue()]; //选中动作的text值 
			//根据方法名查询默认值
			ObjMethod objm = objMethodService.findDefaultValByMethodName(methodName);
			String defaultVal = objm.getDefaultVal();
			
			String typeCode = " ";
			if(types[i].equals("0")){  // 0 xpath 1 jquery 2 default
				typeCode = objManage.getXpathCode();
			}else if(types[i].equals("1")){
				typeCode = objManage.getJqueryCode();
			}else if(types[i].equals("2")){
				typeCode = "default";
			}
			
			String param = "";
			if(params[i].equals("0")){   // 0 default 1 自定义 2 空
				param = defaultVal ;
			}else if(params[i].equals("1")){
				param = "#param" + p + "#";
				p++;
			}else if(params[i].equals("2")){
				param = "null" ;
			}
			
				if(i==0){   //执行顺序$路径名称$路径表达式=_=执行顺序$caseId$对象寻址类型+值$动作默认值$参数$是否截图|执行顺序$路径名称$路径表达式$caseId$对象寻址类型$动作默认值$参数$等待时间$ret值$是否截图|....
					stepDetail = sorts[i]+"$" + itemPath.getItemPath() +"$" +itemPath.getExpression()  +"=_="+ sorts[i]+"$" + caseManage.getId() +"$"+ types[i] + "+" +typeCode +"$"+ methodName +"$"+ param +"$"+ waitTimes[i] +"$ret" +sorts[i] +"$"+ screenshots[i]  ;
				}else{ 
					stepDetail +="|"+ sorts[i]+"$" + itemPath.getItemPath() +"$" +itemPath.getExpression()  +"=_="+ sorts[i]+"$" + caseManage.getId() +"$"+ types[i] + "+" +typeCode +"$"+ methodName +"$"+ param +"$"+ waitTimes[i] +"$ret" +sorts[i] +"$"+ screenshots[i]  ;
				}
		}
		logger.info("stepDetail:"+stepDetail);
		
		
		//stepDetail按sort排序
		String stepDetailTemp = "";
		String[] split = stepDetail.split("\\|");
		
		int minIndex=0;
	    String temp = "";
	    for(int i=0;i<split.length-1;i++)  {
	        minIndex=i;//无序区的最小数据数组下标
	        for(int j=i+1;j<split.length;j++){
	            //在无序区中找到最小数据并保存其数组下标
	            if(Integer.valueOf(split[j].charAt(0)).intValue() < Integer.valueOf(split[minIndex].charAt(0)).intValue()){
	                minIndex=j;
	            }
	        }
	        if(minIndex!=i)  {
	            //如果不是无序区的最小值位置不是默认的第一个数据，则交换之。
	            temp=split[i];
	            split[i]=split[minIndex];
	            split[minIndex]=temp;
	        }
	    }
	    
	    //排序后重新拼接
		for (int i = 0; i < split.length; i++) {
			if(i==0){  
				stepDetailTemp = split[i] ;
			}else{ //需要进行切换iframe操作
				stepDetailTemp +="|"+split[i] ;
			}
		}
		
		logger.info("stepDetailTemp:"+stepDetailTemp);
		caseManage.setStepDetail(stepDetailTemp);
		
		//测试数据   testName+i   多个  先取i的值    所有数据也拼成一个字符串
		String testData = "";
		String[] nums = request.getParameterValues("num");
	//	String[] caseNameTests = request.getParameterValues("caseNameTest");
	//	String[] testNameTemps = request.getParameterValues("testNameTemp");
		String number = request.getParameter("number");
		int n = Integer.valueOf(number).intValue();
		for (int i = 0; i < nums.length; i++) {
			if(i==0){
				String  testn = "";
				for (int j = 1; j <= n; j++) {
					if(j==1){
						testn = "#param"+j +"#="+ request.getParameterValues("testName"+j)[i] ;
					}else{
						testn += "," + "#param"+j +"#="+  request.getParameterValues("testName"+j)[i] ;
					}
				}
				testData = testn ;
			}else{
				String  testn = "";
				for (int j = 1; j <= n; j++) {
					if(j==1){
						testn = "#param"+j +"#="+  request.getParameterValues("testName"+j)[i] ;
					}else{
						testn += "," + "#param"+j +"#="+ request.getParameterValues("testName"+j)[i] ;
					}
				}
				testData += "|" + testn ;
			}
		}
		
		logger.info("testData:"+testData);
		caseManage.setTestData(testData);
		
		caseManage.preUpdate();
		caseManageDao.update(caseManage);
		
		/**for (int i = 0; i < sorts.length; i++) { //用例步骤
			CaseSteps cs = new CaseSteps();
			cs.setSort(sorts[i]);
			cs.setObjName(objNames[i]);
			cs.setType(types[i]);
			cs.setParam(params[i]);
			cs.setMotion(motions[i]);
			cs.setScreenshot(screenshots[i]);
			cs.setCaseId(caseManage.getId());
			//取到所有用例步骤 拼成一个字符串
			cs.preInsert();
			caseStepsDao.insert(cs);
		}*/
		
	}
	
	@Transactional(readOnly = false)
	public void delete(CaseManage caseManage) {
		super.delete(caseManage);
	}
	
}