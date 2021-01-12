/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */
package com.koticobui.dfmc.client.mem.service;

import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

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
	
	int chkPassword(Map requestMap);
	
	int carNumberDupCheck(Map requestMap);

	/**
	 * Save member.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
    @Transactional
	void saveMember(Map requestMap) throws Exception;

    @Transactional
	void updateMember(Map requestMap) throws Exception;

    @Transactional
	void extMember(Map requestMap) throws Exception;
    
    @Transactional
    int updatePw(Map requestMap);

	//사용자정보 조회
	Map<String, Object> searchMember(Map requestMap);
	
	/**
	 * find member id.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> findMemberId(Map requestMap);
	
	

	/**
	 * Mber id dupl check int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int mberIdDuplCheck(Map requestMap);

	/**
	 * Mber id dupl check int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int mberNickNameDuplCheck(Map requestMap);
}
