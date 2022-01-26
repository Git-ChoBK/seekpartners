package com.seek.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.seek.domain.Criteria;
import com.seek.domain.PageDTO;
import com.seek.domain.RPBoardVO;
import com.seek.service.RPBoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/rpBoard/*")
@AllArgsConstructor
public class RPBoardController {

	private RPBoardService rpService;
	
	// 문의게시판 글목록(== list)
	@GetMapping("/rpList")
	public void list(@Param("cri")Criteria cri, Model model, Principal prin) {
		
		log.info("========== 문의게시판 글목록 ==========");
		log.info("글목록: " + cri);
		String m_id = prin.getName();
		//rpService.getList(m_id);
		//int total = rpService.getTotal(cri);
		List<RPBoardVO> tempVO = rpService.getListWithPagingMine(m_id, cri);
		log.info("확인용");
		int total = rpService.getTotalCountMine(m_id, cri);
		
//		List<RPBoardVO> vo = rpService.getList(cri);
//		log.info(">>>>>>>>>>>>>>>>>>>>>>>>>" + vo);
//		List<RPBoardVO> tempVO = new ArrayList<>();
//		
//		for(int i=0;i<vo.size();i++) {
//			if(vo.get(i).getM_id().equals(m_id)) {
//				tempVO.add(vo.get(i));
//			}
//		}
		
		log.info("결과값 >>>>>>>>>>>>>>>>>>" + tempVO);

		
		model.addAttribute("list", tempVO);
//		model.addAttribute("list", rpService.getList(m_id));
		model.addAttribute("pageMaker", new PageDTO(cri, total));	// service.getTotal(cri)를 total 변수에 넣어서 전달
		
		log.info("total: " + total);
		
	}
	
	
//	public void list(@Param("cri")Criteria cri, Model model, Principal prin) {
//		String m_id = prin.getName();
//		int total = rpService.getTotalCountMine(m_id);
//		List<RPBoardVO> tempVO = rpService.getListWithPagingMine(cri, m_id);
//		
//		model.addAttribute("list", tempVO);
//		model.addAttribute("pageMaker", new PageDTO(cri, rpService.getTotalCountMine(m_id)));
//	}
	
	// 문의게시판 글등록(== register)
	@GetMapping("/rpRegister")
	public void register(String m_id, Principal prin, Model model) {
		
		log.info("========== 문의게시판 글등록 완료 ==========");
		
		m_id = prin.getName();
		
		log.info("문의게시판 이동 시 로그인 유저 아이디 : " + m_id);
		
		model.addAttribute("member", m_id);
		
	}
	
	@PostMapping("/rpRegister")
	public String register(RPBoardVO rpboard) {
		
		log.info(rpboard + " 글 등록");
		
		rpService.register(rpboard);
		
		return "redirect:/member/rpBoard/rpList";		// 등록후 다시 목록으로 이동
	}
	
	// 문의게시판 글조회(== get, modify)
	@GetMapping({"/rpDetails", "/rpModify"})
	@PreAuthorize("isAuthenticated()")
	public void get(@RequestParam("rpbno") Long rpbno, @ModelAttribute("cri") Criteria cri, Model model) {
		
		log.info("rpDetails와 rpModify를 조회 ... rpbno: " + rpbno);
		
		model.addAttribute("pageMaker", new PageDTO(cri, rpService.getTotal(cri)));
		model.addAttribute("rpboard", rpService.get(rpbno));
	}
	
	// 문의게시판 글수정 후 이동
	@PostMapping("/rpModify")
	public String modify(RPBoardVO rpboard, Criteria cri, RedirectAttributes rttr, Model model) {
		
		log.info(rpboard + " 수정");
		
		if(rpService.modify(rpboard)) {
			rttr.addFlashAttribute("result", rpboard.getRpbno());			
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		model.addAttribute("pageMaker", new PageDTO(cri, rpService.getTotal(cri)));
		
		return "redirect:/member/rpBoard/rpList";
	}
	
	// 문의게시판 글삭제 후 이동
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/rpRemove")
	public String remove(Long rpbno) {
		
		log.info(rpbno + " 삭제");

		rpService.remove(rpbno);

		return "redirect:/member/rpBoard/rpList";
	}
}
