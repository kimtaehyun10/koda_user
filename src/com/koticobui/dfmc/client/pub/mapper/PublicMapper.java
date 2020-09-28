/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */

package com.koticobui.dfmc.client.pub.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * The interface Customer manage mapper.
 */
@Mapper("publicMapper")
public interface PublicMapper {
	
	/**
	 * Select parking intro list map.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> selectParkingIntroList(Map requestMap);
	
	/**
	 * Select section list tot integer.
	 *
	 * @param requestMap the request map
	 * @return the integer
	 */
	Integer selectSectionListTot(Map requestMap);

	/**
	 * Select section list map.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> selectSectionList(Map requestMap);
	
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
	
	/**
	 * Insert quarter payment int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int insertQuarterPayment(Map requestMap);
	
	/**
	 * Select standby list map.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> selectStandbyMe(Map requestMap);

	Map<String, String> selectStandbyMax(Map requestMap);
	
	/**
	 * 공영주차 신청여부  
	 * @param requestMap
	 * @return
	 */
	Integer selectStandbyMyList(Map requestMap);

	int updateMberFlag(Map requestMap);

	List<Map<String, Object>> selectAssignList(Map<String, Object> requestMap);
}
