/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */
package com.koticobui.dfmc.client.com.service;

import java.util.Map;


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
	String genTableKey(Map requestMap);
	
	/**
	 * Select code master map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> selectCodeMaster(Map requestMap);
	
	/**
	 * Search discount item list map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchDiscountItemList(Map requestMap);
	
	/**
	 * Search use discount item list map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchUseDiscountItemList(Map requestMap);
	
	/**
	 * Search res section combo map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchResSectionCombo(Map requestMap);
	
	/**
	 * Search res block combo map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchResBlockCombo(Map requestMap);
	
	/**
	 * Search res division combo map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchResDivisionCombo(Map requestMap);
	
	/**
	 * Select car list map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> selectCarList(Map requestMap);
	
	/**
	 * Search vst manage zone combo map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchVstManageZoneCombo(Map requestMap);
	
	/**
	 * 환불 사유
	 * @param requestMap
	 * @return
	 */
	Map<String, Object> searchRefundCodeCombo(Map requestMap);
	
	/**
	 * 은행 목록
	 * @param requestMap
	 * @return
	 */
	Map<String, Object> searchBankCodeCombo(Map requestMap);

	/**
	 * Search vst section combo map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchVstSectionCombo(Map requestMap);
	
	/**
	 * Search vst block combo map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchVstBlockCombo(Map requestMap);
	
	/**
	 * Search vst division combo map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchVstDivisionCombo(Map requestMap);
	
	/**
	 * Search pub manage zone combo map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchPubManageZoneCombo(Map requestMap);
	
	/**
	 * Search pub section combo map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchPubSectionCombo(Map requestMap);
	
	/**
	 * Select park map list map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchParkMap(Map requestMap);
}
