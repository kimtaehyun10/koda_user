/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */
package com.koticobui.dfmc.client.mem.service;

import java.util.Map;

import com.koticobui.dfmc.client.mem.model.DiscountItemVO;


/**
 * The interface Member service.
 */
public interface MemberService {
	
	/**
	 * Search use member int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int searchUseMember(Map requestMap);
	
	/**
	 * Mber id dupl check int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int mberIdDuplCheck(Map requestMap);
	int carNumberDupCheck(Map requestMap);

	/**
	 * Save member.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	void saveMember(Map requestMap, DiscountItemVO discountItemVO) throws Exception;
	
	/**
	 * find member id.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> findMemberId(Map requestMap);
	
	/**
	 * find password.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> findPassword(Map requestMap);
	
}
