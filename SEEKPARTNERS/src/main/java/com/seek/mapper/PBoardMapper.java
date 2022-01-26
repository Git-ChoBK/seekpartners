package com.seek.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.seek.domain.Criteria;
import com.seek.domain.PBoardVO;

public interface PBoardMapper {
	// 파티게시판 글목록
	public List<PBoardVO> getList();
	// 파티게시판 페이징 처리된 글목록
	public List<PBoardVO> getListWithPaging(Criteria cri);
	// 파티게시판 글등록
	public void register(PBoardVO board);
	public void registerSelectKey(PBoardVO board);
	// 
	public PBoardVO get(Long pbno);
	// 파티게시판 글삭제
	public int remove(Long bno);
	// 파티게시판 글수정
	public int modify(PBoardVO board);
	//파티게시판 글개수
	public int getTotalCount(Criteria cri);
	
	public List<PBoardVO> findMyPartner(String m_id);
	public List<PBoardVO> myPagePList(@Param("m_id")String m_id, @Param("cri")Criteria cri);
	
	
	public int getTotalCountMine(@Param("m_id")String m_id, @Param("cri")Criteria cri);
	
	public int updateStatus(PBoardVO board);
	
	public List<Long> getAverage(String m_id);

}
