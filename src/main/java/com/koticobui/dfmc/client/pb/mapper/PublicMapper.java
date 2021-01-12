/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */

package com.koticobui.dfmc.client.pb.mapper;

import java.util.List;
import java.util.Map;

import com.koticobui.dfmc.client.pb.model.BrainSearchVO;
import com.koticobui.dfmc.client.pb.model.PublicSearchVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;



/**
 * The interface Customer manage mapper.
 */
@Mapper("publicMapper")
public interface PublicMapper {
	

	int getBoardCount(PublicSearchVO prSearch);

	List<Map<String, Object>> getBoardList(PublicSearchVO prSearch);
	
	Map<String, Object> getBoard(PublicSearchVO prSearch);
	
	int updateReadNum(PublicSearchVO prSearch);
	
	List<Map<String, Object>> getHospitalList(BrainSearchVO brainSearch);

	List<Map<String, Object>> getBrainDonateStatsYearList();
	
	List<Map<String, Object>> getBrainDonateStatsMonthList(String year);
	
	List<Map<String, Object>> getBrainDonateStatsMonthSum(PublicSearchVO prSearch);
	
	List<Map<String, Object>> getBrainDonateStats(PublicSearchVO prSearch);
	
	List<Map<String, Object>> getOrganDonateStats();

	List<Map<String, Object>> getFile(PublicSearchVO prSearch);

	List<Map<String, Object>> getHopeDonateStats();
	
}
