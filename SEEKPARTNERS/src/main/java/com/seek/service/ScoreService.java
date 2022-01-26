package com.seek.service;

import java.util.List;

import com.seek.domain.Criteria;
import com.seek.domain.ScorePageDTO;
import com.seek.domain.ScoreVO;

public interface ScoreService {
	public int register(ScoreVO vo);
	public ScoreVO read(String s_id, String m_id);
	public int remove (Long sbno);
	public int modify(ScoreVO vo);
	public List<ScoreVO> getList(String clicked_id);
	
	public List<ScoreVO> getList_m(String clicked_id);//추가함
	public ScorePageDTO getListPage_s(Criteria cri, String s_id);//추가함
	public ScorePageDTO getListPage_m(Criteria cri, String m_id);//추가함
}
