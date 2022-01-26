package com.seek.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.seek.domain.Criteria;
import com.seek.domain.MemberVO;
import com.seek.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberMapper memberMapper;
	private PasswordEncoder pwEncoder;

	@Override
	public MemberVO read(MemberVO vo) {
		return memberMapper.read(vo) ;
	}

	@Override
	public MemberVO read(String m_id) {
		return memberMapper.read(m_id);
	}

	@Override
	public MemberVO selectOneMember(String m_id) {
		return memberMapper.selectOneMember(m_id);
	}

	@Override
	@Transactional
	public void register(MemberVO vo) {
		
		String protectedPw = pwEncoder.encode(vo.getM_pw());
		
		vo.setM_pw(protectedPw);
		log.info("비밀번호 암호화 : " + vo.getM_pw());
		memberMapper.register(vo);
		memberMapper.registerAuth(vo);
	}

	@Override
	public void memberUpdate(MemberVO vo) {
		
		String protectedPw = pwEncoder.encode(vo.getM_pw());
		vo.setM_pw(protectedPw);
		
		memberMapper.memberUpdate(vo);		
	}

	@Override
	@Transactional
	public void memberDelete(MemberVO vo) {
		
		memberMapper.memberDeleteAuth(vo);
		memberMapper.memberDelete(vo);
	}

	@Override
	public int idCheck(String m_id) {
		int result = memberMapper.idCheck(m_id);
		return result;
	}

	@Override
	public int emailCheck(String m_email) {
		int result = memberMapper.emailCheck(m_email);
		return result;
	}

	@Override
	public int pwCheck(String m_id, String m_pw) {
		int result = memberMapper.pwCheck(m_id, m_pw);
		return result;
	}

	@Override
	public String findID(String m_email) {
		
		return memberMapper.findID(m_email);
		
	}

	@Override
	public int findPW(@Param("m_id")String m_id, @Param("m_email")String m_email) {
		
		return memberMapper.findPW(m_id, m_email);
	}

	@Override
	public void pwUpdate(MemberVO vo) {
		memberMapper.pwUpdate(vo);
	}

	@Override
	public String setPassword(int length) {
		int index = 0; 
		char[] charArr = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
						              'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 
						              'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y',
						              'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 
						              'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 
						              'w', 'x', 'y', 'z', '!', '@', '#', '$', '%', '^', '&', '*' }; 

		StringBuffer sb = new StringBuffer(); 

		for (int i = 0; i < length; i++) { 
			index = (int) (charArr.length * Math.random()); 
			sb.append(charArr[index]); 
		} 

		return sb.toString(); 
	}

	//관리자페이지
	@Override
	public List<MemberVO> readList(Criteria cri) {
		
		return memberMapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		
		return memberMapper.getTotalCount(cri);
	}



}
