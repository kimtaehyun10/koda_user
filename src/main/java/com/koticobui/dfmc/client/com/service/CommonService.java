/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */
package com.koticobui.dfmc.client.com.service;

import java.util.Map;

import java.util.List;

/**
 * The interface Common service.
 */
public interface CommonService {

	/**
	 * Gen table key string.
	 *
	 * @param requestMap the request map
	 * @return the string
	 */
	String genTableKey(Map<String, Object> requestMap);

	/**
	 * Select code master map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> selectCodeMaster(Map<String, Object> requestMap);

	/**
	 * Search discount item list map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchDiscountItemList(Map<String, Object> requestMap);

	/**
	 * Search use discount item list map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchUseDiscountItemList(Map<String, Object> requestMap);

	/**
	 * Search res section combo map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchResSectionCombo(Map<String, Object> requestMap);

	/**
	 * Search res block combo map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchResBlockCombo(Map<String, Object> requestMap);

	/**
	 * Search res division combo map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchResDivisionCombo(Map<String, Object> requestMap);

	/**
	 * Select car list map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> selectCarList(Map<String, Object> requestMap);

	/**
	 * Search vst manage zone combo map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchVstManageZoneCombo(Map<String, Object> requestMap);

	/**
	 * 환불 사유
	 * @param requestMap
	 * @return
	 */
	Map<String, Object> searchRefundCodeCombo(Map<String, Object> requestMap);

	/**
	 * 은행 목록
	 * @param requestMap
	 * @return
	 */
	Map<String, Object> searchBankCodeCombo(Map<String, Object> requestMap);

	/**
	 * Search vst section combo map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchVstSectionCombo(Map<String, Object> requestMap);

	/**
	 * Search vst block combo map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchVstBlockCombo(Map<String, Object> requestMap);

	/**
	 * Search vst division combo map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchVstDivisionCombo(Map<String, Object> requestMap);

	/**
	 * Search pub manage zone combo map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchPubManageZoneCombo(Map<String, Object> requestMap);

	/**
	 * Search pub section combo map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchPubSectionCombo(Map<String, Object> requestMap);

	/**
	 * Select park map list map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchParkMap(Map<String, Object> requestMap);
	
	
	/**
	 * Search hospital item list map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	//koda사용
	Map<String, Object> searchHospitalCombo();
	
	/**
	 * Search hospital item list map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	//koda사용
	Map<String, Object> searchCommonCode(Map<String, Object> requestMap);

	//koda사용
	String searchMenuUrl(Map<String, Object> requestMap);
	
	//koda사용
	List<Map<String, Object>> searchSubMenuList(Map<String, Object> requestMap);


}
