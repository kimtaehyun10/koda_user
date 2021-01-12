/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */

package com.koticobui.dfmc.client.security.service;

import com.koticobui.dfmc.client.security.model.Customer;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;


/**
 * Created by aircha on 2016. 5. 25..
 */
public class AuthenticationService {
    public Customer getCustomer() {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if ( !(authentication instanceof AnonymousAuthenticationToken) ) {
                return (Customer) authentication.getPrincipal();
            }
        } catch (AuthenticationException e) {
            e.printStackTrace();
        }

        return null;
    }

    public Customer getCustomer(Authentication authentication) {

        if ( !(authentication instanceof AnonymousAuthenticationToken) ) {
            return (Customer) authentication.getPrincipal();
        }

        return null;
    }

}
