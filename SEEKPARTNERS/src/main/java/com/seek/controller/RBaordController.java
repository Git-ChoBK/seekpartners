package com.seek.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.seek.domain.Criteria;
import com.seek.domain.PageDTO;
import com.seek.domain.RBoardVO;
import com.seek.domain.RboardAttachVO;
import com.seek.service.RBoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/rBoard/*")
@Log4j
@AllArgsConstructor
public class RBaordController {
	
	private RBoardService service;
	
	@GetMapping("/rList")
	public void r_list(Criteria cri, Model model, Long rbno) {
		// 페이징 처리 추가
		log.info("========== 페이징 처리 ==========");
		model.addAttribute("rList", service.getListWithPaging(cri));
		log.info("rList Model " + model);
		model.addAttribute("pageMaker", new PageDTO(cri, service.getTotal(cri)));
		log.info("PageDTO로 받은 값: " + new PageDTO(cri, service.getTotal(cri)));
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/rRegister")
	public void register() {
		log.info("================ 맛집 게시판으로 이동 ================");
	}
	
	
	@PostMapping("/rRegister")
	@PreAuthorize("isAuthenticated()")
	public String register(RBoardVO rboard, RedirectAttributes rttr) {
		String[] areasplit = rboard.getR_area().split(" ");
		rboard.setR_areasplit(areasplit[0]+" "+areasplit[1]);
		log.info(areasplit[0]+" "+areasplit[1]);
		log.info(rboard);
		service.register(rboard);
		rttr.addFlashAttribute("result",rboard.getRbno());
		return "redirect:/rBoard/rList";
	}
	
	
	@GetMapping({"/rModify", "/rDetails"})
	@PreAuthorize("isAuthenticated()")
	public void get(Long rbno, Model model, @ModelAttribute("cri") Criteria cri) {
		model.addAttribute("rInfo", service.get(rbno));
		log.info("수정삭제 모달 확인"+model);
	}
	
	@PostMapping("/rModify")
	@PreAuthorize("principal.username == #rboard.m_id")
	public String r_modify(RBoardVO rboard, Criteria cri, RedirectAttributes rttr) {
		String[] areasplit = rboard.getR_area().split(" ");
		rboard.setR_areasplit(areasplit[0]+" "+areasplit[1]);
		log.info("업데이트문--------------"+service.r_modify(rboard));
		log.info(rboard);
		
		if(service.r_modify(rboard)) {
			rttr.addFlashAttribute("result",rboard.getRbno());			
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/rBoard/rDetails?rbno="+rboard.getRbno();
	}
	//글삭제 후 페이지번호 유지
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/rRemove")
	public String remove(Long rbno, Criteria cri, RedirectAttributes rttr, RBoardVO rboard, String m_id) {
		List<RboardAttachVO> attactList = service.getAttachList(rbno);
		if(service.remove(rbno)) {
			deleteFiles(attactList);
			rttr.addFlashAttribute("result", "success");
			log.info("삭제"+rbno);
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/rBoard/rList" + cri.getListLink();
	}
	
	private void deleteFiles(List<RboardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			attachList.forEach(attach->{
				try {
					Path file = Paths.get("c:\\upload\\"+attach.getUploadpath()+"\\"+attach.getUuid()+"_"+attach.getFilename());
					
					Files.deleteIfExists(file);
					
					if(Files.probeContentType(file).startsWith("image")) {
						
						Path tumbNail = Paths.get("c:\\upload\\"+attach.getUploadpath()+"\\s_"+attach.getUuid()+"_"+attach.getFilename());
						
						Files.delete(tumbNail);
					}
				}catch(Exception e) {
					log.error(e.getMessage());
				}
			});
		}
	}
	
	@GetMapping(value= "/getAttachList", produces= MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<RboardAttachVO>> getAttachList(Long rbno){
		return new ResponseEntity<>(service.getAttachList(rbno), HttpStatus.OK);
	}	
}
