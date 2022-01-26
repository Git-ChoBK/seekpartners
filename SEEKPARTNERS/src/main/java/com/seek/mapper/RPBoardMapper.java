package com.seek.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.seek.domain.Criteria;
import com.seek.domain.RPBoardVO;

public interface RPBoardMapper {

	// 신고게시판 글목록
	//@Select("select * from rp_board where rpbno > 0")
	public List<RPBoardVO> getList(String m_id);
	// 신고게시판 글목록(Criteria)
	public List<RPBoardVO> getListWithPaging(Criteria cri);
	// 신고게시판 글등록
	public void register(RPBoardVO rpboard);
	public void registerSelectKey(RPBoardVO rpboard);
	// 신고게시판 글조회
	public RPBoardVO get(Long rpbno);
	// 신고게시판 글삭제
	public void remove(Long rpbno);
	// 신고게시판 글수정
	public int modify(RPBoardVO rpboard);
	// 신고게시판 전체 데이터 개수 처리(Criteria)
	public int getTotalCount(Criteria cri);
	
	public List<RPBoardVO> getListWithPagingMine(@Param("m_id")String m_id, @Param("cri")Criteria cri);
	
	public int getTotalCountMine(@Param("m_id")String m_id, @Param("cri")Criteria cri);
	
	//관리자페이지 문의확인
	public List<RPBoardVO> arlist(Criteria cri);
	
}
