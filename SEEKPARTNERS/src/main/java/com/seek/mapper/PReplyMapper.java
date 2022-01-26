package com.seek.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.seek.domain.Criteria;
import com.seek.domain.PReplyVO;

public interface PReplyMapper {

	public int insert(PReplyVO vo);
	
	public PReplyVO read(Long prno);
	
	public int delete (Long prno);
	
	public int update (PReplyVO reply);
	
	public List<PReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("pbno") Long pbno);
	
	public int getCountByPbno(Long pbno);
	
}
