package com.seek.mapper;

import java.util.List;

import com.seek.domain.RboardAttachVO;

public interface RboardAttachMapper {
	
	public void insert(RboardAttachVO vo);
	
	public void delete(String uuid);
	
	public List<RboardAttachVO> findByBno(Long rbno);
	
	public void deleteAll(Long rbno);
}
