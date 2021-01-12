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
public class MobileMenuController {
	
	//메인메뉴
	@RequestMapping(value = "/m/main")
    public String main(HttpServletRequest request, ModelMap model) throws Exception {
		
		return "mobile/m_main";
    }
	
	/*거주자 우선주차 메뉴*/
	//주차장소개
	@RequestMapping(value = "/m/res/parkingIntro.m")
    public String parkingIntro(HttpServletRequest request, ModelMap model) throws Exception {
		
		return "mobile/res/m_parkingIntro";
    }
	
	//시행근거
    @RequestMapping(value = "/m/res/enforcementBasis.m")
    public String enforcementBasis(HttpServletRequest request, ModelMap model) throws Exception {

    	return "mobile/res/m_enforcementBasis";
    }
    
    //단속근거
    @RequestMapping(value = "/m/res/regulateBasis.m")
    public String regulateBasis(HttpServletRequest request, ModelMap model) throws Exception {

    	return "mobile/res/m_regulateBasis";
    }
    
    //주차장현황
    @RequestMapping(value = "/m/res/parkingCondition.m")
    public String parkingCondition(HttpServletRequest request, ModelMap model) throws Exception {

    	return "mobile/res/m_parkingCondition";
    }
    
    //모두의주차장소개
    @RequestMapping(value = "/m/res/moduparkingIntro.m")
    public String moduparkingIntro(HttpServletRequest request, ModelMap model) throws Exception {

    	return "mobile/res/m_moduparkingIntro";
    }
    
    //미납요금안내
    @RequestMapping(value = "/m/res/defaultChargeInfo.m")
    public String defaultChargeInfo(HttpServletRequest request, ModelMap model) throws Exception {

    	return "mobile/res/m_defaultChargeInfo";
    }
    
    
    /*방문주차 메뉴*/
    //방문주차
    @RequestMapping(value = "/m/vst/visitParking.m")
    public String visitParking(HttpServletRequest request, ModelMap model) throws Exception {

    	return "mobile/vst/m_visitParking";
    }
    
    
    /*공영주차 메뉴*/
    //주차장소개
	@RequestMapping(value = "/m/pub/parkingIntro.m")
	public String pubParkingIntro(HttpServletRequest request, ModelMap model) throws Exception {
	
		return "mobile/pub/m_parkingIntro";
	}
	
	//주차장현황
	@RequestMapping(value = "/m/pub/parkingCondition.m")
	public String pubParkingCondition(HttpServletRequest request, ModelMap model) throws Exception {
	
		return "mobile/pub/m_parkingCondition";
	}
	
	//미납요금안내
	@RequestMapping(value = "/m/pub/defaultChargeInfo.m")
	public String pubDefaultChargeInfo(HttpServletRequest request, ModelMap model) throws Exception {
	
		return "mobile/pub/m_defaultChargeInfo";
	}
    
	
	/*견인보관소 메뉴*/
	//견인보관소안내
	@RequestMapping(value = "/m/tow/towStorageInfo.m")
    public String towStorageInfo(HttpServletRequest request, ModelMap model) throws Exception {

		return "mobile/tow/m_towStorageInfo";
    }
    
	
	/*나의주차정보  메뉴*/
	//주차장계약
	@RequestMapping(value = "/m/mypage/parkingContract.m")
    public String parkingContract(HttpServletRequest request, ModelMap model) throws Exception {

		return "mobile/mypage/m_parkingContract";
    }
	
	//대기현황조회
	@RequestMapping(value = "/m/mypage/standbyStatus.m")
    public String standbyStatus(HttpServletRequest request, ModelMap model) throws Exception {

		return "mobile/mypage/m_standbyStatus";
    }
	
	
	/*고객지원  메뉴*/
	//공지사항
	@RequestMapping(value = "/m/sup/notice.m")
    public String notice(HttpServletRequest request, ModelMap model) throws Exception {

		return "mobile/sup/m_notice";
    }
	
	//자주묻는질문
	@RequestMapping(value = "/m/sup/qna.m")
    public String qna(HttpServletRequest request, ModelMap model) throws Exception {

		return "mobile/sup/m_qna";
    }
	
	//전화번호안내
	@RequestMapping(value = "/m/sup/phoneInfo.m")
    public String phoneInfo(HttpServletRequest request, ModelMap model) throws Exception {

		return "mobile/sup/m_phoneInfo";
    }
	
	//찾아오시는길
	@RequestMapping(value = "/m/sup/visitMap.m")
    public String visitMap(HttpServletRequest request, ModelMap model) throws Exception {

		return "mobile/sup/m_visitMap";
    }
    
	
}
