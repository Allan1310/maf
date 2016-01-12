package com.allinfnt.idc.common.enums;

import org.apache.commons.lang.ObjectUtils;

/**
 * 枚举操作类
 * 
 */

public abstract class EnumUtils {

	/**
	 * 从指定的枚举类中根据property搜寻匹配指定值的枚举实例
	 * @param <T>
	 * @param enumClass
	 * @param property
	 * @param propValue
	 * @return
	 */
	public static <T extends Enum<T>> T fromEnumProperty(Class<T> enumClass, String property, Object propValue) {
		T[] enumConstants = enumClass.getEnumConstants();
		for (T t : enumConstants) {
			Object constantPropValue;
			try {
				constantPropValue = BeanUtils.getDeclaredFieldValue(t, property);
				if (ObjectUtils.equals(constantPropValue, propValue)) {
					return t;
				}
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
		return null;

	}

	/**
	 * 从指定的枚举类中根据名称匹配指定值
	 * @param <T>
	 * @param enumClass
	 * @param constantName
	 * @return
	 */
    public static <T extends Enum<T>> T fromEnumConstantName(Class<T> enumClass, String constantName) {
        T[] enumConstants = enumClass.getEnumConstants();
        for (T t : enumConstants) {
            if (((Enum<?>) t).name().equals(constantName)) {
                return t;
            }
        }
        return null;
    }
	
}

