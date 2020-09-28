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
package com.koticobui.dfmc.client.com.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import com.koticobui.dfmc.client.com.service.CommonService;

/**
 * The type Generation key.
 */
@Component
public class GenerationKey {
	
	private static final Logger LOGGER = Logger.getLogger(GenerationKey.class);

	@Resource(name = "commonService")
	private CommonService commonService;

	/**
	 * Gen table key string.
	 *
	 * @param tableName  the table name
	 * @param columnName the column name
	 * @return the string
	 * @throws Exception the exception
	 */
	public String genTableKey(String tableName, String columnName) throws Exception {
		
		String result = "";

		try {
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
			Date currentTime = new Date();
			String today = simpleDateFormat.format(currentTime);
			
			Map requestMap = new HashMap();
			requestMap.put("today", today);
			requestMap.put("tableName", tableName);
			requestMap.put("columnName", columnName);

			String nextKeyNumber = commonService.genTableKey(requestMap);
			
			result = today + "_" + nextKeyNumber;
		}
		catch(Exception e) {
			LOGGER.error(e.getMessage());
		}

		return result;
	}

}
