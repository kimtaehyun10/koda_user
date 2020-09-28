/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */
package com.koticobui.dfmc.client.sup.service;

import java.util.Map;

/**
 * The interface Support service.
 */
public interface SupportService {
	
	/**
	 * Select notice list map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> selectNoticeList(Map requestMap);
	
	Map<String, Object> selectRegulatePaymentList(Map requestMap);
}
