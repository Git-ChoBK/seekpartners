package com.seek.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.seek.domain.Criteria;
import com.seek.domain.ScoreVO;

public interface ScoreMapper {

	public int insert(ScoreVO vo);
	public ScoreVO read(@Param("s_id") String s_id, @Param("m_id") String m_id);
	public int delete (Long sbno);
	public int update(ScoreVO vo);
	public List<ScoreVO> getList(@Param("s_id") String s_id);
	
	public List<ScoreVO> getList_m(@Param("m_id") String m_id);//추가함
	public List<ScoreVO> getListWithPaging_s(
			@Param("cri") Criteria cri,
			@Param("s_id") String s_id);//추가함
	public int getCountBySid(String s_id);//추가함
	
	public List<ScoreVO> getListWithPaging_m(
			@Param("cri") Criteria cri,
			@Param("m_id") String m_id);//추가함
	public int getCountByMid(String m_id);//추가함
}
