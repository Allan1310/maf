package com.allinfnt.idc.modules.script.maker;
import java.util.ArrayList;

import com.allinfnt.idc.modules.script.db.MySQLHandler;

public class PagePath {

	private String stepPathDetail = null;
	
	private ArrayList<PagePathStep> pagePathStepList = new ArrayList<PagePathStep>();
	
	public PagePath(){
		stepPathDetail = "1$公共路径$ |2$公共路径$ |3$公共路径$ |4$公共路径$ |5$公共路径$ |6$公共路径$ |7$rightContentFrame$//iframe[@id='rightContentFrame']|8$rightContentFrame$//iframe[@id='rightContentFrame']|9$rightContentFrame$//iframe[@id='rightContentFrame']|10$rightContentFrame$//iframe[@id='rightContentFrame']|11$rightContentFrame$//iframe[@id='rightContentFrame']|12$rightContentFrame$//iframe[@id='rightContentFrame']|13$rightContentFrame$//iframe[@id='rightContentFrame']|14$rightContentFrame$//iframe[@id='rightContentFrame']|15$rightContentFrame$//iframe[@id='rightContentFrame']";
	}
	
	public PagePath(String testCaseId){
		stepPathDetail = MySQLHandler.getTestStepDetail(testCaseId).split("=_=")[0];
	}

	
	public void getpagePathStepList() {
		String[] step = stepPathDetail.split("\\|");
		//System.out.println(step.length);
		for (int i = 0; i < step.length; i++) {
			PagePathStep pagePathStep = new PagePathStep();
			pagePathStep.setStepNumber(Integer.parseInt(step[i].split("\\$")[0]));
			pagePathStep.setPathName(step[i].split("\\$")[1]);
			pagePathStep.setPathExpress(step[i].split("\\$")[2]);
			pagePathStepList.add(pagePathStep);
		}
	}
	
	public void printPagePathStep() {
		for (PagePathStep pagePathStep : pagePathStepList) {
			System.out.println(pagePathStep.getStepNumber() + pagePathStep.getPathName() + pagePathStep.getPathExpress());
			System.out.println();
		}
	}
	
	public static void main(String[] agrs) {
		PagePath pagePath = new PagePath();
		pagePath.getpagePathStepList();
		pagePath.printPagePathStep();
	}

	public String getStepPathDetail() {
		return stepPathDetail;
	}

	public void setStepPathDetail(String stepPathDetail) {
		this.stepPathDetail = stepPathDetail;
	}

	public ArrayList<PagePathStep> getPagePathStepList() {
		return pagePathStepList;
	}

	public void setPagePathStepList(ArrayList<PagePathStep> pagePathStepList) {
		this.pagePathStepList = pagePathStepList;
	}
}
