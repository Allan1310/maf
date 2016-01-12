package com.allinfnt.idc.test;

import java.util.ArrayList;
import java.util.List;

public class BeanSort {
	  public static List<Bean> sort(List<Bean> beans) {
	         
	        List<Bean> result = new ArrayList<Bean>();
	         
	        for (Bean bean : beans) {
	            if (bean.getParentId() == 0) {
	                result.add(bean);
	                sort(bean.getId(), beans, result.get(result.size() - 1), result);
	            }
	        }
	         
	        return result;
	    }
	     
	    private static void sort(long id, List<Bean> beans, Bean target, List<Bean> result) {
	        for (Bean bean : beans) {
	            if (bean.getParentId() == id) {
	                target.getChildren().add(bean);
	            } else {
	                //这里怎么获取更下一级的？
	            }
	        }
	    }
}
