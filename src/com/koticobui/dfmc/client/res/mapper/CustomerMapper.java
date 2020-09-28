package com.koticobui.dfmc.client.res.mapper;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

import java.util.Map;



/**
 * Created by aircha on 2016. 6. 3..
 */
@Mapper
public interface CustomerMapper {
    Map selectCustomerInfo(String mberId);
    int insertSession(String session);
    int updateSession(String session);
    Map selectSession(String session);
}
