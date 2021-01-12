/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */

package com.koticobui.dfmc.client.com.util;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * The type Geo coding component.
 */
@Component
public class GeoCodingComponent {

	private static final Logger logger = LogManager.getLogger();

	@Value("#{appConfig['daum.api.key']}")
	private String apiKey;
	@Value("#{appConfig['daum.base.url']}")
	private String baseUrl;
	@Value("#{appConfig['daum.api.url.addr2coord']}")
	private String addr2coord;

	@Autowired
	private RestTemplate restTemplate;

	/**
	 * Gets location by address.
	 *
	 * @param address the address
	 * @return the location by address
	 * @throws Exception the exception
	 */
	public Map getLocationByAddress(String address) throws Exception {
		final HttpHeaders header = new HttpHeaders();
		header.add("Authorization", "KakaoAK " + apiKey);

		final Map<String, Object> param = new HashMap<>();
		param.put("address", address);
		final ResponseEntity<String> response = restTemplate.exchange(locationByAddressBuildUrl(param), HttpMethod.GET, new HttpEntity(header), String.class);
		logger.debug("response: {}",response);

		return getLocationMap(response.getBody());
	}

	private URI locationByAddressBuildUrl(Map param) {
		final UriComponentsBuilder urlBuilder = UriComponentsBuilder.fromUriString(baseUrl)
				.path(addr2coord)
				.queryParam("query", param.get("address"))
				.queryParam("output", "json");

		final URI uri = urlBuilder.build().encode().toUri();
		logger.debug("URI : {}", uri);
		return uri;
	}

	private Map getLocationMap(String responseJson) throws Exception {
		final Map map = new HashMap();
		JsonNode jsonNode = null;
		final ObjectMapper mapper = new ObjectMapper();
		jsonNode = mapper.readTree(responseJson);
		final JsonNode channelNode = jsonNode.path("documents");

		if (channelNode.isMissingNode()) {
			logger.error("Missing channel Node");
			return null;
		} else {

			final JsonNode xNode = channelNode.findValue("x");

			if (xNode.isMissingNode() == false) {
				map.put("memberLon", xNode.textValue());	
			} else {
				map.put("memberLon", "0");
			}

			final JsonNode yNode = channelNode.findValue("y");
			if (yNode.isMissingNode() == false) {
				map.put("memberLat", yNode.textValue());	
			} else {
				map.put("memberLat", "0");
			}

			logger.debug("map: {}", map.toString());
		}
		return map;
	}
}
