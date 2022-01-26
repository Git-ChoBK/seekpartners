package com.seek.controller;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.seek.domain.AlarmVO;
import com.seek.domain.Criteria;
import com.seek.domain.PBoardVO;
import com.seek.domain.PageDTO;
import com.seek.service.AlarmService;
import com.seek.service.PBoardService;
import com.seek.service.ScoreService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
@RequestMapping("/pBoard/*")
public class PBoardController {

	private PBoardService service;
	private AlarmService alarmService;
	private ScoreService service_S;
	//평점 리스트 불러옴 /assess/{pDetail.jsp에서 클릭한 유저 id}/{로그인한 유저 id}
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/assess/{clicked_id}/{logined_id}", method = RequestMethod.GET
			//, produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE}
	)
	
	public String scoreList(
			Model model, @PathVariable("clicked_id") String clicked_id,  @PathVariable("logined_id") String logined_id) {
		log.info("m_id, s_id, 평점 리스트 불러옴");
		model.addAttribute("sList", service_S.getList(clicked_id)).addAttribute("target_id", clicked_id);
		
		return "/score/assess";
		//return new ResponseEntity<>(service_S.getList(m_id), HttpStatus.OK);
	}///////////////////////////////////////////////////////////////////////////////////////////////////추가함
	
	
	@GetMapping("/pList")
	public void pListGET(Criteria cri, Model model) {
		
		// 페이징 처리 추가
		log.info("========== 페이징 처리된 파티 게시판을 불러옵니다. ==========");
		log.info("list: " + cri);
		
		model.addAttribute("pList", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, service.getTotal(cri)));
		log.info("getTotal 값 : " + service.getTotal(cri));
		
		log.info("PageDTO로 받은 값: " + new PageDTO(cri, service.getTotal(cri)));
		
	}
	
	@GetMapping("/pRegister")
	@PreAuthorize("isAuthenticated()")
	public void register() {
		log.info("================ 파티 게시판으로 이동 ================");
	}
	
	@PostMapping("/pRegister")
	@PreAuthorize("isAuthenticated()")
	public String register(PBoardVO board, RedirectAttributes rttr) throws ParseException {
		String[] areasplit = board.getP_area().split(" ");
		board.setP_areasplit(areasplit[0]+" "+areasplit[1]);
		log.info(areasplit[0]+" "+areasplit[1]);
//		board.setP_time(board.transtime(board.getP_time()));
//		log.info("1 : "+board.getP_time());
//		log.info("2 : "+board.transtime(board.getP_time()));
		log.info(board);
		service.register(board);
		rttr.addFlashAttribute("result",board.getPbno());
		return "redirect:/pBoard/pList";
	}
	
	// 수정/삭제 - @ModedlAttribute("cri") Criteria cri - if(service.modify(board)) {rttr} rttr~
	@PostMapping("/pModify")
	@PreAuthorize("principal.username == #board.m_id")
	public String modify(PBoardVO board, Criteria cri, RedirectAttributes rttr) {
		String[] areasplit = board.getP_area().split(" ");
		board.setP_areasplit(areasplit[0]+" "+areasplit[1]);
		log.info("업데이트문--------------"+service.modify(board));
		log.info(board);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result",board.getPbno());			
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/pBoard/pDetails?pbno="+board.getPbno();
	}//pDetails?"+board.getPbno()
	
	
	@GetMapping({"/pDetails", "/pModify"})
	@PreAuthorize("isAuthenticated()")
	public void get(Long pbno, Model model, @ModelAttribute("cri") Criteria cri) {
	
		log.info("글수정이동 시 게시글번호 : " + pbno);
		PBoardVO board = service.get(pbno);
		log.info("/pDetails or pModify");
		log.info("vo 확인 : " + board);
		
		double temp = 0;
		List<Long> scores = service.getAverage(board.getM_id());
		for(int i=0;i<scores.size();i++) {
			temp += (double)scores.get(i);
		} 
		temp = temp/scores.size();
		model.addAttribute("getscore", temp);
		
		model.addAttribute("p_board", service.get(pbno));
		
	}
	
	@PostMapping("/pDetails")
	@PreAuthorize("isAuthenticated()")
	public String pDetailPOST(Long pbno, PBoardVO board) {
		board = service.get(pbno);
		
		log.info("상세보기>>>>> " + board);
		log.info("모집상태>>>>> " + board.getStatus());
		
		if(board.getStatus().equals("W")) {
			log.info(board.getStatus());
			board.setStatus("C");
			service.updateStatus(board);
		} else {
			log.info(board.getStatus());
			board.setStatus("W");
			service.updateStatus(board);
		}
		
		return "redirect:/pBoard/pDetails?pbno="+board.getPbno();
	}
	
	
	// 글삭제후 페이지번호 유지
//	@PreAuthorize("principal.username == #m_id")
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/pRemove")
	public String remove(Long pbno, Criteria cri, RedirectAttributes rttr, PBoardVO board, String m_id) {
	
		log.info("remove..." + pbno);
		log.info("글 삭제시 vo 확인 "+board);		
		board = service.get(pbno);
		log.info("글 삭제시 아이디 확인 "+board);
		m_id = board.getM_id();
		log.info(m_id);

		if (service.remove(pbno)) {
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		return "redirect:/pBoard/pList";
	}
	
	@ResponseBody
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/seekFamily")
	public Map<String, Object> seekFamilyPOST(@RequestBody Map<String, Object> apply) {
		
		log.info("apply값 확인>>>>>>>>>> " + apply);
		log.info("apply값 확인>>>>>>>>>> " + apply.get("m_id"));
		log.info("apply값 확인>>>>>>>>>> " + apply.get("pbno"));
		log.info("apply값 확인>>>>>>>>>> " + apply.get("gboardwriter"));
				
		AlarmVO alarmVO = new AlarmVO();
		
		int temp = Integer.parseInt(apply.get("pbno").toString());
		long pbno = Long.valueOf(temp);
		log.info(pbno);
		
		String m_id = apply.get("m_id").toString();
		String gboardwriter = apply.get("gboardwriter").toString();
		String cmd = apply.get("cmd").toString();
		
		
		alarmVO.setCmd(cmd); 
		alarmVO.setPbno(pbno);
		alarmVO.setM_id(m_id);
		alarmVO.setGboardwriter(gboardwriter);
		 
		alarmService.saveAlarm(alarmVO); log.info("알람VO 확인 : " + alarmVO);
		 
		
		return apply;
	}
	
	@GetMapping("/areapRegister")
	@PreAuthorize("isAuthenticated()")
	public void arearegister(String area,Model model) {
		log.info("================ 리뷰->식구찾기 글쓰기 ================");
		model.addAttribute("get_area", area);
	}
	
		

}
