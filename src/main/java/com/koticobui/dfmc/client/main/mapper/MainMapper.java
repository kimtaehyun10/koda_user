package com.koticobui.dfmc.client.main.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mainMapper")
public interface MainMapper {

	List<Map<String, Object>> mainBoardList(Map<String, Object> requestMap);

	List<Map<String, Object>> mainSurveyList(Map<String, Object> requestMap);

	List<Map<String, Object>> mainBannerList(Map<String, Object> requestMap);

	List<Map<String, Object>> bannerList(Map<String, Object> requestMap);

	List<Map<String, Object>> scheduleList(Map<String, Object> requestMap);

}
