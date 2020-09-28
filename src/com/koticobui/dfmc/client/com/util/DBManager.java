package com.koticobui.dfmc.client.com.util;

import java.io.InputStream;
import java.sql.*;
import java.util.*;

public class DBManager
{
	private Connection conn = null;
	private String  id                     = ""; // 아이디
	private String  passwd                 = ""; // 암호
	private String  dbName                 = ""; // DB명
	private boolean transActionStatus;           // 트렌젝션 상태

	public DBManager() {
	}

	/**
	* <PRE>
	* Descript	: DB 컨넥션을 가져온다.
	* Table    	: 
	* Control	: 
	* <PRE>
	* @History	: 2016/06/24, (Heo, PyeungKang)
	* @param   	: 
	* @Return	: Connection
	*/

	public Connection getConnection(String PoolName) throws SQLException
	{
		try {
            if(PoolName.equals("dongjak")) {
            	Class.forName("oracle.jdbc.driver.OracleDriver");
            	Properties props = new Properties(); 
            	InputStream fis = getClass().getClassLoader().getResourceAsStream("config/appConfig.properties");
            	props.load(new java.io.BufferedInputStream(fis));
            	String url = props.getProperty("jdbc.url").trim();
            	String username = props.getProperty("jdbc.username").trim();
            	String password = props.getProperty("jdbc.password").trim();
 
            	this.conn = DriverManager.getConnection(url, username, password);
            	//this.conn = DriverManager.getConnection("jdbc:oracle:thin:@211.253.26.49:15210:koco", "pis", "pis");  
            } else if(PoolName.equals("dongjakSvc")) {
            	Class.forName("oracle.jdbc.driver.OracleDriver");
            	this.conn = DriverManager.getConnection("jdbc:oracle:thin:@211.253.26.49:15210:koco", "dpark", "dpark");  
            }
  
		}catch(SQLException ex) {
			ex.printStackTrace();
	    } catch (Exception ex) {
        	ex.printStackTrace();
		}
		return this.conn;
	}
	public Connection getConnection(String PoolName,String prefetch) throws SQLException
	{
		try {
            if(PoolName.equals("dongjak")) {
            	Class.forName("oracle.jdbc.driver.OracleDriver");
            	Properties properties = new Properties();
            	properties.setProperty("user","pis");
            	properties.setProperty("password","pis");
            	properties.setProperty("prefetch",prefetch);            	
            	this.conn = DriverManager.getConnection("jdbc:oracle:thin:@211.253.26.49:15210:koco", properties); 
            } else if(PoolName.equals("dongjakSvc")) {
            	Class.forName("oracle.jdbc.driver.OracleDriver");
            	Properties properties = new Properties();
            	properties.setProperty("user","dpark");
            	properties.setProperty("password","dpark");
            	properties.setProperty("prefetch",prefetch);            	
            	this.conn = DriverManager.getConnection("jdbc:oracle:thin:@211.253.26.49:15210:koco", properties);  
            }

		}catch(SQLException ex) {
			ex.printStackTrace();
	    } catch (Exception ex) {
        	ex.printStackTrace();
		}
		return this.conn;
	}	
	/**
	* <PRE>
	* Descript	: DB 트렌잭션을 시작한다.
	* <PRE>
	* History	: Created in 2006/07/25
	* @param   	: 
	* @Return	: void
	*/
	public void begin() throws Exception
	{
		this.conn.setAutoCommit(false);
		this.setTransActionStatus(true);
		return;
	}
	/**
	* <PRE>
	* Descript	: DB를 commit한다.
	* <PRE>
	* History	: Created in 2006/07/26
	* @param   	: 
	* @Return	: void
	*/
	public void commit() throws Exception
	{
		this.conn.commit();
		return;
	}	
	/**
	* <PRE>
	* Descript	: DB를 rollback한다.
	* <PRE>
	* History	: Created in 2006/07/26
	* @param   	: 
	* @Return	: void
	*/
	public void rollback() throws Exception
	{
		this.conn.rollback();
		return;
	}	
	/**
	* <PRE>
	* Descript	: DB를 end한다.(rollback)
	* <PRE>
	* History	: Created in 2006/07/26
	* @param   	: 
	* @Return	: void
	*/
	public void end() throws Exception
	{
		if(this.transActionStatus == true) {
			this.conn.rollback();
		}
		return;
	}	
	
	/**
	* <PRE>
	* Descript	: DB를 close한다.
	* <PRE>
	* History	: Created in 2006/07/26
	* @param   	: 
	* @Return	: void
	*/
	public void close() throws Exception
	{
		this.conn.close();
		return;
	}		
	public void setId                    (String  str ) {this.id                    = str ;} // 아이디
	public void setPasswd                (String  str ) {this.passwd                  = str ;} // 암호
	public void setDbName                (String  str ) {this.dbName                    = str ;} // DB명
	public void setTransActionStatus(boolean  status ){this.transActionStatus     = status ;} // 트렌젝션 상태

	public String  getId()               { return id                     ; } // 아이디
	public String  getPasswd()           { return passwd                   ; } // 암호
	public String  getDbName()           { return dbName                     ; } // DB명
	public boolean  getTransActionStatus(){ return transActionStatus      ; } // 트렌젝션 상태
}