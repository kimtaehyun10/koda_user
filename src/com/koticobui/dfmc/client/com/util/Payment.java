package com.koticobui.dfmc.client.com.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.apache.log4j.Logger;

public class Payment {
	private static final Logger LOGGER = Logger.getLogger(Payment.class);
	private Connection conn  = null;
	private boolean KeepConnection  = false;
	
	public Payment() {
		
	}

	public String selectOcrNo(Map map) throws Exception {
		String result = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt = 0;
		int list_cond_cnt = 1;
		
		try {
			if(this.conn == null) {
				DBManager dbm = new DBManager();
				this.conn = dbm.getConnection("dongjak");
			}
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT OCR_NO FROM TB_QUARTER_PAYMENT WHERE PURCHASE_KEY = ? ");

			pstmt = this.conn.prepareStatement(sql.toString());
			pstmt.setString(list_cond_cnt++,(String)map.get("purchaseKey"));
			
			rs = pstmt.executeQuery();
			cnt = rs.getFetchSize();
			ResultSetMetaData rsmd = rs.getMetaData();

			if(rs.next()){
				result = rs.getString("OCR_NO");
			}
		}
		catch(Exception e) {
			LOGGER.error(e.getMessage());
	    } finally {
			if ( pstmt != null ) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}	
			if ( rs != null ) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return result;
	}
	public String genTableKey() throws Exception {
		
		String result = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt = 0;
		int list_cond_cnt = 1;
		
		try {
			if(this.conn == null) {
				DBManager dbm = new DBManager();
				this.conn = dbm.getConnection("dongjak");
			}
		
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
			Date currentTime = new Date();
			String today = simpleDateFormat.format(currentTime);

			StringBuffer sql = new StringBuffer();
			sql.append("        SELECT ");
			sql.append("            TO_CHAR(LPAD(NVL(MAX(TO_NUMBER(SUBSTR(PAYMENT_KEY, -11)))+1, 1), 11, '0')) KEY ");
			sql.append("        FROM TB_PAY ");
			sql.append("        WHERE PAYMENT_KEY LIKE ?||'%' ");
			
			pstmt = this.conn.prepareStatement(sql.toString());
			pstmt.setString(list_cond_cnt++,today);
			
			rs = pstmt.executeQuery();
			cnt = rs.getFetchSize();
			
			String nextKeyNumber = null;
			if(rs.next()){
				nextKeyNumber = rs.getString("KEY");
			}
			
			result = today + "_" + nextKeyNumber;
		}
		catch(Exception e) {
			LOGGER.error(e.getMessage());
	    } finally {
			if ( pstmt != null ) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}	
			if ( rs != null ) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}			
		}

		return result;
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map selectPayCnt(Map map) throws Exception {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		HashMap result = null;
		int list_cond_cnt = 1;
		int cnt = 0;
		try {
			if(this.conn == null) {
				DBManager dbm = new DBManager();
				this.conn = dbm.getConnection("dongjak");
			}
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT COUNT(1) CNT, MAX(TQP.COST) COST, SUM(TP.PAY_AMT) PAY_AMT FROM TB_PAY TP, TB_QUARTER_PAYMENT TQP  ");
			sql.append("		WHERE TQP.PURCHASE_KEY = TP.PURCHASE_KEY ");
			sql.append("		 AND TQP.PURCHASE_KEY = ? ");

			pstmt = this.conn.prepareStatement(sql.toString());
			pstmt.setString(list_cond_cnt++,(String)map.get("purchaseKey"));
			System.out.println("purchaseKey:"+map.get("purchaseKey")+" in selectPayCnt()");

			rs = pstmt.executeQuery();
			cnt = rs.getFetchSize();
			ResultSetMetaData rsmd = rs.getMetaData();
	
			result = new HashMap();
	
			if(rs.next()){
				int size = rsmd.getColumnCount();
				for (int i = 0 ; i< size; i++){
					String columnName = rsmd.getColumnName(i+1);
					String columnValue = rs.getString(columnName);
					System.out.println(i+",columnName:" + columnName + ",columnValue:" + columnValue);
					result.put(columnName,columnValue);
				}
			}
		}
		catch(Exception e) {
			LOGGER.error(e.getMessage());
	    } finally {
			if ( pstmt != null ) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}	
			if ( rs != null ) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}			
		}
		return result;
	}
	
	public Map savePay(HashMap map) {
		HashMap resultMap = new HashMap();
		
		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		boolean result = false;
		int rlt_code = 0;
		int rlt_code1 = 0;
		int rlt_code2 = 0;
		int list_cond_cnt = 1;
		try {
			System.out.println("map:{}" + map.toString());
		
			if(this.conn == null) {
				DBManager dbm = new DBManager();
				this.conn = dbm.getConnection("dongjak");
			}		
			this.conn.setAutoCommit(false);
			
			//OCR번호(고객조회번호) 조회
	    	//수납키로 OCR번호 조회
	    	String ocrNo = selectOcrNo(map);
	    	System.out.println("ocrNo:"+ocrNo);
	    	
	    	//결제키 생성
	    	String payKey = genTableKey();
	    	System.out.println("payKey:"+payKey);
			
			//1.
	    	//결제 데이타 저장
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO TB_PAY ");
			sql.append("                ( ");
			sql.append("                PAYMENT_KEY ");
			sql.append("                , PURCHASE_KEY ");
			sql.append("                , PAY_WAY ");
			sql.append("                , PAY_AMT ");
			sql.append("                , COMM_COST ");
			sql.append("                , STORE_DATE ");
			sql.append("                , TRANSFER_DATE ");
			sql.append("                , INDEX_NO ");
			sql.append("                , STORE_GUBUN ");
			sql.append("                , CUST_INQUIRY_NO ");
			sql.append("                , PAY_DATE ");
			sql.append("                , PAY_STATUS ");
			sql.append("                , DEPOSIT_DATE ");
			sql.append("                ) ");
			sql.append("            VALUES ");
			sql.append("                ( ");
			sql.append("                ?  ");
			sql.append("                , ? ");
			sql.append("                , '02' ");
			sql.append("                , ? ");
			sql.append("                , 0 ");
			sql.append("                , ? ");
			sql.append("                , ? ");
			sql.append("                , '' ");
			sql.append("                , '' ");
			sql.append("                , ? ");
			sql.append("                , ? ");
			sql.append("                , '02' ");
			sql.append("                , ? ");
			sql.append("                ) ");

			pstmt = this.conn.prepareStatement(sql.toString());
			pstmt.setString(list_cond_cnt++,payKey);
			pstmt.setString(list_cond_cnt++,(String)map.get("purchaseKey"));
			pstmt.setString(list_cond_cnt++,(String)map.get("payAmt"));
			pstmt.setString(list_cond_cnt++,(String)map.get("payDate"));
			pstmt.setString(list_cond_cnt++,(String)map.get("payDate"));
			pstmt.setString(list_cond_cnt++,ocrNo);
			pstmt.setString(list_cond_cnt++,(String)map.get("payDate"));
			pstmt.setString(list_cond_cnt++,(String)map.get("payDate"));
			
			rlt_code = pstmt.executeUpdate();
			System.out.println("Pay 등록건수:"+rlt_code);
	
			//등록이 된 경우에 처리함
			if(rlt_code > 0) {
				//2-1.
		    	//결제테이블에 고객조회번호로 이중납부여부 확인
		    	Map<String, String> map1 = (Map) selectPayCnt(map);
		    	System.out.println("cnt :"+map1.get("CNT"));
		    	System.out.println("cost :"+map1.get("COST"));
		    	System.out.println("payAmt :"+map1.get("PAY_AMT"));
		    	int cnt = 0;
		    	int cost = 0;
		    	int payAmt = 0;
		    	//purchaseKey가 일치하지 않는 테스트 결제인 경우
		    	if(map1.get("CNT") == null && map1.get("COST") == null && map1.get("PAY_AMT") == null) {
		    		map.put("procResult","01"); // 정상납부
		    	} else { //Real 데이타일 경우
		    		cnt = Integer.parseInt(String.valueOf(map1.get("CNT")+""));
		    		cost = Integer.parseInt(String.valueOf(map1.get("COST")+""));
		    		payAmt = Integer.parseInt(String.valueOf(map1.get("PAY_AMT")+""));

		    		if(cnt == 1) {
			    		map.put("procResult","01"); // 정상납부
			    	} else if(cost < payAmt){
			    		map.put("procResult","03"); // 이중납부
			    	} else {
			    		map.put("procResult","01"); // 정상납부
			    	}
		    		
		    		//2-2.
		    		//수납테이블에 납부여부 세팅하기
		    		sql.setLength(0); //sqlbuffer 초기화
		    		sql.append("UPDATE TB_QUARTER_PAYMENT SET PAY_METHOD_CD = '02',STATUS_CD = '01' WHERE PURCHASE_KEY = ? ");
			    	list_cond_cnt = 1; //초기화
			    	pstmt2 = this.conn.prepareStatement(sql.toString());
			    	pstmt2.setString(list_cond_cnt++,(String)map.get("purchaseKey"));
			    	rlt_code2 = pstmt2.executeUpdate();
			    	System.out.println("수납테이블 업데이트건수:"+rlt_code2);
		    	}
		    	//3.
		    	//수납코드키와 처리 결과(정상납부/이중납부)를 결제테이블에 업데이트하기
		    	sql.setLength(0); //sqlbuffer 초기화
		    	sql.append("UPDATE TB_PAY SET PROC_RESULT= ? ");
		    	sql.append("WHERE PURCHASE_KEY = ? ");
		    	
		    	list_cond_cnt = 1; //초기화
		    	pstmt1 = this.conn.prepareStatement(sql.toString());
		    	pstmt1.setString(list_cond_cnt++,(String)map.get("procResult"));
		    	pstmt1.setString(list_cond_cnt++,(String)map.get("purchaseKey"));
		    	rlt_code1 = pstmt1.executeUpdate();
		    	System.out.println("Pay 업데이트건수:"+rlt_code1);
			}

			if (rlt_code > 0 && rlt_code1 > 0 && rlt_code2 > 0){
				this.conn.commit();
				result= true;
			}else{
				this.conn.rollback();
				result = false;
			}

			if(result == true) {
				resultMap.put("result", "OK");
			
			} else {
				resultMap.put("result", "FAIL");
			}

	    } catch (Exception e) {
	        LOGGER.error(e.getMessage());
	        e.printStackTrace();
	        resultMap.put("result", "FAIL");
	    } finally {
			if ( pstmt != null ) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if ( pstmt1 != null ) {
				try {
					pstmt1.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}		
			if ( pstmt2 != null ) {
				try {
					pstmt2.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}			
			if ( this.conn != null ) {
				try {
					this.conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				this.conn = null;
			}
	    }
		return resultMap;
	}
}
