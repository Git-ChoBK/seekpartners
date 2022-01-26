package com.seek.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.seek.domain.Criteria;
import com.seek.domain.RBoardVO;
import com.seek.domain.RboardAttachVO;
import com.seek.mapper.RBoardMapper;
import com.seek.mapper.RboardAttachMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
@Component
@Repository
public class RBoardServiceImpl implements RBoardService{
	
	@Setter(onMethod_ = @Autowired)
	private RBoardMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private RboardAttachMapper attachMapper;

	@Override
	public List<RBoardVO> getList() {
		// TODO Auto-generated method stub
		return mapper.getList();
	}
	
	//등록
	@Transactional
	@Override
	public void register(RBoardVO rboard) {
		
		mapper.insertSelectKey(rboard);
		if(rboard.getAttachList() == null || rboard.getAttachList().size() <= 0) {
			return;
		}
		rboard.getAttachList().forEach(attach ->{
			attach.setRbno(rboard.getRbno());
			attachMapper.insert(attach);
		});
	}
	
	//조회
	@Override
	public RBoardVO get(Long rbno) {
		log.info("서비스임플: " + rbno);
		return mapper.read(rbno);
	}
	
	//수정
	@Transactional
	@Override
	public boolean r_modify(RBoardVO rboard) {
		attachMapper.deleteAll(rboard.getRbno());
		boolean modifyResult = mapper.update(rboard) == 1;
		if(modifyResult && rboard.getAttachList() != null && rboard.getAttachList().size() >0 ) {
			rboard.getAttachList().forEach(attach -> {
				attach.setRbno(rboard.getRbno());
				attachMapper.insert(attach);
			});
		}
		return modifyResult;
	}
	
	//삭제
	@Transactional
	@Override
	public boolean remove(Long rbno) {
		
		attachMapper.deleteAll(rbno);
		return mapper.delete(rbno) == 1;
	}
	
	//맛집 상세보기
	@Override
	public void r_details(RBoardVO rboard) {
		
		mapper.insertSelectKey(rboard);
	}

	//목록
	@Override
	public List<RBoardVO> getListWithPaging(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(cri);
	}
	
	@Transactional
	@Override
	public List<RboardAttachVO> getAttachList(Long rbno) {
		return attachMapper.findByBno(rbno);
	}

	@Override
	public int getTotalCountMine(@Param("m_id")String m_id, @Param("cri")Criteria cri) {
		
		return mapper.getTotalCountMine(m_id, cri);
	}

	@Override
	public List<RBoardVO> myPageRList(@Param("m_id")String m_id, @Param("cri")Criteria cri) {
		
		return mapper.myPageRList(m_id, cri);
	}

}
