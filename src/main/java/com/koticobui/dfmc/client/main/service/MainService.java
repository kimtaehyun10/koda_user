package com.koticobui.dfmc.client.main.service;

import java.util.List;
import java.util.Map;

public interface MainService {

	List<Map<String, Object>> mainBoardList(Map<String, Object> requestMap);

	List<Map<String, Object>> mainSurveyList(Map<String, Object> requestMap);

	List<Map<String, Object>> mainBannerList(Map<String, Object> requestMap);

}
