package com.seek.controller;

import java.security.Principal;
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
import com.seek.domain.PBoardVO;
import com.seek.domain.PReportVO;
import com.seek.domain.PageDTO;
import com.seek.domain.RPBoardVO;
import com.seek.service.PBoardService;
import com.seek.service.PReportService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/pReport/*")
@AllArgsConstructor
public class PReportController {
	
	private PReportService prService;
	private PBoardService pService;

	/* 회원 신고게시판 글목록 */
	@GetMapping("/pRList")
	public void list(@Param("cri")Criteria cri, Model model, Principal prin) {
		
		log.info("========== 회원 신고게시판 목록 ==========");
		String m_id = prin.getName();
		List<PReportVO> tempVO = prService.getListWithPagingMine(m_id, cri);
		int total = prService.getTotalCountMine(m_id);
		
		log.info("결과값 >>>>>>>>>>>>>>>>>>" + tempVO);

		
		model.addAttribute("list", tempVO);
		model.addAttribute("pageMaker", new PageDTO(cri, total));	// service.getTotal(cri)를 total 변수에 넣어서 전달
		
		log.info("total: " + total);
		
	}
	
	// 회원 신고게시판 글등록
	@GetMapping("/pReportRegister")
	public void register(Principal prin, Model model, Criteria cri, Long pbno) {
		String m_id;
		m_id = prin.getName();
		PBoardVO vo = pService.get(pbno);
		
		log.info("신고글 작성 시 넘기는 값 >>>>> " + vo);
		
		log.info("회원 신고게시판 이동 시 로그인 유저 아이디 : " + m_id);
		
		model.addAttribute("member", m_id);
		model.addAttribute("list", vo);

		//return "redirect:/member/pReport/pReportList?pbno="+ preport.getPbno();		// 등록후 다시 목록으로 이동
	}
	
	@PostMapping("/pReportRegister")
	public String register(PReportVO vo,Principal prin, RedirectAttributes rttr) {
		String m_id;
		m_id = prin.getName();
		log.info("========== 회원 신고게시판 글등록 =========="+vo);
//		vo.setPre_title("테스트입니다");
//		vo.setM_id(m_id);
//		prService.register(vo);
		rttr.addFlashAttribute("result", vo.getPbno());
		log.info("PReportVO: " + vo);
		
		prService.register(vo);
		
		return "redirect:/member/pReport/pRList";
	}

	// 문의게시판 글조회(== get, modify)
	@GetMapping({"/pRDetails", "/pRModify"})
	@PreAuthorize("isAuthenticated()")
	public void get(@RequestParam("prebno") Long prebno, @Param("cri") Criteria cri, Model model) {
		
		log.info("rpDetails와 rpModify를 조회 ... rpbno: " + prebno);
		
		model.addAttribute("preport", prService.read(prebno));
		model.addAttribute("pageMaker", new PageDTO(cri, prService.getTotalCount(cri)));
		
	}
	
	// 문의게시판 글수정 후 이동
	@PostMapping("/pRModify")
	public String modify(PReportVO preport, Criteria cri, RedirectAttributes rttr, Model model) {
		
		log.info(preport + " 수정");
		
		if (prService.modify(preport)) {
			rttr.addFlashAttribute("result", preport.getPrebno());			
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		model.addAttribute("pageMaker", new PageDTO(cri, prService.getTotalCount(cri)));
		
		return "redirect:/member/pReport/pRList";
	}
	
	// 문의게시판 글삭제 후 이동
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/pRRemove")
	public String remove(Long prebno) {
		
		log.info(prebno + " 삭제");

		prService.remove(prebno);

		return "redirect:/member/pReport/pRList";
	}
	
}
