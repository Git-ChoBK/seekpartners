package com.seek.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.seek.domain.Criteria;
import com.seek.domain.PBoardVO;
import com.seek.domain.PageDTO;
import com.seek.service.PBoardService;
import com.seek.service.RBoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
public class HomeController {
	
	private PBoardService pService;
	private RBoardService rService;
	

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "home";
	}
	
	@GetMapping("/main")
	public void mainGET(Model model, Criteria cri, Long rbno) {
		
		Criteria mainCri = new Criteria();
		mainCri.setAmount(15);
		mainCri.setPageNum(1);
		List<PBoardVO> mainVO = pService.getList(mainCri);
		
		// 메인페이지
		log.info("==========메인페이지 이동==========");
		model.addAttribute("pList", mainVO);
		model.addAttribute("rList", rService.getListWithPaging(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, pService.getTotal(cri)));	// pageDTO에 cri값을 저장해서 pageMake로 전달
		model.addAttribute("pageMaker", new PageDTO(cri, rService.getTotal(cri)));
		log.info(model);
	
		// 리뷰게시판 페이징
		log.info("========== 페이징 처리 ==========");
		/* model.addAttribute("rList", rService.getListWithPaging(cri)); */
		log.info("rList Model " + model);
		model.addAttribute("pageMaker", new PageDTO(cri, rService.getTotal(cri)));
		log.info("PageDTO로 받은 값: " + new PageDTO(cri, rService.getTotal(cri)));
		
	}
	
}
