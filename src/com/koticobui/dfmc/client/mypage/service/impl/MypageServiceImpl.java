/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */
package com.koticobui.dfmc.client.mypage.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.koticobui.dfmc.client.com.util.GenerationKey;
import com.koticobui.dfmc.client.com.util.GeoCodingComponent;
import com.koticobui.dfmc.client.mypage.mapper.MypageMapper;
import com.koticobui.dfmc.client.mypage.model.DiscountItemVO;
import com.koticobui.dfmc.client.mypage.service.MypageService;


/**
 * The type Customer manage service.
 */
@Service("mypageService")
public class MypageServiceImpl implements MypageService {

    private static final Logger LOGGER = LoggerFactory.getLogger(MypageServiceImpl.class);

    @Resource(name = "mypageMapper")
    private MypageMapper mypageMapper;
    
	@Resource(name = "generationKey")
    private GenerationKey generationKey;
	
	@Resource(name = "geoCodingComponent")
    private GeoCodingComponent geoCodingComponent;
	
	
	@Override
	public Map<String, Object> selectContractList(Map requestMap) {
	     
	    Map result = new HashMap<String, Object>();
	    
	    String mobileYn = (String) requestMap.get("mobileYn");
	    
	    if(!"Y".equals(mobileYn)){
	    	
	    	Integer listCount = mypageMapper.selectContractListTot(requestMap) ;
		    int pageSize = requestMap.get("pageSize") == null ? 10 : requestMap.get("pageSize").equals("") ? 10 : Integer.parseInt((String)requestMap.get("pageSize"));
		    int pageCount = listCount % pageSize > 0 ? listCount/pageSize+1:listCount/pageSize;
		 
		    requestMap.put("listCount", listCount ); 
		    requestMap.put("pageCount", pageCount ); 
		    requestMap.put("pageSize",  pageSize ); 
		    result.put("page", requestMap); 
	    }
	    
	    result.put("list", mypageMapper.selectContractList(requestMap));

	    return result;
	}
	
	@Override
	public Map<String, Object> selectPaymentList(Map requestMap) {
	     
	    Map result = new HashMap<String, Object>();
	    
	    Integer listCount = mypageMapper.selectPaymentListTot(requestMap) ;
	    int pageSize = requestMap.get("pageSize") == null ? 10 : requestMap.get("pageSize").equals("") ? 10 : Integer.parseInt((String)requestMap.get("pageSize"));
	    int pageCount = listCount % pageSize > 0 ? listCount/pageSize+1:listCount/pageSize;
	 
	    requestMap.put("listCount", listCount ); 
	    requestMap.put("pageCount", pageCount ); 
	    requestMap.put("pageSize",  pageSize ); 
	    result.put("page", requestMap); 
	     
	    result.put("list", mypageMapper.selectPaymentList(requestMap));

	    return result;
	}
	
	@Override
	public Map<String, Object> selectRegulatePaymentList(Map requestMap) {
	     
	    Map result = new HashMap<String, Object>();
	    
	    Integer listCount = mypageMapper.selectRegulatePaymentListTot(requestMap) ;
	    int pageSize = requestMap.get("pageSize") == null ? 10 : requestMap.get("pageSize").equals("") ? 10 : Integer.parseInt((String)requestMap.get("pageSize"));
	    int pageCount = listCount % pageSize > 0 ? listCount/pageSize+1:listCount/pageSize;
	 
	    requestMap.put("listCount", listCount ); 
	    requestMap.put("pageCount", pageCount ); 
	    requestMap.put("pageSize",  pageSize ); 
	    result.put("page", requestMap); 
	     
	    result.put("list", mypageMapper.selectRegulatePaymentList(requestMap));

	    return result;
	}
	
	@Override
	public Map<String, Object> selectRequestRefund(Map requestMap) {
	     
	    Map result = new HashMap<String, Object>();
	    
	    Integer listCount = mypageMapper.selectRequestRefundTot(requestMap) ;
	    int pageSize = requestMap.get("pageSize") == null ? 10 : requestMap.get("pageSize").equals("") ? 10 : Integer.parseInt((String)requestMap.get("pageSize"));
	    int pageCount = listCount % pageSize > 0 ? listCount/pageSize+1:listCount/pageSize;
	 
	    requestMap.put("listCount", listCount ); 
	    requestMap.put("pageCount", pageCount ); 
	    requestMap.put("pageSize",  pageSize ); 
	    result.put("page", requestMap); 
	     
	    result.put("list", mypageMapper.selectRequestRefund(requestMap));

	    return result;
	}

	@Override
    public int confirmPassword(Map requestMap) {

        return mypageMapper.confirmPassword(requestMap);
    }
	
	@Override
    public int refundRequest(Map requestMap) {

        return mypageMapper.refundRequest(requestMap);
    }

	@Override
	public Map<String, Object> searchMemberInfo(Map requestMap) {
		
		return mypageMapper.searchMemberInfo(requestMap);
	}
	
	@Override
    @Transactional
    public void updateMember(Map requestMap, DiscountItemVO discountItemVO) throws Exception {

        // 주소정보를 받아 위치정보를 얻어온다
        getLocation(requestMap);

        // 고객정보 update
        requestMap.put("mberSttus", "P");
        requestMap.put("groupId", "GROUP_00000000000000");
        requestMap.put("joinCode", "01");
        mypageMapper.updateMember(requestMap);
        
        // 차량정보 update
        mypageMapper.updateCar(requestMap);
        
        // 할인항목 delete
        mypageMapper.deleteDiscountDetail(requestMap);
        
        // 할인항목 insert
  		if(discountItemVO.getArrDiscountItemKey() != null){
  			
  			for (int i = 0; i < discountItemVO.getArrDiscountItemKey().length; i++) {
  				
  				requestMap.put("discountItemKey", discountItemVO.getArrDiscountItemKey()[i]);
  				
  				String discountDetailKey = "";
  				try {
  					discountDetailKey = generationKey.genTableKey("TB_DISCOUNT_DETAIL", "DISCOUNT_DETAIL_KEY");
  				} catch (Exception e) {
  					e.printStackTrace();
  				}
  				requestMap.put("discountDetailKey", discountDetailKey);
  				
  				//할인내역 저장
  				//int discountDetailResult = publicAssignManageMapper.saveDiscountDetail(requestMap);
  				mypageMapper.insertDiscountDetail(requestMap);
  			}
  		}
    }
	
	private void getLocation(Map requestMap) throws Exception {
        Map geoCodingMap = geoCodingComponent.getLocationByAddress(requestMap.get("adres") + " " + requestMap.get("detailAdres"));
        requestMap.put("memberLon", geoCodingMap.get("memberLon").toString());
        requestMap.put("memberLat", geoCodingMap.get("memberLat").toString());
    }
	
	@Override
	@Transactional
    public void memberOut(Map requestMap) throws Exception {

		//2018-02-01 배정정보 없는 고객은 삭제한다.
		//mypageMapper.deleteTagCustomer(requestMap);
		
		//기존코드 리마크 2017-11-29
        // 메모삭제
        mypageMapper.deleteMemo(requestMap);

        // 할인내역삭제
        mypageMapper.outDeleteDiscountDetail(requestMap);

        // 희망신청구역삭제
        mypageMapper.deleteHopeRequestSection(requestMap);

        // 배점삭제
        mypageMapper.deleteAssignScoreDetail(requestMap);

        // 수납관리삭제
        mypageMapper.deleteQuarterPayment(requestMap);

        // 상품계약이력삭제
        mypageMapper.deleteContractHistory(requestMap);

        // 상품계약삭제
        mypageMapper.deleteContractInfo(requestMap);

        // 차량정보삭제
        mypageMapper.deleteCar(requestMap);

        // 고객정보삭제
        mypageMapper.deleteCustomer(requestMap);
    }
	
	@Override
	public Map<String, Object> selectMemberStatus(Map requestMap) {
	     
	    Map result = new HashMap<String, Object>();
	    result.put("list", mypageMapper.selectMemberStatus(requestMap));

	    return result;
	}
	
	
	@Override
	public Map<String, Object> selectStandbyStatusList(Map requestMap) {
	     
	    Map result = new HashMap<String, Object>();
	    
	    String mobileYn = (String) requestMap.get("mobileYn");
	    
	    if(!"Y".equals(mobileYn)){
	    	Integer listCount = mypageMapper.selectStandbyStatusListTot(requestMap) ;
		    int pageSize = requestMap.get("pageSize") == null ? 10 : requestMap.get("pageSize").equals("") ? 10 : Integer.parseInt((String)requestMap.get("pageSize"));
		    int pageCount = listCount % pageSize > 0 ? listCount/pageSize+1:listCount/pageSize;
		 
		    requestMap.put("listCount", listCount ); 
		    requestMap.put("pageCount", pageCount ); 
		    requestMap.put("pageSize",  pageSize ); 
		    result.put("page", requestMap); 
	    }
	    
	    result.put("list", mypageMapper.selectStandbyStatusList(requestMap));

	    return result;
	}
	
	@Override
	public Map<String, Object> selectPPStandbyList(Map requestMap) {
	     
	    Map result = new HashMap<String, Object>();
	    
	    String mobileYn = (String) requestMap.get("mobileYn");
	    
	    if(!"Y".equals(mobileYn)){
	    	Integer listCount = mypageMapper.selectPPStandbyListTot(requestMap) ;
		    int pageSize = requestMap.get("pageSize") == null ? 10 : requestMap.get("pageSize").equals("") ? 10 : Integer.parseInt((String)requestMap.get("pageSize"));
		    int pageCount = listCount % pageSize > 0 ? listCount/pageSize+1:listCount/pageSize;
		 
		    requestMap.put("listCount", listCount ); 
		    requestMap.put("pageCount", pageCount ); 
		    requestMap.put("pageSize",  pageSize ); 
		    result.put("page", requestMap); 
	    }
	    
	    result.put("list", mypageMapper.selectPPStandbyList(requestMap));

	    return result;
	}

	@Override
	@Transactional
    public void cancelRequest(Map requestMap) throws Exception {
		
        // 할인내역삭제
        mypageMapper.requestDeleteDiscountDetail(requestMap);

        // 희망신청구역삭제
        mypageMapper.requestDeleteHopeRequestSection(requestMap);

        // 수납관리삭제
        mypageMapper.requestDeleteQuarterPayment(requestMap);

        // 상품계약이력삭제
        mypageMapper.requestDeleteContractHistory(requestMap);

        // 상품계약삭제
        mypageMapper.requestDeleteContractInfo(requestMap);
        
    }
	
	
	
	
	
	
	
	
	
	
	
    @Override
    @Transactional
    public int savePay(Map requestMap) throws Exception {
    	//OCR번호(고객조회번호) 조회
    	//수납키로 OCR번호 조회
    	String ocrNo = mypageMapper.selectOcrNo(requestMap);
    	requestMap.put("custInquiryNo",ocrNo);
    	LOGGER.debug("ocrNo:"+ocrNo);
    	
    	//결제 데이타 저장
    	String payKey = generationKey.genTableKey("TB_PAY", "PAYMENT_KEY");
		requestMap.put("saveNextPayKey", payKey);
		LOGGER.debug("payKey:"+payKey);
		
		return mypageMapper.insertPay(requestMap);
    }
}
