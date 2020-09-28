/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */
package com.koticobui.dfmc.client.pub.service;

import java.util.List;
import java.util.Map;


/**
 * The interface Public service.
 */
public interface PublicService {
	
	/**
	 * Select parking intro list map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> selectParkingIntroList(Map requestMap);
	
	/**
	 * Select section list map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> selectSectionList(Map requestMap);
	
	/**
	 * Save request.
	 *
	 * @param requestMap the request map
	 * @throws Exception the exception
	 */
	void saveRequest(Map requestMap) throws Exception;
	
	/**
	 * Select standby list map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> selectStandbyMe(Map requestMap);

	Map<String, String> selectStandbyMax(Map requestMap);

	
	Map<String, Object> selectStandbyMyList(Map requestMap);

	List<Map<String, Object>> selectAssignList(Map<String, Object> requestMap);
}
