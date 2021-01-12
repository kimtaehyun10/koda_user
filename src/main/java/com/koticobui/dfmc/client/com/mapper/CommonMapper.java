/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */

package com.koticobui.dfmc.client.com.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * The interface Common mapper.
 */
@Mapper("commonMapper")
public interface CommonMapper {
	
	/**
	 * Gen table key string.
	 *
	 * @param requestMap the request map
	 * @return the string
	 */
	String genTableKey(Map requestMap);
	
	/**
	 * Select code master list.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> selectCodeMaster(Map requestMap);
	
	/**
	 * Search discount item list list.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, Object>> searchDiscountItemList(Map requestMap);
	
	/**
	 * Search use discount item list list.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, Object>> searchUseDiscountItemList(Map requestMap);
	
	/**
	 * Search res section combo list.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> searchResSectionCombo(Map requestMap);
	
	/**
	 * Search res block combo list.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> searchResBlockCombo(Map requestMap);
	
	/**
	 * Search res division combo list.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> searchResDivisionCombo(Map requestMap);
	
	/**
	 * Select car list map.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> selectCarList(Map requestMap);
	
	/**
	 * Search vst manage zone combo list.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> searchVstManageZoneCombo(Map requestMap);
	
	List<Map<String, String[]>> searchRefundCodeCombo(Map requestMap);
	
	List<Map<String, String[]>> searchBankCodeCombo(Map requestMap);
	
	/**
	 * Search vst section combo list.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> searchVstSectionCombo(Map requestMap);
	
	/**
	 * Search vst block combo list.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> searchVstBlockCombo(Map requestMap);
	
	/**
	 * Search vst division combo list.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> searchVstDivisionCombo(Map requestMap);
	
	/**
	 * Search pub manage zone combo list.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> searchPubManageZoneCombo(Map requestMap);
	
	/**
	 * Search pub section combo list.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> searchPubSectionCombo(Map requestMap);

	
	String encodingHashData(@Param("password")  String password);
	
	/**
	 * Select park map list map.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, Object[]>> searchParkMap(Map requestMap);
	
	int insertSession(String session);
	
	int updateFailCount(String mberId);
	int resetFailCount(String mberId);
	
	/**
	 * Search pub section combo list.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	//kodause
	List<Map<String, Object[]>> searchHospitalCombo();

	/**
	 * Search Organ combo list.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	//kodause
	List<Map<String, Object[]>> searchCommonCode(Map requestMap);

	//kodause
	String searchMenuUrl(Map requestMap);

	//kodause
	List<Map<String, Object>> searchSubMenuList(Map requestMap);
	
	
}
