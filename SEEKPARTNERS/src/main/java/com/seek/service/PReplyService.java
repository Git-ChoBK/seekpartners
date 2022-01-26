package com.seek.service;

import java.util.List;

import com.seek.domain.Criteria;
import com.seek.domain.PReplyPageDTO;
import com.seek.domain.PReplyVO;

public interface PReplyService {

	public int register(PReplyVO vo);
	
	public PReplyVO get(Long prno);
	
	public int modify(PReplyVO vo);
	
	public int remove(Long prno);
	
	public List<PReplyVO> getList(Criteria cri, Long pbno);
	
	public PReplyPageDTO getListPage(Criteria cri, Long pbno);
}
