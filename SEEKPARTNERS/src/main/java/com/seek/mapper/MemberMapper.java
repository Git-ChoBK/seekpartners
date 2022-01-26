package com.seek.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.seek.domain.Criteria;
import com.seek.domain.MemberVO;

public interface MemberMapper {
	public MemberVO read(String m_id);
	public MemberVO read(MemberVO vo);
	
	public MemberVO selectOneMember(String m_id);

	//회원가입
	public void register(MemberVO vo);
	public void registerAuth(MemberVO vo);
	
	//로그인
//	public MemberVO memberLogin(MemberVO vo);
	
	//회원정보수정
	public void memberUpdate(MemberVO vo);
	
	//회원 탈퇴
	public void memberDelete(MemberVO vo);
	public void memberDeleteAuth(MemberVO vo);
	
	//아이디 중복확인
	public int idCheck(String m_id);
	
	//이메일 중복확인
	public int emailCheck(String m_email);
	
	//아이디&비밀번호확인
	public int pwCheck(String m_id, String m_pw);
	
	//이메일로 아이디 찾기
	public String findID(String m_email);
	
	//아이디와 이메일로 비밀번호 찾기
	public int findPW(@Param("m_id")String m_id, @Param("m_email")String m_email);
	
	//비밀번호 업데이트
	public void pwUpdate(MemberVO vo);
	
	//관리자 회원 리스트
	public List<MemberVO> readList(Criteria cri);
	public List<MemberVO> getListWithPaging(Criteria cri);
	public int getTotalCount(Criteria cri);
}
