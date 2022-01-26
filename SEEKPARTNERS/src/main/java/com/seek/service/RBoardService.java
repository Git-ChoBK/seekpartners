package com.seek.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.seek.domain.Criteria;
import com.seek.domain.RBoardVO;
import com.seek.domain.RboardAttachVO;

public interface RBoardService {
	
	public List<RBoardVO> getList();

//	public List<RBoardVO> getList(Criteria cri);
	
	public List<RBoardVO> getListWithPaging(Criteria cri);
	 
	public void register(RBoardVO rboard);
	
	public RBoardVO get(Long rbno);
	
	public boolean r_modify(RBoardVO rboard);
	
	public boolean remove(Long rbno);
	
	public void r_details(RBoardVO rboard);

	int getTotal(Criteria cri);
	
	public List<RboardAttachVO> getAttachList(Long rbno);
	
	public int getTotalCountMine(@Param("m_id")String m_id, @Param("cri")Criteria cri);
	
	public List<RBoardVO> myPageRList(@Param("m_id")String m_id, @Param("cri")Criteria cri);
}
