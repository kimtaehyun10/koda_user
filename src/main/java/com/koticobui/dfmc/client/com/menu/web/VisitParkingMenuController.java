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
public class VisitParkingMenuController {
	
	//방문주차 메뉴관리
	
	//방문주차
	@RequestMapping(value = "/vst/visitParking.c")
    public String visitParking(HttpServletRequest request, ModelMap model) throws Exception {

		return "vst/visitParking";
    }
	
	//이용신청
	@RequestMapping(value = "/vst/visitRequest.c")
    public String visitRequest(HttpServletRequest request, ModelMap model) throws Exception {

		return "vst/visitRequest";
    }
	
}
