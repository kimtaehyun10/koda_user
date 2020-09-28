/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */

package com.koticobui.dfmc.client.com.menu.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Created by aircha on 2016. 5. 19..
 */
@Controller
public class SupportMenuController {
	
	//고객지원 메뉴관리
	
	//공지사항
	@RequestMapping(value = "/sup/notice.c")
    public String notice(HttpServletRequest request, ModelMap model) throws Exception {

		return "sup/notice";
    }

	//공지사항 - 세부내용 팝업
	@RequestMapping(value = "/sup/popup/noticePopup.p")
	public String noticePopup(HttpServletRequest request, ModelMap model) throws Exception {

		return "sup/popup/noticePopup";
	}
	
	//자주묻는질문
	@RequestMapping(value = "/sup/qna.c")
    public String qna(HttpServletRequest request, ModelMap model) throws Exception {

		return "sup/qna";
    }
	
	//전화번호안내
	@RequestMapping(value = "/sup/phoneInfo.c")
    public String phoneInfo(HttpServletRequest request, ModelMap model) throws Exception {

		return "sup/phoneInfo";
    }
	
	//찾아오시는길
	@RequestMapping(value = "/sup/visitMap.c")
    public String visitMap(HttpServletRequest request, ModelMap model) throws Exception {

		return "sup/visitMap";
    }
	
	@RequestMapping(value = "/sup/parkingCharge.c")
	public String parkingCharge(@RequestParam("carNumber") String carNumber, HttpServletRequest request, ModelMap model) throws Exception {

		return "sup/parkingCharge";
	}
	
}
