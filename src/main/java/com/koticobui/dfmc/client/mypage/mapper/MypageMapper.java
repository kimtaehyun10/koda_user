/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */

package com.koticobui.dfmc.client.mypage.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * The interface Customer manage mapper.
 */
@Mapper("mypageMapper")
public interface MypageMapper {
	
	/**
	 * Select contract list tot integer.
	 *
	 * @param requestMap the request map
	 * @return the integer
	 */
	Integer selectContractListTot(Map requestMap);

	/**
	 * Select contract list map.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> selectContractList(Map requestMap);
	
	/**
	 * Select payment list tot integer.
	 *
	 * @param requestMap the request map
	 * @return the integer
	 */
	Integer selectPaymentListTot(Map requestMap);

	/**
	 * Select payment list map.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> selectPaymentList(Map requestMap);
	
	/**
	 * Select payment list tot integer.
	 *
	 * @param requestMap the request map
	 * @return the integer
	 */
	Integer selectRegulatePaymentListTot(Map requestMap);
	
	Integer selectRequestRefundTot(Map requestMap);

	/**
	 * Select payment list map.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> selectRegulatePaymentList(Map requestMap);
	
	List<Map<String, String[]>> selectRequestRefund(Map requestMap);
	
	/**
     * Confirm password.
     *
     * @param requestMap the request map
     * @return the map
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
	
	Map<String, Object> selectMemberStatus(Map requestMap);
	
	/**
	 * Update member int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int updateMember(Map requestMap);
	
	/**
	 * Update car int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int updateCar(Map requestMap);
	
	/**
	 * 회원정보 삭제
	 * @param requestMap
	 * @return
	 */
	int deleteTagCustomer(Map requestMap);
	
	/**
	 * Delete discount detail int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int deleteDiscountDetail(Map requestMap);
	
	/**
	 * Insert discount detail int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int insertDiscountDetail(Map requestMap);
	
	/**
	 * Delete memo int.
	 *
	 * @param memoVO the memo vo
	 * @return the int
	 * @throws Exception the exception
	 */
	int deleteMemo(Map requestMap) throws Exception;
	
	/**
	 * Delete discount detail int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int outDeleteDiscountDetail(Map requestMap);
	
	/**
	 * Delete hope request section int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int deleteHopeRequestSection(Map requestMap);
	
	/**
	 * Delete assign score detail int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int deleteAssignScoreDetail(Map requestMap);
	
	/**
	 * Delete quarter payment int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int deleteQuarterPayment(Map requestMap);
	
	/**
	 * Delete contract history int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int deleteContractHistory(Map requestMap);
	
	/**
	 * Delete contract info int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int deleteContractInfo(Map requestMap);
	
	/**
	 * Delete car int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int deleteCar(Map requestMap);
	
	/**
	 * Delete customer int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int deleteCustomer(Map requestMap);
	
	/**
	 * Select standby status list tot integer.
	 *
	 * @param requestMap the request map
	 * @return the integer
	 */
	Integer selectStandbyStatusListTot(Map requestMap);
	Integer selectPPStandbyListTot(Map requestMap);

	/**
	 * Select standby status list map.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	List<Map<String, String[]>> selectStandbyStatusList(Map requestMap);
	List<Map<String, String[]>> selectPPStandbyList(Map requestMap);
	
	/**
	 * Delete discount detail int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int requestDeleteDiscountDetail(Map requestMap);
	
	/**
	 * Delete hope request section int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int requestDeleteHopeRequestSection(Map requestMap);
	
	/**
	 * Delete quarter payment int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int requestDeleteQuarterPayment(Map requestMap);
	
	/**
	 * Delete contract history int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int requestDeleteContractHistory(Map requestMap);
	
	/**
	 * Delete contract info int.
	 *
	 * @param requestMap the request map
	 * @return the int
	 */
	int requestDeleteContractInfo(Map requestMap);
	
	
	
	
	
	
	
	
	

	int insertPay(Map requestMap);

	String selectOcrNo(Map requestMap);
	
}
