/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */

package com.koticobui.dfmc.client.let.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;



/**
 * The interface Customer manage mapper.
 */
@Mapper("letterMapper")
public interface LetterMapper {

	/**
	 * Insert contract info int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int insertLetter(Map requestMap);
	

	/**
	 * Insert contract info int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int insertLetterReturn(Map requestMap);
	

	/**
	 * Insert contract info int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int insertReceiver(Map requestMap);
	

	/**
	 * Insert contract info int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int insertReceiverReturn(Map requestMap);
	

	int insertTempReceiver(Map requestMap);
	

	/**
	 * Insert contract info int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int updateReceiver(Map requestMap);


	/**
	 * Insert contract info int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int selectChkReceiver(Map requestMap);
	
	/**
	 * Insert contract info int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	Map<String, Object> searchReceiverByMath(Map requestMap);
	

	/**
	 * Insert contract info int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	Map<String, Object> searchReturnReceiver(Map requestMap);
	
	
	Map<String, Object> searchTempReceiver(Map requestMap);
	
	
	/**
	 * Insert contract info int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int insertLetterFile(Map requestMap);

	/**
	 * Insert contract info int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int updateLetterFile(Map requestMap);
	

	/**
	 * Insert contract info int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int deleteLetterFile(Map requestMap);

	int deleteLetter(Map requestMap);

	int deleteLetterReceiver(Map requestMap);

	int deleteFileAll(Map requestMap);
	

	/**
	 * Insert contract info int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	List<Map<String, Object>> searchLetterFile(Map requestMap);
	
	Map<String, Object> LetterDownFileRN(Map requestMap);
	
	Map<String, Object> LetterDownFileST(Map requestMap);
	
	/**
	 * Insert contract info int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	Map<String, Object> searchLetterSend(Map requestMap);

	/**
	 * Insert contract info int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	List<Map<String, Object>> searchLetterSendList(Map requestMap);

	/**
	 * Insert contract info int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	Integer searchLetterSendListTot(Map requestMap);	

	/**
	 * Insert contract info int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	Map<String, Object> searchLetterReci(Map requestMap);

	/**
	 * Insert contract info int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	List<Map<String, Object>> searchLetterReciList(Map requestMap);
	

	/**
	 * Select parking condition list tot integer.
	 *
	 * @param requestMap the request map
	 * @return the integer
	 */
	Integer searchLetterReciListTot(Map requestMap);


	/**
	 * Insert contract info int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	Map<String, Object> searchMaxGroup(Map requestMap);


	
}
