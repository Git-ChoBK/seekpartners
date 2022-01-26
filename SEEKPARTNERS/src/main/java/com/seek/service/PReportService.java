package com.seek.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.seek.domain.Criteria;
import com.seek.domain.PReportVO;

public interface PReportService {

	// 회원 신고게시판 글목록(페이징)
	public List<PReportVO> getList(Criteria cri);
	// 회원 신고게시판 글등록
	public void register(PReportVO preport);
	// 회원 신고게시판 글조회
	public PReportVO read(Long prebno);
	// 회원 신고게시판 글수정
	public boolean modify(PReportVO preport);
	// 회원 신고게시판 글삭제
	public void remove(Long prebno);
	// 전체 데이터 개수 처리(Criteria)
//	public int getTotal(Criteria cri);
	public int getTotalCount(Criteria cri);
	public int getTotalCount(String m_id);
//	public int getTotalCountMine(@Param("m_id")String m_id);
	
	// 관리자 페이지 신고 확인
//	public List<PReportVO> preList(Criteria cri);
	
	public List<PReportVO> getListWithPagingMine(@Param("m_id")String m_id, @Param("cri")Criteria cri);
	public int getTotalCountMine(@Param("m_id")String m_id);
}
