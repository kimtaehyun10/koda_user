/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */

package com.koticobui.dfmc.client.security.model;

import org.springframework.security.core.CredentialsContainer;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.util.Assert;

import java.io.Serializable;
import java.util.*;

/**
 * Created by aircha on 2016. 5. 25..
 */
public class Customer implements UserDetails, CredentialsContainer, Serializable {
    private static final long serialVersionUID = -7985608417598961034L;

    private String password;
    private final String username;
    private final Set<GrantedAuthority> authorities;
    private final boolean accountNonExpired;
    private final boolean accountNonLocked;
    private final boolean credentialsNonExpired;
    private final boolean enabled;
    private final String accessToken;

    private final String mberNm;
    private final String mberPhone;
    private final String mberEmailAdres;
    private final String mberBirth;
    
    private final String esntlId;
    
    private final Date passwordDt;
    private final Date failDt;
    private final long failCount;
    private final Date currentDt;

    public Customer(String username, String password, String accessToken, Collection<? extends GrantedAuthority> authorities,
                    String mberNm, String mberPhone, String mberEmailAdres, String mberBirth, String esntlId, Date passwordDt, Date failDt, long failCount, Date currentDt) {
        this(username, password, accessToken, true, true, true, true, authorities, mberNm, mberPhone, mberEmailAdres, mberBirth, esntlId, passwordDt, failDt, failCount, currentDt);
    }

    public Customer(String username, String password, String accessToken, boolean enabled,
                    boolean accountNonExpired, boolean credentialsNonExpired,
                    boolean accountNonLocked, Collection<? extends GrantedAuthority> authorities,
                    String mberNm, String mberPhone, String mberEmailAdres, String mberBirth, String esntlId, Date passwordDt, Date failDt, long failCount, Date currentDt) {
        this.mberNm = mberNm;
        this.mberPhone = mberPhone;
        this.mberEmailAdres = mberEmailAdres;
        this.mberBirth = mberBirth;
        this.esntlId = esntlId;

        if (((username == null) || "".equals(username)) || (password == null)) {
            throw new IllegalArgumentException("Cannot pass null or empty values to constructor");
        }

        this.username = username;
        this.password = password;
        this.accessToken = accessToken;
        this.enabled = enabled;
        this.accountNonExpired = accountNonExpired;
        this.credentialsNonExpired = credentialsNonExpired;
        this.accountNonLocked = accountNonLocked;
        this.authorities = Collections.unmodifiableSet(sortAuthorities(authorities));
        this.passwordDt = passwordDt;
        this.failDt = failDt;
        this.failCount = failCount;
        this.currentDt = currentDt;
    }

    public void eraseCredentials() {
        password = null;
    }

    private static SortedSet<GrantedAuthority> sortAuthorities(Collection<? extends GrantedAuthority> authorities) {
        Assert.notNull(authorities, "Cannot pass a null GrantedAuthority collection");

        SortedSet<GrantedAuthority> sortedAuthorities = new TreeSet<GrantedAuthority>(new AuthorityComparator());

        for (GrantedAuthority grantedAuthority : authorities) {
            Assert.notNull(grantedAuthority, "GrantedAuthority list cannot contain any null elements");
            sortedAuthorities.add(grantedAuthority);
        }

        return sortedAuthorities;
    }

    public String getMberNm() {
        return mberNm;
    }

    public String getMberPhone() {
        return mberPhone;
    }

    public String getMberEmailAdres() {
        return mberEmailAdres;
    }

    public String getMberBirth() {
        return mberBirth;
    }

    public String getEsntlId() {
        return esntlId;
    }

    private static class AuthorityComparator implements Comparator<GrantedAuthority>, Serializable {
        private static final long serialVersionUID = 986859161260017153L;

        public int compare(GrantedAuthority g1, GrantedAuthority g2) {

            if (g2.getAuthority() == null) {
                return -1;
            }

            if (g1.getAuthority() == null) {
                return 1;
            }

            return g1.getAuthority().compareTo(g2.getAuthority());
        }
    }

    @Override
    public boolean equals(Object rhs) {
        if (rhs instanceof Customer) {
            return username.equals(((Customer) rhs).username);
        }
        return false;
    }

    @Override
    public int hashCode() {
        return username.hashCode();
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(super.toString()).append(": ");
        sb.append("Username: ").append(this.username).append("; ");
        sb.append("Password: [PROTECTED]; ");
        sb.append("Enabled: ").append(this.enabled).append("; ");
        sb.append("AccountNonExpired: ").append(this.accountNonExpired).append("; ");
        sb.append("credentialsNonExpired: ").append(this.credentialsNonExpired)
                .append("; ");
        sb.append("AccountNonLocked: ").append(this.accountNonLocked).append("; ");

        if (!authorities.isEmpty()) {
            sb.append("Granted Authorities: ");

            boolean first = true;
            for (GrantedAuthority auth : authorities) {
                if (!first) {
                    sb.append(",");
                }
                first = false;

                sb.append(auth);
            }
        } else {
            sb.append("Not granted any authorities");
        }

        return sb.toString();
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return username;
    }

    @Override
    public boolean isAccountNonExpired() {
        return accountNonExpired;
    }

    @Override
    public boolean isAccountNonLocked() {
        return accountNonLocked;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return credentialsNonExpired;
    }

    @Override
    public boolean isEnabled() {
        return enabled;
    }

    public String getAccessToken() {
        return accessToken;
    }

	public Date getPasswordDt() {
		return passwordDt;
	}

	public Date getFailDt() {
		return failDt;
	}

	public long getFailCount() {
		return failCount;
	}

	public Date getCurrentDt() {
		return currentDt;
	}
}
