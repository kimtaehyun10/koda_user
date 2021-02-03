package com.koticobui.dfmc.client.main.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.koticobui.dfmc.client.main.mapper.MainMapper;
import com.koticobui.dfmc.client.main.service.MainService;
import com.koticobui.dfmc.client.pb.mapper.PublicMapper;
import com.koticobui.dfmc.client.pb.model.PublicSearchVO;

@Service("mainService")
public class MainServiceImpl implements MainService {

	@Resource(name = "mainMapper")
	private MainMapper mainMapper;

    @Resource(name = "publicMapper")
    private PublicMapper publicMapper; 
	
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

	@Override
	public List<Map<String, Object>> mainOrganEventList(HttpServletRequest request) {		
		PublicSearchVO prSearch = new PublicSearchVO();
		prSearch.setArticleCount(10);
        prSearch.setCurrentPage(1);        
        prSearch.setBrdNo(20);        
        int totalCnt = publicMapper.getBoardCount(prSearch);
        prSearch.setTotalCount(totalCnt);        		
		return publicMapper.getBoardList(prSearch);
	}

	@Override
	public List<Map<String, Object>> mainLifeSharingList(HttpServletRequest request) {
		PublicSearchVO prSearch = new PublicSearchVO();
		prSearch.setArticleCount(12);
        prSearch.setCurrentPage(1);        
        prSearch.setBrdNo(30);        
        int totalCnt = publicMapper.getBoardCount(prSearch);
        prSearch.setTotalCount(totalCnt);        		
		return publicMapper.getBoardList(prSearch);		
	}

	@Override
	public List<Map<String, Object>> bannerList(Map<String, Object> requestMap) {

		return mainMapper.bannerList(requestMap);
	}

	@Override
	public List<Map<String, Object>> scheduleList(Map<String, Object> requestMap) {

		return mainMapper.scheduleList(requestMap);
	}

	@Override
	public List<Map<String, Object>> mainDonateTrend(Map<String, Object> requestMap) {

		return mainMapper.mainDonateTrend(requestMap);
	}

	@Override
	public List<Map<String, Object>> mainDonateToday(Map<String, Object> requestMap) {

		return mainMapper.mainDonateToday(requestMap);
	}
}
