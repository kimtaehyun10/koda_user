/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.koticobui.dfmc.client.res.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koticobui.dfmc.client.res.service.ResidentService;

/**
 * The type Resident controller.
 */
@Controller
public class ResidentController {

    private static final Logger logger = LogManager.getLogger();

    @Resource(name = "residentService")
    private ResidentService residentService;
    
    /**
	 * Select parking condition list map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @param model      the model
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/res/selectParkingConditionList.json")
	@ResponseBody
	public Map<String, Object> selectParkingConditionList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
	       
		Map<String, Object> list = residentService.selectParkingConditionList(requestMap);
		return list;
	}
    
    
    /**
	 * Select division list map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @param model      the model
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/res/selectDivisionList.json")
	@ResponseBody
	public Map<String, Object> selectDivisionList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
	       
		Map<String, Object> list = residentService.selectDivisionList(requestMap);
		return list;
	}
	
	/**
     * Save request map.
     *
     * @param requestMap the request map
     * @return the map
     */
	@RequestMapping(value = "/res/saveRequest.json")
	@ResponseBody
    public Map saveRequest(@RequestParam Map<String, Object> requestMap) {
		
        String contractCount = (String) requestMap.get("contractCount");
		
		Map result = new HashMap();
		
		if("0".equals(contractCount)){
		
	        
	        try {
	        	residentService.saveRequest(requestMap);
	            result.put("result", "OK");
	        } catch (Exception e) {
	            logger.error(e.getMessage());
	            result.put("result", "FAIL");
	        }
		}else{
			result.put("result", "FAIL");
		}
		
        return result;
    }
    
	@RequestMapping(value = "/res/updateRequest.json")
	@ResponseBody
    public Map updateRequest(@RequestParam Map<String, Object> requestMap) {
		
		Map result = new HashMap();
        try {
        	residentService.updateRequest(requestMap);
            result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        return result;
    }
	
	//IOT차량연동 조회
	@RequestMapping(value = "/dfmc/res/xmlChange.x")
    public String xmlChange( 
    		@RequestParam(value="ak", defaultValue="") String prm_ak,
    		@RequestParam(value="sitecode", defaultValue="") String prm_sitecode,
    		@RequestParam(value="format", defaultValue="") String prm_format,
    		@RequestParam(value="mode", defaultValue="") String prm_mode,
    		@RequestParam(value="unit", defaultValue="") String prm_unit,
    		@RequestParam(value="section", defaultValue="") String prm_section,
    		HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		
		
		Map<String, Object> data = new HashMap<String, Object>();

		String ak = prm_ak;//requestMap.get("ak").toString();
		String sitecode = prm_sitecode; //requestMap.get("sitecode").toString();
		String format = prm_format;//requestMap.get("format").toString();
		String mode = prm_mode;//requestMap.get("mode").toString();
		String unit = prm_unit;//requestMap.get("unit").toString();
		String section = prm_section;//requestMap.get("section").toString();
		String errMsg = "";
		
		
		//API KEY
		if(!"PARKINGFRIENDS".equals(ak)){
			errMsg = "API KEY ERROR";
		}
		
		//구 구분
		if(!"DJ".equals(sitecode)){
			errMsg += "구 구분 ERROR";
		}
		
		//데이터포맷
		if(!"XML".equals(format)){
			errMsg += "데이터포맷 ERROR";
		}
		
		//조회종류
		if ((!"zonelist".equals(mode)) && (!"zoneinfo".equals(mode))){
			errMsg += "조회종류 ERROR";
		}
		
		//구간/구획번호
		//mode= zoneinfo 일 때 필수
		//zonelist(전체 배정자 정보 조회),
		//zoneinfo(특정 구간구획 배정자 정보 조회)
		if ("zoneinfo".equals(mode)){
			//조회종류
			if (("".equals(unit)) || ("".equals(section))){
				errMsg += "구간, 구획 필수 ERROR";
			}
		}		

		
		//System.out.println("======================:" + errMsg);
		if (errMsg == ""){
			
			Map<String, Object> prm_map = new HashMap<String, Object>();
			prm_map.put("unit", unit);
			prm_map.put("section", section);
			
			List<Map<String, Object>> list = residentService.xmlChange(prm_map);
			data.put("total", list.size());
			data.put("list", list);
			model.addAttribute("data",data);
			return "res/xml/xmlList";
		} else{
			model.addAttribute("msg",errMsg);
			return "res/xml/xmlListError";
		}

	}
}
