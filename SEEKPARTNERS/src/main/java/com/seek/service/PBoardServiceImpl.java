package com.seek.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seek.domain.Criteria;
import com.seek.domain.PBoardVO;
import com.seek.mapper.PBoardMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class PBoardServiceImpl implements PBoardService{

	@Autowired
	private PBoardMapper mapper;
	
	@Override
	public List<PBoardVO> getList() {

		return mapper.getList();
	}

	@Override
	public void register(PBoardVO board) {

		mapper.registerSelectKey(board);
	}

	@Override
	public PBoardVO get(Long pbno) {
		// TODO Auto-generated method stub
		return mapper.get(pbno);
	}

	@Override
	public boolean modify(PBoardVO board) {
		// TODO Auto-generated method stub
		return mapper.modify(board) == 1;
	}

	@Override
	public boolean remove(Long pbno) {
		// TODO Auto-generated method stub
		return mapper.remove(pbno) == 1;
	}

	@Override
	public List<PBoardVO> getList(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<PBoardVO> findMyPartner(String m_id) {
		return mapper.findMyPartner(m_id);
	}

	@Override
	public boolean updateStatus(PBoardVO board) {
		return mapper.updateStatus(board) == 1;
	}

	@Override
	public List<PBoardVO> myPagePList(@Param("m_id")String m_id, @Param("cri")Criteria cri) {
		return mapper.myPagePList(m_id, cri);
	}
	
   @Override
   public List<Long> getAverage(String m_id) {
      // TODO Auto-generated method stub
      return mapper.getAverage(m_id);
      }

@Override
public int getTotalCountMine(String m_id, @Param("cri")Criteria cri) {
	// TODO Auto-generated method stub
	return mapper.getTotalCountMine(m_id, cri);
}

}
