package com.koticobui.dfmc.client.security.mapper;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

import java.util.Map;



/**
 * Created by aircha on 2016. 6. 3..
 */
@Mapper
public interface CustomerMapper {
    Map selectCustomerInfo(String userId);
    String encodingPw(String user_Pw);
    int checkApprFlag(String session);
    int insertSession(String session);
    int updateSession(String session);
    Map selectSession(String session);
}
