/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */
package com.koticobui.dfmc.client.mypage.service;

import java.util.Map;

import com.koticobui.dfmc.client.mypage.model.DiscountItemVO;

/**
 * The interface Mypage service.
 */
public interface MypageService {
	
	/**
	 * Select contract list map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> selectContractList(Map requestMap);
	
	Map<String, Object> selectMemberStatus(Map requestMap);
	
	/**
	 * Select payment list map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> selectPaymentList(Map requestMap);
	
	/**
	 * Select regulate payment list map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> selectRegulatePaymentList(Map requestMap);
	
	Map<String, Object> selectRequestRefund(Map requestMap);
	
	/**
	 * Confirm password.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int confirmPassword(Map requestMap);
	
	int refundRequest(Map requestMap);
	/**
	 * Search member info.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> searchMemberInfo(Map requestMap);
	
	/**
	 * Update member.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	void updateMember(Map requestMap, DiscountItemVO discountItemVO) throws Exception;
	
	/**
	 * Member out.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	void memberOut(Map requestMap) throws Exception;
	
	/**
	 * Select standby status list map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
	Map<String, Object> selectStandbyStatusList(Map requestMap);
	Map<String, Object> selectPPStandbyList(Map requestMap);
	
	/**
	 * Cancel request map.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	void cancelRequest(Map requestMap) throws Exception;
	
	
	
	
	
	
	
	

	int savePay(Map requestMap) throws Exception;
	
}
