package com.seek.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seek.domain.Criteria;
import com.seek.domain.PReportVO;
import com.seek.mapper.PReportMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class PReportServiceImpl implements PReportService {
	
	// 자동주입
	@Setter(onMethod_ = @Autowired)
	private PReportMapper mapper;
	
	// 회원 신고게시판 글목록(페이징)
	@Override
	public List<PReportVO> getList(Criteria cri) {

		log.info("Criteria를 포함한 회원 신고게시판 글목록: " + cri);
		
		return mapper.getListWithPaging(cri);
	}

	// 회원 신고게시판 글등록
	@Override
	public void register(PReportVO preport) {
		
		log.info("회원 신고게시판 글등록: " + preport);
		
		mapper.registerSelectKey(preport);
	}

	// 회원 신고게시판 글조회
	@Override
	public PReportVO read(Long prebno) {
		
		log.info("회원 신고게시판 글조회: " + prebno);
		
		return mapper.read(prebno);
	}

	// 회원 신고게시판 글수정
	@Override
	public boolean modify(PReportVO preport) {
		
		log.info("회원 신고게시판 글수정: " + preport);
		
		return mapper.modify(preport) == 1;
	}

	// 회원 신고게시판 글삭제
	@Override
	public void remove(Long prebno) {

		log.info("회원 신고게시판 글삭제: " + prebno);
		
		mapper.remove(prebno);		
	}

	// 회원 신고게시판 데이터 개수
	@Override
	public int getTotalCount(Criteria cri) {
		
		log.info("회원 신고게시판 전체 데이터 개수 처리: "+ cri);
		
		return mapper.getTotalCount(cri);
	}

	@Override
	public int getTotalCount(String m_id) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(m_id);
	}

	@Override
	public List<PReportVO> getListWithPagingMine(@Param("m_id")String m_id, @Param("cri")Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getListWithPagingMine(m_id, cri);
	}

	@Override
	public int getTotalCountMine(@Param("m_id")String m_id) {
		// TODO Auto-generated method stub
		return mapper.getTotalCountMine(m_id);
	}
	
//	@Override
//	public int getTotalCountMine(String m_id) {
//		// TODO Auto-generated method stub
//		return mapper.getTotalCount(m_id);
//	}

	//관리자페이지 신고확인
//	@Override
//	public List<PReportVO> preList(Criteria cri) {
//		// TODO Auto-generated method stub
//		return mapper.getListWithPaging(cri);
//	}
	

}
