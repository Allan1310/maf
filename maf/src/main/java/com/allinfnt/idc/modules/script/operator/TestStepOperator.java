package com.allinfnt.idc.modules.script.operator;

import com.allinfnt.idc.modules.script.maker.TestStep;

public class TestStepOperator {
	
	public int checkNeedParam(TestStep testStep){
		
		return testStep.getParaCount();
	}
	
	public void produceParam(int count) {
		
	}
}
