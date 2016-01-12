package com.allinfnt.idc.modules.script.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Field;

/**
 * Add by Losyn Date: 2014/7/22 Time: 18:54
 */
public class EnumUtils {
    private static final Logger LOG = LoggerFactory.getLogger(EnumUtils.class);

    public static <T extends Enum<T>> T getValueOf(Class<T> enumClass, String value) {
        for (T enumValue : enumClass.getEnumConstants()) {
            if (enumValue.toString().equals(value)) {
                return enumValue;
            }
        }
        throw new IllegalArgumentException(value + " is not valid of enum " + enumClass);
    }

    /**
     * 修改Enum的name
     *
     * @param enumInstance
     * @param value
     * @param <T>
     */
    public static <T extends Enum<T>> void changeNameTo(T enumInstance, String value) {
        try {
            Field fieldName = enumInstance.getClass().getSuperclass().getDeclaredField("name");
            fieldName.setAccessible(true);
            fieldName.set(enumInstance, value);
            fieldName.setAccessible(false);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
    }

    public static boolean equals(Enum enum1, Enum enum2) {
        if (enum1 == null && enum2 == null) {
            return true;
        } else if (enum1 != null) {
            return enum1.equals(enum2);
        } else {
            return enum2.equals(enum1);
        }
    }
}
