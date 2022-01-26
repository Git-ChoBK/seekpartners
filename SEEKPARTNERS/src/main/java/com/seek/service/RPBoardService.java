package com.seek.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.seek.domain.Criteria;
import com.seek.domain.RPBoardVO;

public interface RPBoardService {

	// 문의게시판 글목록(페이징)
	public List<RPBoardVO> getList();
	public List<RPBoardVO> getList(String m_id);
	public List<RPBoardVO> getList(Criteria cri);
	// 문의게시판 글등록
	public void register(RPBoardVO rpboard);
	// 문의게시판 글조회
	public RPBoardVO get(Long rpbno);
	// 문의게시판 글수정
	public boolean modify(RPBoardVO rpboard);
	// 문의게시판 글삭제
	public void remove(Long rpbno);
	// 전체 데이터 개수 처리(Criteria)
	public int getTotal(Criteria cri);
	
	public List<RPBoardVO> getListWithPagingMine(@Param("m_id")String m_id, @Param("cri")Criteria cri);
	
	public int getTotalCountMine(@Param("m_id")String m_id, @Param("cri")Criteria cri);
	
	//관리자 페이지 신고확인
	public List<RPBoardVO> arlist(Criteria cri);
	
}
