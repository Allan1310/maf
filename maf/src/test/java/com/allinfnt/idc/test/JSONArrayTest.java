package com.allinfnt.idc.test;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;

public class JSONArrayTest {
	
	public static void main(String[] args) {
		
		List<UserTest> list = new ArrayList<UserTest>();
		UserTest user = new UserTest();
		user.setId(1);
		user.setName("小明1");
		UserTest user1 = new UserTest();
		user1.setId(2);
		user1.setName("小明2");
		list.add(user);
		list.add(user1);
		
		JSONArray jsonArray = JSONArray.fromObject(list);
		
		System.out.println(jsonArray);
	}
}
