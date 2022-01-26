package com.seek.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.seek.domain.Criteria;
import com.seek.domain.PReportVO;

public interface PReportMapper {

	// 신고게시판 글목록
	//@Select("select * from p_report where prebno > 0")
	public List<PReportVO> getList();
	// 페이징처리된 글목록(Criteria)
	public List<PReportVO> getListWithPaging(Criteria cri);
	// 신고게시판 글등록
	//public void register(PReportVO preport);
	public void registerSelectKey(PReportVO preport);
	// 신고게시판 글상세보기
	public PReportVO read(Long prebno);
	//글삭제
	public int remove(Long prebno);
	//글수정
	public int modify(PReportVO preport);
	//글개수
	public int getTotalCount(Criteria cri);
	public int getTotalCount(String m_id);
//	public int getTotalCountMine(@Param("m_id") String m_id);
	
	//관리자페이지 신고확인
//	public List<PReportVO> preList(Criteria cri);
	
	public List<PReportVO> getListWithPagingMine(@Param("m_id")String m_id, @Param("cri")Criteria cri);
	public int getTotalCountMine(@Param("m_id")String m_id);
	
}
