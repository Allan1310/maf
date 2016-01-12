package com.allinfnt.idc.modules.script.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public final class MySQLConnectionFactory {
	
	public MySQLConnectionFactory() {}
	
	//get the MySQL connection
	public static Connection createConnection() {
		
		Connection conn = null;
		
		try {
			String url = "jdbc:mysql://localhost:3306/maf";
			String userName = "root";
			String password = "root1310";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, userName, password);

		} catch (ClassNotFoundException e) {
			System.out.println("MySQLDriver not found");
		} catch (SQLException e) {
			System.out.println("user or password is not correct");
		}
		return conn;
	}
}
