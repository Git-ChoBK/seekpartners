package com.seek.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seek.domain.Criteria;
import com.seek.domain.ScorePageDTO;
import com.seek.domain.ScoreVO;
import com.seek.mapper.ScoreMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ScoreServiceImpl implements ScoreService {

	@Setter(onMethod_ = @Autowired)
	private ScoreMapper mapper;
	
	@Override
	public int register(ScoreVO vo) {
		log.info("평점 등록됨");
		
		return mapper.insert(vo);
	}

	@Override
	public ScoreVO read(String s_id, String m_id) {
		log.info("평점 정보 불러옴");
		
		return mapper.read(s_id, m_id);
	}

	@Override
	public int remove(Long sbno) {
		log.info("평점 항목 삭제됨");
		
		return mapper.delete(sbno);
	}

	@Override
	public int modify(ScoreVO vo) {
		log.info("평점 수정됨");
		
		return mapper.update(vo);
	}

	@Override
	public List<ScoreVO> getList(String clicked_id) {
		log.info("평점 리스트 불러옴");//(클릭한 id의) 평점 리스트를 불러옴[실행]
		
		return mapper.getList(clicked_id);
	}

	@Override
	public List<ScoreVO> getList_m(String clicked_id) {
		log.info("평점 리스트 불러옴[m_id 기준]");
		return mapper.getList_m(clicked_id);
	}//추가함

	@Override
	public ScorePageDTO getListPage_s(Criteria cri, String s_id) {
		log.info("페이지 리스트 불러옴");
		return new ScorePageDTO(mapper.getCountBySid(s_id),
				mapper.getListWithPaging_s(cri, s_id));
	}//추가함

	@Override
	public ScorePageDTO getListPage_m(Criteria cri, String m_id) {
		log.info("페이지 리스트 불러옴(내가 평가한 기록)");
		return new ScorePageDTO(mapper.getCountByMid(m_id),
				mapper.getListWithPaging_m(cri, m_id));
	}//추가함
}
