package com.seek.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.seek.domain.Criteria;
import com.seek.domain.PReplyPageDTO;
import com.seek.domain.PReplyVO;
import com.seek.service.PReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/*")
@RestController
@Log4j
@AllArgsConstructor
public class PReplyController {
	
	private PReplyService service;
	
	//댓글 등록
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new",
			consumes="application/json",
			produces= {MediaType.TEXT_PLAIN_VALUE})	
	public ResponseEntity<String> create(@RequestBody PReplyVO vo){
		log.info("PReplyVO: "+vo);
		
		int insertCount = service.register(vo);
		
		log.info("Reply INSERT COUNT: "+insertCount);
		
		return insertCount == 1
				? new ResponseEntity<>("Success", HttpStatus.OK) 
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
					
	}
	
	//댓글 페이지 단위로 불러오기
	/*
	 * @GetMapping(value = "pages/{pbno}/{page}",
	 * produces={MediaType.APPLICATION_XML_VALUE,
	 * MediaType.APPLICATION_JSON_UTF8_VALUE}) public ResponseEntity<List<PReplyVO>>
	 * getList(
	 * 
	 * @PathVariable("page") int page,
	 * 
	 * @PathVariable("pbno") Long pbno){
	 * 
	 * log.info("getList......"); Criteria cri = new Criteria(page,10);
	 * log.info(cri);
	 * 
	 * return new ResponseEntity<>(service.getList(cri,pbno), HttpStatus.OK); }
	 */

	@GetMapping(value = "pages/{pbno}/{page}",
			produces={MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<PReplyPageDTO> getList(
			@PathVariable("page") int page,
			@PathVariable("pbno") Long pbno){
	
		
		Criteria cri = new Criteria(page,10);
		
		log.info("get Reply List pbno: "+pbno);
		log.info("cri:"+cri);
		
		return new ResponseEntity<>(service.getListPage(cri, pbno), HttpStatus.OK);
	}

	//댓글 조회
	@GetMapping(value = "/{prno}",
			produces={MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<PReplyVO> get(@PathVariable("prno") Long prno){
		
		log.info("get" + prno);
		
		return new ResponseEntity<>(service.get(prno), HttpStatus.OK);
	}
	
	//댓글 삭제
	@PreAuthorize("principal.username == #vo.m_id")
	@DeleteMapping(value= "/{prno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@RequestBody PReplyVO vo, @PathVariable("prno") Long prno){
		
		log.info("삭제할 댓글 번호: "+prno);
		log.info("댓글 작성자  : " + vo.getM_id());
		
		return service.remove(prno) ==1
				? new ResponseEntity<>("Success", HttpStatus.OK) 
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글 수정
	@PreAuthorize("principal.username == #vo.m_id")
	@RequestMapping(method = { RequestMethod.PUT, RequestMethod.PATCH},
			value="/{prno}", 
			consumes="application/json", 
			produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(
			@RequestBody PReplyVO vo,
			@PathVariable("prno") Long prno){
		
		vo.setPrno(prno);
		
		log.info("prno: " + prno);
		log.info("modify: " + vo);
		
		return service.modify(vo) == 1
				? new ResponseEntity<>("Success", HttpStatus.OK) 
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
