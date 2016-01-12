package com.allinfnt.idc.modules.sys.service;

import java.net.Authenticator;
import java.net.MalformedURLException;
import java.net.PasswordAuthentication;
import java.net.URL;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.namespace.QName;
import javax.xml.ws.BindingProvider;
import javax.xml.ws.Service;
import javax.xml.ws.handler.MessageContext;

import com.allinfnt._2014._08.atomic.oa.userinfo.types.User;
import com.allinfnt._2014._08.atomic.oa.userinfo.types.Userinfo;
import com.allinfnt.idc.common.config.Global;
import com.google.common.collect.Maps;

public class UserSynUtils {
	
	public static void main(String[] args) throws MalformedURLException {
		URL url = new URL(null, "http://10.252.102.81:8080/oa/ws/api/userinfo?wsdl", new sun.net.www.protocol.http.Handler()); ;

        try {
            final String username = "idc";
            final String password = "idc";
            Authenticator.setDefault(new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(
                            username,
                            password.toCharArray());
                }
            });
            QName qname = new QName("http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", "UserInfoControllerService");
            Service service = Service.create(url, qname);
            Userinfo proxy = service.getPort(Userinfo.class);
            Map<String, Object> requestContext = ((BindingProvider) proxy).getRequestContext();
            requestContext.put(BindingProvider.ENDPOINT_ADDRESS_PROPERTY, url.toString());
            requestContext.put(BindingProvider.USERNAME_PROPERTY, username);
            requestContext.put(BindingProvider.PASSWORD_PROPERTY, password);
            Map<String, List<String>> headers = new HashMap<String, List<String>>();
            headers.put("Timeout", Collections.singletonList("10000"));
            requestContext.put(MessageContext.HTTP_REQUEST_HEADERS, headers);
            User result = proxy.getUserInfoByNo("1001");

            System.out.println("Result is: " + result.getUserName());

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error occurred in operations web service client initialization", e);
        }
	}
	
	public static Map<String,String> getIDCUserByUser(String no) throws MalformedURLException{
		URL url = new URL(null, Global.getConfig("oa.wsdl"), new sun.net.www.protocol.http.Handler()); ;
		Map<String,String> map = Maps.newHashMap();
        try {
            final String username = Global.getConfig("oa.username");
            final String password = Global.getConfig("oa.password");
            Authenticator.setDefault(new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(
                            username,
                            password.toCharArray());
                }
            });
            QName qname = new QName("http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", "UserInfoControllerService");
            Service service = Service.create(url, qname);
            Userinfo proxy = service.getPort(Userinfo.class);
            Map<String, Object> requestContext = ((BindingProvider) proxy).getRequestContext();
            requestContext.put(BindingProvider.ENDPOINT_ADDRESS_PROPERTY, url.toString());
            requestContext.put(BindingProvider.USERNAME_PROPERTY, username);
            requestContext.put(BindingProvider.PASSWORD_PROPERTY, password);
            Map<String, List<String>> headers = new HashMap<String, List<String>>();
            headers.put("Timeout", Collections.singletonList("10000"));
            requestContext.put(MessageContext.HTTP_REQUEST_HEADERS, headers);
            User result = proxy.getUserInfoByNo(no);
            if(result !=null){
            	map.put("loginName", result.getUserName());
            	map.put("email", result.getEmail());
            	map.put("phone", result.getPhone());
            	map.put("mobile", result.getMobile());
            	map.put("userType", result.getUserType());
            	map.put("position",result.getUserPosition());
            	map.put("departId",result.getDepartmentId());
            	map.put("departName", result.getDepartmentName());
            	map.put("name", result.getRealName());
            }
           

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error occurred in operations web service client initialization", e);
        }
		return map;
	}

}
