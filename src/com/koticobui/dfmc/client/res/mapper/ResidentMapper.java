/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */

package com.koticobui.dfmc.client.res.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;



/**
 * The interface Customer manage mapper.
 */
@Mapper("residentMapper")
public interface ResidentMapper {
	
	/**
	 * Select parking condition list tot integer.
	 *
	 * @param requestMap the request map
	 * @return the integer
	 */
	Integer selectParkingConditionListTot(Map requestMap);

	/**
	 * Select parking condition list map.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> selectParkingConditionList(Map requestMap);
	
	/**
	 * Select division list tot integer.
	 *
	 * @param requestMap the request map
	 * @return the integer
	 */
	Integer selectDivisionListTot(Map requestMap);

	/**
	 * Select division list map.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> selectDivisionList(Map requestMap);
	
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
	 * Select discount detail null contract key list list.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map> selectDiscountDetailNullContractKeyList(Map requestMap);
	
	/**
	 * Insert discount detail int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int insertDiscountDetail(Map requestMap);
	
	/**
	 * Insert hope request section int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int insertHopeRequestSection(Map requestMap);
	int updateHopeRequestSection(Map requestMap);
	int updateRequestDate(Map requestMap);
	int updateMberFlag(Map requestMap);
	
	/**
	 * Insert quarter payment int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int insertQuarterPayment(Map requestMap);
	
	List<Map<String, Object>> xmlChange(Map<String, Object> requestMap);
	
}
