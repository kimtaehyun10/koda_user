/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */

package com.koticobui.dfmc.client.donate.mapper;

import java.util.List;
import java.util.Map;

import com.koticobui.dfmc.client.donate.model.DonateSearchVO;
import com.koticobui.dfmc.client.donate.model.DonateVO;
import com.koticobui.dfmc.client.donate.model.StoryVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;



/**
 * The interface Customer manage mapper.
 */
@Mapper("donateMapper")
public interface DonateMapper {
	
	int updateLike(DonateVO donateBean);
	
	int donateReplyInsert(DonateVO donateBean);

	List<Map<String, Object>> getDonateComList(DonateSearchVO donateSearchBean);
	
	int getDonateComCount(DonateSearchVO donateSearchBean);
	
	List<Map<String, Object>> getDonateYearList();
	
	Map<String, Object> getDonate(DonateSearchVO donateSearchBean);
	
	List<Map<String, Object>> getDonateList(DonateSearchVO donateSearchBean);
	
	int getDonateCount(DonateSearchVO donateSearchBean);
	
	List<Map<String, Object>> getStoryList(DonateSearchVO donateSearchBean);
	
	int getStoryCount(DonateSearchVO donateSearchBean);

	Map<String, Object> getStory(DonateSearchVO donateSearchBean);

	int getStoryComCount(DonateSearchVO donateSearchBean);
	
	List<Map<String, Object>> getStoryComList(DonateSearchVO donateSearchBean);	

	int storyDelete(DonateSearchVO donateSearchBean);
	
	int addStory(StoryVO storyBean);
	
	int updateStory(StoryVO storyBean);
	
	int storyComInsert(StoryVO storyBean);
	
	int storyComDelete(DonateSearchVO donateSearchBean);
	
	int updateStoryHits(DonateSearchVO donateSearchBean);
	
	int checkPwd(DonateSearchVO donateSearchBean);

	//void insertChoice(DonateVO donateBean);


}
