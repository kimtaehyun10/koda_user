/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */

package com.koticobui.dfmc.client.com.menu.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by aircha on 2016. 5. 19..
 */
@Controller
public class MemberMenuController {
	
	@Value("#{appConfig['ipin.sSiteCode']}")
    private String sSiteCode;
    @Value("#{appConfig['ipin.sSitePw']}")
    private String sSitePw;
    @Value("#{appConfig['ipin.sReturnURL']}")
    private String sReturnURL;
    
    @Value("#{appConfig['sms.sSmsSiteCode']}")
    private String sSmsSiteCode;
    @Value("#{appConfig['sms.sSmsSitePassword']}")
    private String sSmsSitePassword;
    @Value("#{appConfig['sms.sRequestNumber']}")
    private String sRequestNumber;
    @Value("#{appConfig['sms.sSmsReturnURL']}")
    private String sSmsReturnURL;
	
	//회원관련 메뉴관리
	
	//메인메뉴이동
    //koda사용
	@RequestMapping(value = "/main")
    public String main(HttpServletRequest request, ModelMap model) throws Exception {
		
		return "main";
    }
	
	@RequestMapping(value = "/sessionError")
    public String sessionError(HttpServletRequest request, ModelMap model) throws Exception {
		
		return "sessionError";
    }

	@RequestMapping(value = "/sessionError2")
    public String sessionError2(HttpServletRequest request, ModelMap model) throws Exception {
		
		return "sessionError2";
    }

	//회원가입시 아이핀입력페이지
	@RequestMapping(value = "/mem/memberJoinIpin.c")
	public String memberJoinIpin(HttpServletRequest request, ModelMap model) throws Exception {
		
		request.setAttribute("sSiteCode", sSiteCode);
		request.setAttribute("sSitePw", sSitePw);
		request.setAttribute("sReturnURL", sReturnURL);
		request.setAttribute("sSmsSiteCode", sSmsSiteCode);
		request.setAttribute("sSmsSitePassword", sSmsSitePassword);
		request.setAttribute("sRequestNumber", sRequestNumber);
		request.setAttribute("sSmsReturnURL", sSmsReturnURL);
		
		return "mem/memberJoinIpin";
	}
	
	//회원가입시 아이핀 인증후 이동페이지
	@RequestMapping(value = "/mem/memberJoinIpinConfirm.c")
	public String memberJoinIpinConfirm(HttpServletRequest request, ModelMap model) throws Exception {

		return "mem/memberJoinIpinConfirm";
	}
	
	//회원가입시 SMS 인증후 이동페이지
	@RequestMapping(value = "/mem/memberJoinSmsConfirm.c")
	public String memberJoinSmsConfirm(HttpServletRequest request, ModelMap model) throws Exception {
		
		request.setAttribute("sSiteCode", sSiteCode);
		request.setAttribute("sSitePw", sSitePw);
		request.setAttribute("sReturnURL", sReturnURL);
		request.setAttribute("sSmsSiteCode", sSmsSiteCode);
		request.setAttribute("sSmsSitePassword", sSmsSitePassword);
		request.setAttribute("sRequestNumber", sRequestNumber);
		request.setAttribute("sSmsReturnURL", sSmsReturnURL);

		return "mem/memberJoinSmsConfirm";
	}
	
	//회원가입시 SMS 인증후 실패페이지
	@RequestMapping(value = "/mem/memberJoinFail.c")
	public String memberJoinFail(HttpServletRequest request, ModelMap model) throws Exception {

		return "mem/memberJoinFail";
	}
	
	//회원가입
	@RequestMapping(value = "/mem/memberJoin.c")
    public String memberJoin(HttpServletRequest request, ModelMap model) throws Exception {
		
		request.setAttribute("sSiteCode", sSiteCode);
		request.setAttribute("sSitePw", sSitePw);
		request.setAttribute("sReturnURL", sReturnURL);
		request.setAttribute("sSmsSiteCode", sSmsSiteCode);
		request.setAttribute("sSmsSitePassword", sSmsSitePassword);
		request.setAttribute("sRequestNumber", sRequestNumber);
		request.setAttribute("sSmsReturnURL", sSmsReturnURL);

		return "mem/memberJoin";
    }

	//아이디 비밀번호 찾기 - 아이핀
	@RequestMapping(value = "/mem/memberIpin.c")
	public String memberIpin(HttpServletRequest request, ModelMap model) throws Exception {
		
		request.setAttribute("sSiteCode", sSiteCode);
		request.setAttribute("sSitePw", sSitePw);
		request.setAttribute("sReturnURL", sReturnURL);
		request.setAttribute("sSmsSiteCode", sSmsSiteCode);
		request.setAttribute("sSmsSitePassword", sSmsSitePassword);
		request.setAttribute("sRequestNumber", sRequestNumber);
		request.setAttribute("sSmsReturnURL", sSmsReturnURL);
		
		return "mem/memberIpin";
	}
	
	//아이디 비밀번호 찾기 - 아이핀
	@RequestMapping(value = "/mem/memberIpinConfirm.c")
	public String memberIpinConfirm(HttpServletRequest request, ModelMap model) throws Exception {

		return "mem/memberIpinConfirm";
	}
	
	//아이디 비밀번호 찾기 SMS 인증후 이동페이지
	@RequestMapping(value = "/mem/memberSmsConfirm.c")
	public String memberSmsConfirm(HttpServletRequest request, ModelMap model) throws Exception {
		
		request.setAttribute("sSiteCode", sSiteCode);
		request.setAttribute("sSitePw", sSitePw);
		request.setAttribute("sReturnURL", sReturnURL);
		request.setAttribute("sSmsSiteCode", sSmsSiteCode);
		request.setAttribute("sSmsSitePassword", sSmsSitePassword);
		request.setAttribute("sRequestNumber", sRequestNumber);
		request.setAttribute("sSmsReturnURL", sSmsReturnURL);

		return "mem/memberSmsConfirm";
	}

	//아이디 비밀번호 찾기
	@RequestMapping(value = "/mem/memberFind.c")
	public String memberFind(HttpServletRequest request, ModelMap model) throws Exception {
		
		request.setAttribute("sSiteCode", sSiteCode);
		request.setAttribute("sSitePw", sSitePw);
		request.setAttribute("sReturnURL", sReturnURL);
		request.setAttribute("sSmsSiteCode", sSmsSiteCode);
		request.setAttribute("sSmsSitePassword", sSmsSitePassword);
		request.setAttribute("sRequestNumber", sRequestNumber);
		request.setAttribute("sSmsReturnURL", sSmsReturnURL);
		
		return "mem/memberFind";
	}

}
