package com.seek.security;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.seek.domain.CustomUser;
import com.seek.domain.MemberVO;
import com.seek.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class CustomUserDetailsService implements UserDetailsService {

	@Setter(onMethod_ = { @Autowired })
	private MemberMapper memberMapper;

	@Override
	public UserDetails loadUserByUsername(String m_id) throws UsernameNotFoundException {

		log.warn("로그인 아이디 : " + m_id);

		// userName means userid
		MemberVO vo = memberMapper.read(m_id);

		log.warn("로그인한 유저 vo 정보 : " + vo);
		
		log.warn("로그인한 유저 비밀번호 : " + vo.getM_pw());

		return vo == null ? null : new CustomUser(vo);
	} 
	
}
