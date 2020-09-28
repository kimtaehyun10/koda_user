/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */

package com.koticobui.dfmc.client.sup.mapper;

import java.util.List;
import java.util.Map;

import com.koticobui.dfmc.client.sup.model.SupportVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * The interface Customer manage mapper.
 */
@Mapper("supportMapper")
public interface SupportMapper {

	/**
	 * Select division list tot integer.
	 *
	 * @param requestMap the request map
	 * @return the integer
	 */
	Integer selectNoticeListTot(Map requestMap);

	/**
	 * Select division list map.
	 *
	 * @param requestMap the request map
	 * @return the list
	 */
	//List<Map<String, String[]>> selectNoticeList(Map requestMap);
	List<SupportVO> selectNoticeList(Map requestMap);
	
	Integer selectRegulatePaymentListTot(Map requestMap);
	
	List<Map<String, String[]>> selectRegulatePaymentList(Map requestMap);	
	
}
