package com.koticobui.dfmc.client.main.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.koticobui.dfmc.client.main.mapper.MainMapper;
import com.koticobui.dfmc.client.main.service.MainService;

@Service("mainService")
public class MainServiceImpl implements MainService {

	@Resource(name = "mainMapper")
	private MainMapper mainMapper;

	@Override
	public List<Map<String, Object>> mainBoardList(Map<String, Object> requestMap) {

		return mainMapper.mainBoardList(requestMap);
	}

	@Override
	public List<Map<String, Object>> mainSurveyList(Map<String, Object> requestMap) {

		return mainMapper.mainSurveyList(requestMap);
	}

	@Override
	public List<Map<String, Object>> mainBannerList(Map<String, Object> requestMap) {
		
		return mainMapper.mainBannerList(requestMap);
	}
}
