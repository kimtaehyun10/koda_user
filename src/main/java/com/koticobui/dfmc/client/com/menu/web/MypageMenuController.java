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
public class MypageMenuController {
	
	//나의주차정보 메뉴관리
	
	//주차장계약/결제
	@RequestMapping(value = "/mypage/parkingContract.c")
    public String parkingContract(HttpServletRequest request, ModelMap model) throws Exception {

		return "mypage/parkingContract";
    }

	//주차요금결제
	@RequestMapping(value = "/mypage/parkingCharge.c")
	public String parkingCharge(HttpServletRequest request, ModelMap model) throws Exception {

		return "mypage/refundRequest";
	}
	
	//대기현황조회
	@RequestMapping(value = "/mypage/standbyStatus.c")
    public String standbyStatus(HttpServletRequest request, ModelMap model) throws Exception {

		return "mypage/standbyStatus";
    }
	
	//정보수정 전 로그인
	@RequestMapping(value = "/mypage/myInfoReconfirm.c")
    public String myInfoReconfirm(HttpServletRequest request, ModelMap model) throws Exception {

		return "mypage/myInfoReconfirm";
    }

	//정보수정
	@RequestMapping(value = "/mypage/modifyMyInfo.c")
	public String modifyMyInfo(HttpServletRequest request, ModelMap model) throws Exception {

		return "mypage/modifyMyInfo";
	}
	
	//회원탈퇴 전 로그인
	@RequestMapping(value = "/mypage/outReconfirm.c")
    public String outReconfirm(HttpServletRequest request, ModelMap model) throws Exception {

		return "mypage/outReconfirm";
    }

	//회원탈퇴
	@RequestMapping(value = "/mypage/memberOut.c")
	public String memberOut(HttpServletRequest request, ModelMap model) throws Exception {

		return "mypage/memberOut";
	}
	
}
