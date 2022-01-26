package com.seek.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.seek.domain.Criteria;
import com.seek.domain.PBoardVO;

public interface PBoardService {
	
	public List<PBoardVO> getList();

	public List<PBoardVO> getList(Criteria cri);
	
	public void register(PBoardVO board);
	
	public PBoardVO get(Long pbno);
	
	public boolean modify(PBoardVO board);
	
	public boolean remove(Long pbno);

	public int getTotal(Criteria cri);
	
	public List<PBoardVO> findMyPartner(String m_id);
	
	public boolean updateStatus(PBoardVO board);
	
	public List<PBoardVO> myPagePList(@Param("m_id")String m_id, @Param("cri")Criteria cri);
	
	public List<Long> getAverage(String m_id);
	
	public int getTotalCountMine(@Param("m_id")String m_id, @Param("cri")Criteria cri);
	
}
