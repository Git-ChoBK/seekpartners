package com.seek.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seek.domain.Criteria;
import com.seek.domain.PageDTO;
import com.seek.domain.RPBoardVO;
import com.seek.mapper.RPBoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class RPBoardServiceImpl implements RPBoardService {
	
	// 자동주입
	@Setter(onMethod_ = @Autowired)
	private RPBoardMapper mapper;
	
	// 문의게시판 글목록(페이징)
	@Override
	public List<RPBoardVO> getList(Criteria cri) {
		
		log.info("Criteria를 포함한 문의게시판 글목록: " + cri);
		
		return mapper.getListWithPaging(cri);
	}
	
	// 문의게시판 글등록
	@Override
	public void register(RPBoardVO rpboard) {
		
		log.info("문의게시판 글등록: " + rpboard);
		
		mapper.registerSelectKey(rpboard);
	}
	
	// 문의게시판 글조회
	@Override
	public RPBoardVO get(Long rpbno) {
		
		log.info("문의게시판 글조회: " + rpbno);
		
		return mapper.get(rpbno);
	}
	
	// 문의게시판 글수정
	@Override
	public boolean modify(RPBoardVO rpboard) {
		
		log.info("문의게시판 글수정: " + rpboard);
		
		return mapper.modify(rpboard) == 1;
	}
	
	// 문의게시판 글삭제
	@Override
	public void remove(Long rpbno) {

		log.info("문의게시판 글삭제: " + rpbno);
		
		mapper.remove(rpbno);
	}

	// 문의게시판 데이터 개수
	@Override
	public int getTotal(Criteria cri) {
		
		log.info("문의게시판 전체 데이터 개수 처리: "+ cri);
		
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<RPBoardVO> getList(String m_id) {
		
		return mapper.getList(m_id);
	}

	@Override
	public List<RPBoardVO> getList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<RPBoardVO> getListWithPagingMine(@Param("m_id")String m_id, @Param("cri")Criteria cri) {
		
		return mapper.getListWithPagingMine(m_id, cri);
	}

	@Override
	public int getTotalCountMine(@Param("m_id")String m_id, @Param("cri")Criteria cri) {
		
		return mapper.getTotalCountMine(m_id, cri);
	}

	//관리자페이지 문의확인
	@Override
	public List<RPBoardVO> arlist(Criteria cri) {
		
		return mapper.getListWithPaging(cri);
	}


}
