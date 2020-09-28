/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */

package com.koticobui.dfmc.client.mem.mapper;

import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * The interface Customer manage mapper.
 */
@Mapper("memberMapper")
public interface MemberMapper {
	
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
	 * Insert member int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int insertMember(Map requestMap);
	
	/**
	 * Insert car int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int insertCar(Map requestMap);

	/**
	 * Insert discount detail int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int insertDiscountDetail(Map requestMap);

	/**
	 * find member id.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> findMemberId(Map requestMap);
	
	/**
	 * Update password int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int updatePassword(Map requestMap);
	
}
