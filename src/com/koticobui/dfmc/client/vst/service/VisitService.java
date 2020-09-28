/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */
package com.koticobui.dfmc.client.vst.service;

import java.util.Map;


/**
 * The interface Visit service.
 */
public interface VisitService {
	
	/**
	 * Select car list map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> selectCarList(Map requestMap);
	
	Map<String, Object> selectBlockList(Map requestMap);
	
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
	
}
