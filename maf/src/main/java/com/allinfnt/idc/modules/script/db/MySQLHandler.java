package com.allinfnt.idc.modules.script.db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public final class MySQLHandler {
	
	public static void main(String[]args) {
		System.out.println(getTestStepDetail("TC01"));
	}
	
	/**
	 * 根据测试用例编号，在数据库中查找步骤字符串
	 * @param testCaseID 测试用例编号
	 * @return 返回步骤细节
	 */
	public static String getTestStepDetail(String caseId) {
		
		Connection conn = MySQLConnectionFactory.createConnection();
		Statement st = null;
		ResultSet rs = null;
		String stepDetail = null;
		try {
			String sql = "SELECT step_detail FROM case_manage a  WHERE a.id = \"" + caseId + "\"";
			//System.out.println(sql);
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			rs.next();
			stepDetail = rs.getNString("step_detail");
			rs.close();
			conn.close();
		} catch (SQLException e) {
			
		}
		return stepDetail;
	}
	
	
	public static String getTestCaseName(String caseId) {

		Connection conn = MySQLConnectionFactory.createConnection();
		Statement st = null;
		ResultSet rs = null;
		String testCaseName = null;
		try {
			String sql = "SELECT case_name FROM case_manage WHERE id = \"" + caseId + "\"";
			// System.out.println(sql);
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			rs.next();
			testCaseName = rs.getNString("case_name");
			rs.close();
			conn.close();
		} catch (SQLException e) {

		}
		return testCaseName;
	}
	
	
	public static String getFunctionName(String caseId) {

		Connection conn = MySQLConnectionFactory.createConnection();
		Statement st = null;
		ResultSet rs = null;
		String functionName = null;
		try {
			String sql = "SELECT id FROM case_manage WHERE id = \"" + caseId + "\"";
			// System.out.println(sql);
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			rs.next();
			functionName = rs.getNString("id");
			rs.close();
			conn.close();
		} catch (SQLException e) {

		}
		return functionName;
	}
	
	public static String getTestData(String caseId) {

		Connection conn = MySQLConnectionFactory.createConnection();
		Statement st = null;
		ResultSet rs = null;
		String testData = null;
		try {
			String sql = "SELECT test_data FROM case_manage WHERE id = \"" + caseId + "\"";
			// System.out.println(sql);
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			rs.next();
			testData = rs.getNString("test_data");
			rs.close();
			conn.close();
		} catch (SQLException e) {

		}
		return testData;
	}
	/*public static String querySql(String sql,String retType){
		String ret = null;
		Connection conn = MySQLConnectionFactory.createConnection();
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			st = conn.prepareStatement(sql);
			rs = st.executeQuery();
			rs.next();
			if("string".equals(retType.toLowerCase())){
				ret = rs.getString(1);
			}else if("long".equals(retType.toLowerCase())){
				Long r = rs.getLong(1);
				if(r!=null){
					ret = String.valueOf(r);
				}
			}else if("integer".equals(retType.toLowerCase())){
				Integer r = rs.getInt(1);
				if(r!=null){
					ret = String.valueOf(r);
				}
			}else if("datetime".equals(retType.toLowerCase())){
				Date r = rs.getDate(1);
				if(r!=null){
					ret = DateFormat.getInstance().format(r);
				}
			}
		} catch (SQLException e) {
			
		}
		return ret;
	}*/
	
	
	/***
	 * check the record existed in db or not
	 * @param sql
	 * @return : true existed, false not
	 */
/*	public static boolean updateOrInsert(String sql) {
		Connection conn = MySQLConnectionFactory.createConnection();
		PreparedStatement pst = null;
		ResultSet rs = null;
		int num = 0;
		try {
			pst = conn.prepareStatement(sql);
			rs = pst.executeQuery();
			rs.next();
			num = rs.getInt(1);
		} catch (SQLException e) {
			LOG.error("sql executed failed");
		}
		
	    return num == 0 ? false : true;
	}*/

	/**
	 * execute a list of select sql sentences to backup data before testing
	 * 
	 * @param list
	 * @return
	 *//*
	public static boolean selectBatch(List<String> list, String fileName) {
		Connection conn = DBConnectionFactory.createConnection();

		//add SCHEME with uppercase，or will throw AmbiguousNameException
		IDatabaseConnection connection = new DatabaseConnection(conn, MConstant.dbUser.toUpperCase());
		QueryDataSet dataSet = null;
		try {
			dataSet = new QueryDataSet(connection);
			for (String sql : list) {
				String[] str = sql.split("#");
				dataSet.addTable(str[1].trim(), str[0].trim());
			}
			FlatXmlDataSet.write(dataSet, new FileOutputStream(fileName));
		} catch (SQLException e) {
			LOG.debug("SQL Exception " + e.getMessage());
			e.printStackTrace();
		} catch (DataSetException e) {
			LOG.debug("DataSet Exception " + e.getMessage());
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			LOG.debug("File not found Exception " + e.getMessage());
			e.printStackTrace();
		} catch (IOException e) {
			LOG.debug("IO Exception " + e.getMessage());
			e.printStackTrace();
		}

		return true;
	}

	*//**
	 * execute a list of insert or update sentences 
	 * for testing
	 * @param list
	 * @return
	 *//*
	public static boolean DMLBatch(List<String> list) {
		Connection conn = DBConnectionFactory.createConnection();
		Statement st = null;
		try {
			conn.setAutoCommit(false);
			st = conn.createStatement();
			for (int i = 0; i < list.size(); i++) {
				st.addBatch(list.get(i));
			}
			
			int[] result = st.executeBatch();
			int flag = queryForNegative(result);
			if (flag == -2) {
				conn.commit();
				conn.setAutoCommit(true);
				return true;
			} else{
				throw new SQLException("rank " + flag + " row executed failed");
			}
			
		} catch (SQLException e) {
			LOG.error("DB DML operation failed");
			try {
				conn.rollback();
			} catch (SQLException e1) {
				LOG.error("Roll back failed");
			}
			e.printStackTrace();
		} finally {
			if (st != null) {
				try {
					st.close();
					if (conn != null) {
						conn.close();
					}
				} catch (SQLException e) {
					LOG.error("close failed");
				}
			}
		}
		return false;
	}
	
	*//**
	 * 
	 * @param : claimNo 定损单号
	 * @return : 返回刚导入的定损单的claim id
	 *//*
	public static Long getClaimId(String claimNo) {
		Connection conn = DBConnectionFactory.createConnection();
		Statement st = null;
		ResultSet rs = null;
		Long id = 0L;
		try {
			st = conn.createStatement();
			String sql = "SELECT CLAIM_ID AS ID FROM T_CLAIM WHERE CLAIM_NO = '" + claimNo.trim() + "'";
			rs = st.executeQuery(sql);
			rs.next();
			id = rs.getLong("ID");
			LOG.info("DB query claimId == " + id);
		} catch (SQLException e) {
			LOG.error("DB DML operation failed");
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					LOG.error("ResultSet didn't close");
				}
			}
			if (st != null) {
				try {
					st.close();
					if (conn != null) {
						conn.close();
					}
				} catch (SQLException e) {
					LOG.error("close failed");
				}
			}
		}
		return id;
	}
	
	*//**
	 * 
	 * @param accidentNo 事故号
	 * @return surveyId 查勘id
	 *//*
	public static Long getSurveyId(String accidentNo) {
		Connection conn = DBConnectionFactory.createConnection();
		Statement st = null;
		ResultSet rs = null;
		Long id = 0L;
		try {
			st = conn.createStatement();
			String sql = "SELECT SURVEY_ID AS ID FROM T_SURVEY WHERE ACCIDENT_NO = '" + accidentNo.trim() + "'";
			LOG.info("survey sql == " + sql);
			rs = st.executeQuery(sql);
			rs.next();
			id = rs.getLong("ID");
			LOG.info("DB query surveyId == " + id);
		} catch (SQLException e) {
			LOG.error("DB DML operation failed");
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					LOG.error("ResultSet didn't close");
				}
			}
			if (st != null) {
				try {
					st.close();
					if (conn != null) {
						conn.close();
					}
				} catch (SQLException e) {
					LOG.error("close failed");
				}
			}
		}
		return id;
	}

	*//**
	 * check the batch success or not, if failed, return the sql index
	 * success:-2
	 * 
	 * @param arr : update status
	 * @return
	 *//*
	public static int queryForNegative(int[] arr) {
		for (int i = 0; i < arr.length; i++) {
			if (arr[i] < 0) {
				return i;
			}
		}
		return -2;
	}

	*//**
	 * flash back to db
	 * @param fileName : backup xml
	 * @param dtd : table schema
	 * @param flag : the operation mark
	 * @return
	 *//*
	public static boolean retreatDB(String fileName, String dtd, int flag) {
		IDatabaseConnection connection = null;
		try {
			Connection conn = DBConnectionFactory.createConnection();
			connection = new DatabaseConnection(conn, MConstant.dbUser.toUpperCase());
			//connection = new DatabaseConnection(conn, GlobalSettings.dbUser.toUpperCase());
			IDataSet dataSet = null;
			if(dtd == null) {
				dataSet = new FlatXmlDataSet(new FileInputStream(fileName));
			}else {
				dataSet = new FlatXmlDataSet(new FileInputStream(fileName),new FileInputStream(dtd));
			}
			
			try {
				//DatabaseOperation.UPDATE.execute(connection, dataSet);
				*//**choose the retrive method according to the param flag*//*
				switch(flag) {
				    case 1 : TransactionOperation.UPDATE.execute(connection, dataSet);
				             break;
				    case 2 : TransactionOperation.DELETE.execute(connection, dataSet);
				             break;
				    case 3 : TransactionOperation.DELETE_ALL.execute(connection, dataSet);
				             break;
				    case 4 : DatabaseOperation.INSERT.execute(connection, dataSet);
				             break;
				    case 5 : TransactionOperation.CLEAN_INSERT.execute(connection, dataSet);
				             break;
				    case 6 : DatabaseOperation.TRUNCATE_TABLE.execute(connection, dataSet);
				             break;
				    case 7 : TransactionOperation.REFRESH.execute(connection, dataSet);//update or insert
				             break;
				    default : DatabaseOperation.NONE.execute(connection, dataSet);
				}
				return true;
			} catch (DatabaseUnitException e) {
				LOG.error("db unit exception");
			} catch (SQLException e1) {
				LOG.error("sql exception");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (connection != null) {
					connection.close();
				}

			} catch (SQLException e) {
			}
		}
		return false;
	}
	
	
	
	*//**
	 * data refresh back check
	 * @param tableName
	 * @return refresh status
	 *//*
	public static boolean assertExpect(String tableName) {
		IDatabaseConnection connection = null;
		try {
			Connection conn = DBConnectionFactory.createConnection();
			connection = new DatabaseConnection(conn, MConstant.dbUser.toUpperCase());
			//预期的table 
			IDataSet expectedDataSet = new FlatXmlDataSet(new FileInputStream(MConstant.PATH_CONFIG_DBXMLS+"dbtable.xml"),new FileInputStream(MConstant.PATH_CONFIG_DTDS+"t_sys_config_item.dtd"));
			ITable expectedTable = expectedDataSet.getTable(tableName); 
			LOG.info("expect column count: " + expectedTable.getTableMetaData().getColumns().length);
			
			//实际的table
			IDataSet databaseDataSet = connection.createDataSet();
			ITable actualTable = databaseDataSet.getTable(tableName); 
			LOG.info("actual column count: " + actualTable.getTableMetaData().getColumns().length);

			// 比较
			Assertion.assertEquals(expectedTable, actualTable); 
			

		}catch(Exception e){
			LOG.error("refresh back failed");
	    }
	    
		return true;
	}
	
	*//**
	 * back up the whole table data into a xml
	 * @param tableName db table name
	 * @return execute status
	 *//*
	public static boolean backupTable(String tableName, String fileName) {
		IDatabaseConnection connection = null;
		try {
			Connection conn = DBConnectionFactory.createConnection();
			connection = new DatabaseConnection(conn, MConstant.dbUser.toUpperCase());
			//connection = new DatabaseConnection(conn, GlobalSettings.dbUser.toUpperCase());
			QueryDataSet ds = new QueryDataSet(connection);
			ds.addTable(tableName);
			FlatXmlDataSet.write(ds,new FileOutputStream(fileName));
			return true;
		}catch(FileNotFoundException e){
			LOG.error("file not found");
			return false;
	    } catch (SQLException e) {
			LOG.error("Sql error");
		} catch (DataSetException e) {
			LOG.error("DBUnit dataset exception");
		} catch (IOException e) {
			LOG.error("IO exception");
		}
		return false;
	}
	*/
	

}
