/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */

package com.koticobui.dfmc.client.com.menu.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by aircha on 2016. 5. 19..
 */
@Controller
public class PublicParkingMenuController {
	
	//공영주차 메뉴관리
	
	//주차장소개
	@RequestMapping(value = "/pub/parkingIntro.c")
    public String parkingIntro(HttpServletRequest request, ModelMap model) throws Exception {

		return "pub/parkingIntro";
    }
	
    //주차장현황
    @RequestMapping(value = "/pub/parkingCondition.c")
    public String parkingCondition(HttpServletRequest request, ModelMap model) throws Exception {

    	return "pub/parkingCondition";
    }
    
    //미납요금안내
    @RequestMapping(value = "/pub/defaultChargeInfo.c")
    public String defaultChargeInfo(HttpServletRequest request, ModelMap model) throws Exception {

    	return "pub/defaultChargeInfo";
    }
    
    //이용신청
    @RequestMapping(value = "/pub/publicRequest.c")
    public String publicRequest(HttpServletRequest request, ModelMap model) throws Exception {

    	return "pub/publicRequest";
    }
    
    //주차장 상세보기 팝업
    @RequestMapping(value = "/pub/popup/sectionInfoPopup.p")
    public String sectionInfoPopup(HttpServletRequest request, ModelMap model) throws Exception {

    	return "pub/popup/sectionInfoPopup";
    }
    
    //대기자정보 팝업
    @RequestMapping(value = "/pub/popup/standbyInfoPopup.p")
    public String standbyInfoPopup(HttpServletRequest request, ModelMap model) throws Exception {

    	return "pub/popup/standbyInfoPopup";
    }
}
