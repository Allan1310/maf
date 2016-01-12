package com.allinfnt.idc.common.enums;



import java.lang.reflect.Field;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.util.Assert;

public abstract class BeanUtils {
	
	private static transient final Log logger = LogFactory.getLog(BeanUtils.class);

	@SuppressWarnings("unchecked")
	public static <T> T getDeclaredFieldValue(Object object, String propertyName)
			throws NoSuchFieldException {
		Assert.notNull(object);
		Assert.hasText(propertyName);

		Field field = getDeclaredField(object.getClass(), propertyName);

		boolean accessible = field.isAccessible();
		Object result = null;
		synchronized (field) {
			field.setAccessible(true);
			try {
				result = field.get(object);
			} catch (IllegalAccessException e) {
				throw new NoSuchFieldException("No such field: "
						+ object.getClass() + '.' + propertyName);
			} finally {
				field.setAccessible(accessible);
			}
		}
		return (T) result;
	}

	public static Field getDeclaredField(Class<?> clazz, String propertyName)
			throws NoSuchFieldException {
		Assert.notNull(clazz);
		Assert.hasText(propertyName);
		for (Class<?> superClass = clazz; superClass != Object.class; 
			superClass = superClass.getSuperclass()) {
			
			try {
				return superClass.getDeclaredField(propertyName);
			} catch (NoSuchFieldException e) {
				// Field不在当前类定义,继续向上转型
				logger.debug("no such method !");
			}
		}
		throw new NoSuchFieldException("No such field: " + clazz.getName()
				+ '.' + propertyName);
	}

	public static Field[] getDeclaredFields(Class<?> clazz) {
		Assert.notNull(clazz);
		Field[] fields = clazz.getDeclaredFields();
		for (Class<?> superClass = clazz; superClass != Object.class; superClass = superClass
				.getSuperclass()) {
			fields = (Field[]) ArrayUtils.addAll(fields, superClass.getDeclaredFields());
		}
		return fields;
	}

}

