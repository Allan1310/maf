package com.allinfnt.idc.test;

import java.util.ArrayList;
import java.util.List;
public class TreeTest {
	public static void main(String[] args) {
		
        Bean up1= getBean(11806,1,11802);
        Bean up2= getBean(11797,1,11806);
        Bean up3= getBean(11798,1,11796);
        Bean up4= getBean(11799,1,11804);
        Bean up5= getBean(11796,1,0);
        Bean up6= getBean(11800,2,0);
        Bean up7= getBean(11801,2,11802);
        Bean up8= getBean(11804,2,11796);
        Bean up9= getBean(11803,2,11804);
        Bean up10= getBean(11802,3,0);
        Bean up11= getBean(11805,4,0);
         
        List<Bean> list = new ArrayList<Bean>();
        list.add(up1);
        list.add(up2);
        list.add(up3);
        list.add(up4);
        list.add(up5);
        list.add(up6);
        list.add(up7);
        list.add(up8);
        list.add(up9);
        list.add(up10);
        list.add(up11);
         
        List<Bean> result = BeanSort.sort(list);
        for (Bean bean : result) {
            System.out.println(bean);
        }
    }
     
    private static Bean getBean(int id, int sortId, int parentId) {
        Bean bean = new Bean();
        bean.setId(id);
        bean.setSortId(sortId);
        bean.setParentId(parentId);
         
        return bean;
    }
}


