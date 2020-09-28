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
public class ResidentMenuController {
	
	//거주자우선주차 메뉴관리
	
	//주차장소개
	@RequestMapping(value = "/res/parkingIntro.c")
    public String parkingIntro(HttpServletRequest request, ModelMap model) throws Exception {
		
		return "res/parkingIntro";
    }
	
	//시행근거
    @RequestMapping(value = "/res/enforcementBasis.c")
    public String enforcementBasis(HttpServletRequest request, ModelMap model) throws Exception {

    	return "res/enforcementBasis";
    }
    
    //단속근거
    @RequestMapping(value = "/res/regulateBasis.c")
    public String regulateBasis(HttpServletRequest request, ModelMap model) throws Exception {

    	return "res/regulateBasis";
    }
    
    //주차장현황
    @RequestMapping(value = "/res/parkingCondition.c")
    public String parkingCondition(HttpServletRequest request, ModelMap model) throws Exception {

    	return "res/parkingCondition";
    }
    
    //모두의주차장소개
    @RequestMapping(value = "/res/moduparkingIntro.c")
    public String moduparkingIntro(HttpServletRequest request, ModelMap model) throws Exception {

    	return "res/moduparkingIntro";
    }
    
    //미납요금안내
    @RequestMapping(value = "/res/defaultChargeInfo.c")
    public String defaultChargeInfo(HttpServletRequest request, ModelMap model) throws Exception {

    	return "res/defaultChargeInfo";
    }
    
    //이용신청
    @RequestMapping(value = "/res/residentRequest.c")
    public String residentRequest(HttpServletRequest request, ModelMap model) throws Exception {

    	return "res/residentRequest";
    }
    
}
