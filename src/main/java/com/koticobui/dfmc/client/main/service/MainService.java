package com.koticobui.dfmc.client.main.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface MainService {

	List<Map<String, Object>> mainBoardList(Map<String, Object> requestMap);

	List<Map<String, Object>> mainSurveyList(Map<String, Object> requestMap);

	List<Map<String, Object>> mainBannerList(Map<String, Object> requestMap);

	List<Map<String, Object>> mainOrganEventList(HttpServletRequest request);

	List<Map<String, Object>> mainLifeSharingList(HttpServletRequest request);

	List<Map<String, Object>> bannerList(Map<String, Object> requestMap);

	List<Map<String, Object>> scheduleList(Map<String, Object> requestMap);

}
