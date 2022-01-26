package com.seek.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.seek.domain.Criteria;
import com.seek.domain.MemberVO;

public interface MemberService {
	
	public MemberVO read(MemberVO vo);
	
	public MemberVO read(String m_id);
	
	public MemberVO selectOneMember(String m_id);

	public void register(MemberVO vo);
	
//	public MemberVO memberLogin(MemberVO vo);
	
	public void memberUpdate(MemberVO vo);
	
	public void memberDelete(MemberVO vo);
	
	public int idCheck(String m_id);
	
	public int emailCheck(String m_email);
	
	public int pwCheck(String m_id, String m_pw);
	
	public String findID(String m_email);
	
	public int findPW(@Param("m_id")String m_id, @Param("m_email")String m_email);
	
	public void pwUpdate(MemberVO vo);
	
	public String setPassword(int length);
	
	//관리자페이지
	public List<MemberVO> readList(Criteria cri);
	public int getTotal(Criteria cri);

}
