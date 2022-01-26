package com.seek.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.seek.domain.Criteria;
import com.seek.domain.RBoardVO;

public interface RBoardMapper {

	//@Select("select * from r_board where rbno > 0")
	//글목록
	public List<RBoardVO> getList();
	//페이징처리된 글목록
	public List<RBoardVO> getListWithPaging(Criteria cri);
	//글추가
	public void insert(RBoardVO rboard);
	public void insertSelectKey(RBoardVO rboard);
	//글읽기
	public RBoardVO read(Long rbno);
	//글삭제
	public int delete(Long rbno);
	//글수정
	public int update(RBoardVO RBoard);
	//글개수
	public int getTotalCount(Criteria cri);
	
	public int getTotalCountMine(@Param("m_id")String m_id, @Param("cri")Criteria cri);
	
	public List<RBoardVO> myPageRList(@Param("m_id")String m_id, @Param("cri")Criteria cri);
}
