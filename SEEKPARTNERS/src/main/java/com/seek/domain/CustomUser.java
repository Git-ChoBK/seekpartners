package com.seek.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;

@Getter
public class CustomUser extends User {
	
	private static final long serialVersionUID = 1l;

	private MemberVO member;
	
	public CustomUser(String m_id, String m_pw, Collection<? extends GrantedAuthority> authorities) {
		super(m_id, m_pw, authorities);
		
		
	}
	
	//생성자 오버로딩
	public CustomUser(MemberVO vo) {
		super(vo.getM_id(), vo.getM_pw(), vo.getAuthList().stream().map(auth-> new SimpleGrantedAuthority(auth.getM_auth())).collect(Collectors.toList()));
		
		this.member = vo;
	}

}

