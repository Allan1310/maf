package com.allinfnt.idc.common.enums;

import java.util.EnumSet;

public enum OaPositionEnums {
//	POSITION_PTYG("ptyg","普通员工","用于岗位职位的普通员工职位"),
	POSITION_HQRY("hqry","会签人员","用于岗位职位的部门会签人员"),
	POSITION_FGLD("fgld","分管领导","用于岗位职位的部门分管领导"),
	
	POSITION_BMLD("bmld","部门领导","用于岗位职位的部门领导职位"),
	POSITION_BMZL("bmzl","部门助理","用于岗位职位的助理职位"),
	
//	POSITION_BMZLZJL("bmzlzjl","部门助理总经理","用于岗位职位的部门助理总经理职位"),
//	POSITION_BMFZJL("bmfzjl","部门副总经理","用于岗位职位的部门副总经理职位"),
//	POSITION_BMZJL("bmzjl","部门总经理","用于岗位职位的部门总经理职位"),
//	POSITION_GSZC("gszc","公司总裁","用于岗位职位的公司总裁职位")
	;
	
	private String code;
	private String title;
	private String description;
	
	private OaPositionEnums(String code, String title, String description) {
		this.code = code;
		this.title = title;
		this.description = description;
	}
	public static OaPositionEnums fromCode(String code) {
		return EnumUtils.fromEnumProperty(OaPositionEnums.class, "code", code);
	}
	public static EnumSet<OaPositionEnums> allList() {
		EnumSet<OaPositionEnums> leftMenuList = EnumSet.allOf(OaPositionEnums.class);
		return leftMenuList;
	}
	public static OaPositionEnums[] all() {
		return OaPositionEnums.values();
	}
	public String getCode() {
		return code;
	}
	public String getTitle() {
		return title;
	}
	public String getDescription() {
		return description;
	}
	
	
}
