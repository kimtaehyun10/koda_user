/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */

package com.koticobui.dfmc.client.vst.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;



/**
 * The interface Customer manage mapper.
 */
@Mapper("visitMapper")
public interface VisitMapper {
	
	/**
	 * Select car list map.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> selectCarList(Map requestMap);
	
	/**
	 * Select division list tot integer.
	 *
	 * @param requestMap the request map
	 * @return the integer
	 */
	Integer selectDivisionListTot(Map requestMap);
	
	Integer selectBlockListTot(Map requestMap);

	/**
	 * Select division list map.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> selectDivisionList(Map requestMap);
	
	List<Map<String, String[]>> selectBlockList(Map requestMap);
	
	/**
	 * Insert assign section int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int insertAssignSection(Map requestMap);
	
	/**
	 * Insert contract info int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int insertContractInfo(Map requestMap);
	
	/**
	 * Insert contract history int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int insertContractHistory(Map requestMap);
	
	/**
	 * Select visit park charge int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int selectVisitParkCharge(Map requestMap);
	
	/**
	 * Insert quarter payment int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int insertQuarterPayment(Map requestMap);
	
	int updateMberFlag(Map requestMap);
	
}
