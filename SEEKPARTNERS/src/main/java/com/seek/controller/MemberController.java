package com.seek.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.seek.domain.Criteria;
import com.seek.domain.MemberVO;
import com.seek.domain.PBoardVO;
import com.seek.domain.PageDTO;
import com.seek.domain.RBoardVO;
import com.seek.security.CustomUserDetailsService;
import com.seek.service.MemberService;
import com.seek.service.PBoardService;
import com.seek.service.PReportService;
import com.seek.service.RBoardService;
import com.seek.service.RPBoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
@RequestMapping("/member/*")
public class MemberController {

	@Autowired
	private PBoardService pboardService;
	private RBoardService rboardService;
	private MemberService memberService;
	private CustomUserDetailsService userService;
	private PasswordEncoder pwEncoder;
	private JavaMailSender mailSender;
	private RPBoardService rpboardService;
	private PReportService prService;

	//에러페이지
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("access denied : "+auth);
		model.addAttribute("msg", "Access Denied");
	}
	
	
	//로그인페이지	
	@GetMapping("/seekMemberLogin")
	public void loginGET() {
		log.info("==========로그인 페이지로 이동==========");
	}
	
	
	//로그아웃페이지
	@GetMapping("/seekMemberLogout")
	public void logoutGET() {
		log.info("==========로그아웃 됨. 세션 끊킴==========");
	}
	
	@PostMapping("/seekMemberLogout")
	public void logoutPost() {}
	
	
	//회원가입
	@GetMapping("/seekMemberSignup")
	public void registerGET(MemberVO vo) {
		log.info("==========회원가입 페이지로 이동==========");
		
	}
	
	
	
	//회원가입 - 아이디 중복 확인
	@ResponseBody
	@PostMapping("/idCheck")
	public int idCheckGET(String m_id) {
		
		int result = memberService.idCheck(m_id);
		log.info("입력된 아이디값(실시간) : " + m_id);
		log.info("중복된다면 1 // 아니라면 0을 리턴 : " + result);
		return result;
	}
	
	//회원가입 - 이메일 중복 확인
	@ResponseBody
	@PostMapping("/emailCheck")
	public int emailCheckPOST(String m_email) {
		int result = memberService.emailCheck(m_email);
		log.info("입력된 이메일값(실시간) : " + m_email);
		log.info("중복된다면 1 // 아니라면 0을 리턴 : " + result);
		return result;
	}
	
	@PostMapping("/seekMemberSignup")
	public String registerPOST(MemberVO vo, String m_id, String m_email, RedirectAttributes rttr) {
		log.info("==========회원가입 성공!!!==========");
		
		int idResult = memberService.idCheck(m_id);
		int emailResult = memberService.emailCheck(m_email);
		
		String infoMsg = "회원가입 양식을 다시 한 번 확인해주세요.";
		
		try {
			if(idResult == 1 || emailResult == 1) {
				rttr.addFlashAttribute("check", infoMsg);
				return "redirect:/member/seekMemberSignup";	
			}else if(idResult == 0 && emailResult == 0) {
				rttr.addFlashAttribute("check", "success");
				memberService.register(vo);
				return "redirect:/member/seekMemberLogin";
			}	
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/main";
		
	}
	
	
	//마이페이지
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/seekMyPage")
	public void myPageGET() {
		
	}
	
	//마이페이지 - 비밀번호 교차 확인
	@ResponseBody
	@PostMapping("/pwCheck")
	public int pwCheckPOST(String m_id, String old_pw) {
		
		log.info("비밀번호 확인 아이디 값 : " + m_id);
		log.info("old_pw 값 : "+ old_pw);
		
		MemberVO vo = memberService.read(m_id);
		String m_pw = vo.getM_pw();
		
		log.info("m_pw 값 : " + m_pw);
		log.info("값 확인");
		
		boolean passchck = pwEncoder.matches(old_pw, m_pw);
		log.info(passchck);
		
		if(!passchck) {
			return 0;
			} else {
			return 1;
			}
	}
	
	//마이페이지 - 회원정보 변경 페이지 이동
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/seekMyUpdate")
	public void updateGET(MemberVO vo, HttpServletRequest req, Principal principal, RedirectAttributes rttr) {
		log.info("==========회원정보 수정페이지로 이동==========");
		
		//principal을 이용해서 로그인 한 유저의 id를 가져온다.
		String userid = principal.getName();
		vo = memberService.read(userid);
		
		//CUDS로부터 유저의 정보를 가져온다.
		UserDetails userInfo = userService.loadUserByUsername(userid);
		log.info("CUDS로부터 얻은 유저 정보 : " + userInfo);

		//session을 요청하고 값이 존재할 때, member로 치환한다.
		HttpSession session = req.getSession();
		if(vo == null) {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
		} else {
			session.setAttribute("member", vo);
		}
		
		//session으로부터 정보를 가져온다.
		MemberVO member = (MemberVO)session.getAttribute("member");
		
		//세션으로부터 얻은 유저의 정보와 CUDS로부터 얻은 유저의 정보를 비교한다.
		String sessionPw = member.getM_pw();
		log.info("세션으로부터 얻은 정보 : "+ sessionPw);
		String cudsPw = userInfo.getPassword();
		log.info("CUDS로부터 얻은 정보 : "+ cudsPw);
		
		//현재 vo에 담긴 값을 보여준다.
		String voPw = vo.getM_pw();
		log.info("vo에 담긴 정보 : " + voPw);

	}
	
	//마이페이지 - 회원정보수정
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/seekMyUpdate")
	public String updatePOST(MemberVO vo, RedirectAttributes rttr) {
		log.info("==========회원정보 수정 성공!!!==========");
		
		
		rttr.addFlashAttribute("result", "success");
		memberService.memberUpdate(vo);
				
		return "redirect:/main";
	}
	
	//마이페이지 - 회원 탈퇴
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/seekMemberDelete")
	public void memberDeleteGET(MemberVO vo, HttpSession session, RedirectAttributes rttr, HttpServletRequest req, Principal prin) {
		log.info("==========회원탈퇴 페이지로 이동==========");
		
		String userid = prin.getName();
		vo = memberService.read(userid);
		
		session = req.getSession();
		
		if(vo == null) {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
		} else {
			session.setAttribute("member", vo);
		}
		
		//session으로부터 정보를 가져온다.
		MemberVO member = (MemberVO)session.getAttribute("member");
		
//		String userid = prin.getName();
//		vo = memberService.read(userid);
//		model.addAttribute("member", vo);
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/seekMemberDelete")
	public String memberDeletePOST(MemberVO vo, Principal principal, HttpSession session, RedirectAttributes rttr) {
		//세션에 있는 값을 member변수에 등록
		MemberVO member = (MemberVO)session.getAttribute("member");
		//세션에 있는 비밀번호
		String sessionPw = member.getM_pw();
		log.info("세션 비밀번호 : "+ sessionPw);
		
		//vo에 있는 비밀번호
		String voPw = vo.getM_pw();
		
		log.info("vo 비밀번호 : "+ voPw);
		
		if(!(pwEncoder.matches(voPw, sessionPw))) {
			rttr.addFlashAttribute("msg", false);
			log.info("--에러--");
			return "redirect:/member/seekMemberDelete";
		}else {
			rttr.addFlashAttribute("result", "success");
			memberService.memberDelete(member);
			session.invalidate();
			log.info("==========회원탈퇴 성공!!!==========");
			return "redirect:/member/seekMemberLogout";
		}
	}
	
	//마이페이지 - 내가 쓴 식구찾기
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/seekMyAct")
	public void seekMyActGET(Principal prin, Model model, @Param("cri")Criteria cri) {
		String m_id = prin.getName();
		
		List<PBoardVO> myVO = pboardService.findMyPartner(m_id);
		
		List<PBoardVO> myVOOO = pboardService.myPagePList(m_id, cri);
		log.info("확인값 : " + myVOOO);
		
		int total = pboardService.getTotalCountMine(m_id, cri);
		log.info("내가 쓴 글의 갯수" + total);
		
		
		model.addAttribute("board", myVOOO);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	
	//마이페이지 - 내가 쓴 리뷰
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/seekMyReviews")
	public void seekMyReviewGET(Principal prin, Model model, @Param("cri")Criteria cri) {
		String m_id = prin.getName();
		
		List<RBoardVO> myVO = rboardService.myPageRList(m_id, cri);
		log.info("myVO>>>>>>>>>>>>>>" + myVO);
		
		int total = rboardService.getTotalCountMine(m_id, cri);
		log.info("내가 쓴 글의 갯수" + total);
		
		
		model.addAttribute("board", myVO);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	
	
	//회원가입시 인증 메일
	@GetMapping("/mailCheck")
	@ResponseBody
	public String mailCheckGET(String email) throws Exception {
		//뷰로부터 넘어온 데이터 확인
		log.info("이메일 데이터 전송 확인");
		log.info("인증번호를 전송할 이메일 : " + email);
		
		//인증번호(숫자 난수) 생성
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		log.info("인증 번호(숫자 난수) 확인 : " + checkNum);
		
		String setForm = "seekpartnermanager@gmail.com";
        String toMail = email;
        String title = "회원가입 인증 이메일 입니다.";
        String content = 
                "Seek.Partner 회원가입을 위한 인증 메일입니다." +
                "<br>" + 
                "인증 번호는 <strong>" + checkNum + "</strong>입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
		
        try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setForm);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        } catch(Exception e) {
            e.printStackTrace();
        }
    
        String num = Integer.toString(checkNum);
        
        return num;
	}
	
	
	//이메일로 아이디 찾기
	@GetMapping("/seekFindID")
	public void findIDGET() {}
	
	@PostMapping("/seekFindID")
	public void findIDPOST(String m_email, Model model, RedirectAttributes rttr) {
		String m_id = memberService.findID(m_email);
		log.info("아이디 조회 값 : " + m_id);	
		String info = "회원가입 내역이 없습니다.";
		
		if(m_id == null) {
			model.addAttribute("nope", info);
		} else {
			String maskingID = m_id.replaceAll("(?<=.{4}).", "*");
			model.addAttribute("member", maskingID);
		}
	}
	
	//이메일로 임시 비밀번호 전송 받기
	@GetMapping("/seekFindPW")
	public void findPWGET() {}
	
	@ResponseBody
	@PostMapping("/seekFindPW")
	public int findPWPOST(MemberVO vo, @Param("m_id")String m_id, @Param("m_email")String m_email, RedirectAttributes rttr, Model model) {
		
		int result = memberService.findPW(m_id, m_email);
		log.info(m_id);
		log.info(m_email);
		
		log.info("검색 결과 값 : " + result);
		
		if(result == 0) {
			return result;
		} else {
			
			String tempPassword = memberService.setPassword(10);
			log.info(tempPassword);
			
			String setForm = "seekpartnermanager@gmail.com";
	        String toMail = m_email;
	        String title = "임시비밀번호 발급 메일";
	        String content = 
	                "Seek.Partner 임시비밀번호를 보내드립니다." +
	                "<br><br>" + 
	                "<h4><strong>" + tempPassword + " </strong></h4>" + 
	                "<br>" + 
	                "발급받은 임시비밀번호로 로그인한 후  비밀번호를 재설정해주세요:)";
			
	        try {
	            MimeMessage message = mailSender.createMimeMessage();
	            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
	            helper.setFrom(setForm);
	            helper.setTo(toMail);
	            helper.setSubject(title);
	            helper.setText(content,true);
	            mailSender.send(message);
	            log.info(tempPassword);
	            
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	        
	        vo.setM_pw(pwEncoder.encode(tempPassword));
			memberService.pwUpdate(vo);
			
			return result;
		}
		
	}
	
	// 문의/신고 게시판으로 이동
	@GetMapping("/seekMyHelp")
	public void goToHelp(Model model, Criteria cri) {
		model.addAttribute("list", rpboardService.getList(cri));
	}
	
	
	//관리자 페이지
	@GetMapping("/admin/aList")
	public void admin(Model model, Criteria cri) {
		int total = memberService.getTotal(cri);
		log.info("관리자페이지 이동");
		model.addAttribute("aList", memberService.readList(cri));
		log.info(memberService.readList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	//관리자페이지 문의확인 목록
	@GetMapping("/admin/inquiryList")
	public void report(Model model, Criteria cri) {
		int total = rpboardService.getTotal(cri);
		model.addAttribute("arList", rpboardService.arlist(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	//관리자페이지 문의상세페이지
	@GetMapping("/admin/inquiryDetails")
	public void inquiryDetails(Model model, Long rpbno) {
		model.addAttribute("relist", rpboardService.get(rpbno));
	}
	//관리자페이지 문의삭제
	@PostMapping("/admin/remove")
	public String remove(Long rpbno) {
		log.info(rpbno + " 삭제");
		rpboardService.remove(rpbno);
		return "redirect:/member/admin/inquiryList";
	}

	//관리자페이지 신고확인 목록
	@GetMapping("/admin/REportList")
	public void REportList(Model model, Criteria cri) {
		int total = prService.getTotalCount(cri);
		
		model.addAttribute("list", prService.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	//관리자페이지 신고상세페이지
	@GetMapping("/admin/REportDetails")
	public void REportDetails(Model model, Long prebno) {
		model.addAttribute("relist", prService.read(prebno));
		log.info("신고디테일"+model);
	}
	//관리자페이지 신고삭제
	@PostMapping("/admin/reremove")
	public String reremove(Long prebno) {
		log.info(prebno + " 삭제");
		prService.remove(prebno);
		return "redirect:/member/admin/REportList";
	}
	
	//관리자페이지 신고 게시글 삭제
	@PostMapping("/admin/targetRemove")
	public String pRemove(Long pbno,Long prebno) {
		log.info("pbno 값"+pbno);
		log.info("pbno 값"+prebno);
			prService.remove(pbno);
			prService.remove(prebno);
		return "redirect:/member/admin/REportList";
	}
	
	
	
	
}
