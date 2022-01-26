package com.seek.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.seek.domain.Criteria;
import com.seek.domain.ScorePageDTO;
import com.seek.domain.ScoreVO;
import com.seek.service.ScoreService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
//@RestController
@Log4j
@AllArgsConstructor
@RequestMapping("/score/*")

public class ScoreController {

private ScoreService service;
//페이징 처리 + 리스트 불러옴
@GetMapping(value = "/pages/myEval/{m_id}/{page}", produces= {
		MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
public ResponseEntity<ScorePageDTO> getList_m(@PathVariable("page") int page, @PathVariable("m_id") String m_id){

	Criteria cri = new Criteria(page, 5);
	
	log.info("get score list m_id : "+m_id);
	log.info("cri : "+cri);
	
	return new ResponseEntity<>(service.getListPage_m(cri, m_id), HttpStatus.OK);
}//추가함

//페이징 처리 + 리스트 불러옴
@GetMapping(value = "/pages/{s_id}/{page}", produces= {
		MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
public ResponseEntity<ScorePageDTO> getList(@PathVariable("page") int page, @PathVariable("s_id") String s_id){

	Criteria cri = new Criteria(page, 5);
	
	log.info("get score list s_id : "+s_id);
	log.info("cri : "+cri);
	
	return new ResponseEntity<>(service.getListPage_s(cri, s_id), HttpStatus.OK);
}//추가함

//평점 리스트 불러옴 /score/{seekMyPage.jsp에서 클릭한 유저 id}
@RequestMapping(value = "/my/{login_id}", method = RequestMethod.GET)
public String scoreList(
		Model model, @PathVariable("login_id") String login_id) {

	log.info("m_id, s_id, 내가 받은 평점 리스트 불러옴");
	model.addAttribute("myList", service.getList(login_id)).addAttribute("target_id", login_id);
	model.addAttribute("mList", service.getList_m(login_id)).addAttribute("target_id", login_id);
	return "/member/myScore";
	//return new ResponseEntity<>(service_S.getList(m_id), HttpStatus.OK);
}//추가함

@PreAuthorize("isAuthenticated()")
@ResponseBody
@PostMapping(value = "/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE}) 
public ResponseEntity<ScoreVO> create(@RequestBody ScoreVO vo){

	log.info("ScoreVO: " + vo);

	int insertCount = service.register(vo);

	log.info("Score INSERT COUNT: " + insertCount);

	return insertCount == 1 ? new ResponseEntity<>(HttpStatus.OK) :
		new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); }

@PreAuthorize("isAuthenticated()")
@ResponseBody
@GetMapping(value = "/{s_id}/{m_id}",//s_id, m_id 두개를 변수로 내보내야함 produces = {
	produces={MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ScoreVO> get(@PathVariable("s_id") String s_id, @PathVariable("m_id") String m_id){

	log.info("ScoreVO: s_id = " + s_id + " m_id = "+m_id);

	return new ResponseEntity<>(service.read(s_id, m_id), HttpStatus.OK); }

@PreAuthorize("isAuthenticated()")
@ResponseBody
@DeleteMapping(value = "/{sbno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("sbno") Long sbno){

	log.info("remove: " + sbno);

	return service.remove(sbno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) 
									: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); }

@PreAuthorize("isAuthenticated()")
@ResponseBody
@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, value ="/{sbno}", consumes = "application/json", 
produces = {MediaType.TEXT_PLAIN_VALUE}) public ResponseEntity<String> modify(@RequestBody ScoreVO vo, @PathVariable("sbno") Long sbno){
	vo.setSbno(sbno);

	log.info("sbno: "+sbno); log.info("modify: "+vo);

	return service.modify(vo) ==1 ? new ResponseEntity<>("success", HttpStatus.OK) 
								: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); }
 
 }

