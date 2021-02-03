package com.koticobui.dfmc.client.com.menu.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.koticobui.dfmc.client.main.service.MainService;

/**
 * Created by aircha on 2016. 6. 26..
 */
@Controller
public class MainPageController {
	
	@Resource(name = "mainService")
	private MainService mainservice;
	
	@RequestMapping(value = "/")
	public String mainRootPage(ModelAndView modelAndView, String loginError) {
		modelAndView.addObject("loginError", loginError);
		return "redirect:main.c";
	}
	
	@RequestMapping(value = "/main.c")
	public ModelAndView mainPage(ModelAndView modelAndView, String loginError, Map<String, Object> requestMap, HttpServletRequest request) {
		//메인 배너
		List<Map<String, Object>> mainBannerList = mainservice.mainBannerList(requestMap);
		modelAndView.addObject("mainBannerList",mainBannerList);
		
		//메인 기관소식
		List<Map<String, Object>> mainOrganEventList = mainservice.mainOrganEventList(request);
		modelAndView.addObject("mainOrganEventList",mainOrganEventList);
		
		//메인 생명나눔 스토리
		List<Map<String, Object>> mainLifeSharingList = mainservice.mainLifeSharingList(request);
		modelAndView.addObject("mainLifeSharingList",mainLifeSharingList);
		
		//하단 배너
		List<Map<String, Object>> bannerList = mainservice.bannerList(requestMap);
		modelAndView.addObject("bannerList",bannerList);
		
		//메인 뇌사장기기증자, 조직기증자
		int eDonate=0; //조직기증
		int tDonate=0; //장기기증
		List<Map<String, Object>> mainDonateTrend = mainservice.mainDonateTrend(requestMap);
		modelAndView.addObject("mainDonateTrend",mainDonateTrend);
		List<Map<String, Object>> mainDonateToday = mainservice.mainDonateToday(requestMap);		
		if(mainDonateToday != null){
			for(int i=0;i<mainDonateToday.size();i++){
				eDonate += Integer.parseInt(String.valueOf(mainDonateToday.get(i).get("edonor")));
				tDonate += Integer.parseInt(String.valueOf(mainDonateToday.get(i).get("tdonor")));
			}
		}
		modelAndView.addObject("eDonate",eDonate);
		modelAndView.addObject("tDonate",tDonate);
		
		modelAndView.addObject("loginError", loginError);
		modelAndView.setViewName("main");
		return modelAndView;
	}

	//전체맵
	@RequestMapping(value = "/map/parkingMap.c")
	public String parkingMap(
			@RequestParam("openType") String openType
			, @RequestParam("searchManageZone") String searchManageZone
			, @RequestParam("searchParkSectionKey") String searchParkSectionKey
			, @RequestParam("searchParkBlockKey") String searchParkBlockKey
			, @RequestParam("searchParkDivisionKey") String searchParkDivisionKey
			, ModelMap model) throws Exception {

		return "map/parkingMap";
	}

	//하루보기 팝업 창
	@RequestMapping(value = "/map/dailyPopup")
	public String dailyPopup(HttpServletRequest request, ModelMap model) throws Exception {
		//Map<String, Object> list = publicTimeParkingManageService.selectEntryBillList(timeParkReceiveKey, nowFinalDisparity);
		//model.addAttribute("list", list.get("list"));
		return "map/dailyPopup";
	}

	//이미지 팝업 창
	@RequestMapping(value = "/map/imagePopup")
	public String imagePopup(HttpServletRequest request, ModelMap model) throws Exception {
		return "map/imagePopup";
	}

	@RequestMapping(value = "/map/emailPopup")
	public String emailPopup(HttpServletRequest request, ModelMap model) throws Exception {
		return "map/emailPopup";
	}

}
