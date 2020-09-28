/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */
package com.koticobui.dfmc.client.res.service;

import java.util.List;
import java.util.Map;



/**
 * The interface residentService service.
 */
public interface ResidentService {

	/**
	 * Select parking condition list map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> selectParkingConditionList(Map requestMap);
	
	/**
	 * Select division list map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> selectDivisionList(Map requestMap);
	
	/**
	 * Save request.
	 *
	 * @param requestMap the request map
	 * @throws Exception the exception
	 */
	void saveRequest(Map requestMap) throws Exception;
	void updateRequest(Map requestMap) throws Exception;
	
	//IOT차량연동 조회
	List<Map<String, Object>> xmlChange(Map<String, Object> requestMap);
	
}
