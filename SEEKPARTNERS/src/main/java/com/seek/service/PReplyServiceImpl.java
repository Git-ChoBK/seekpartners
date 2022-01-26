package com.seek.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seek.domain.Criteria;
import com.seek.domain.PReplyPageDTO;
import com.seek.domain.PReplyVO;
import com.seek.mapper.PReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class PReplyServiceImpl implements PReplyService{

	@Setter(onMethod_ = @Autowired)
	private PReplyMapper mapper;
	
	@Override
	public int register(PReplyVO vo) {
		// TODO Auto-generated method stub
		log.info("register......"+vo);
		
		return mapper.insert(vo);
	}

	@Override
	public PReplyVO get(Long prno) {
		// TODO Auto-generated method stub
		log.info("get......"+prno);
		
		return mapper.read(prno);
	}

	@Override
	public int modify(PReplyVO vo) {
		// TODO Auto-generated method stub
		log.info("modify......"+vo);
		
		return mapper.update(vo);
	}

	@Override
	public int remove(Long prno) {
		// TODO Auto-generated method stub
		log.info("remove......"+prno);
		
		return mapper.delete(prno);
	}

	@Override
	public List<PReplyVO> getList(Criteria cri, Long pbno) {
		// TODO Auto-generated method stub
		log.info("get Reply List of a Board"+pbno);
		
		return mapper.getListWithPaging(cri, pbno);
	}

	@Override
	public PReplyPageDTO getListPage(Criteria cri, Long pbno) {
		// TODO Auto-generated method stub
		return new PReplyPageDTO(
				mapper.getCountByPbno(pbno),
				mapper.getListWithPaging(cri, pbno));
	}	
}
