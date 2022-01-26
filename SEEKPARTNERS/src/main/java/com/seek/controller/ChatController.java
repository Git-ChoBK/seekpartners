package com.seek.controller;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

import org.apache.ibatis.annotations.Param;
import org.apache.taglibs.standard.lang.jstl.test.beans.PublicBean1;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.seek.domain.Chat;
import com.seek.domain.ChatVO;
import com.seek.domain.Criteria;
import com.seek.domain.PBoardVO;
import com.seek.domain.PageDTO;
import com.seek.service.ChatService;
import com.seek.service.PBoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
@RequestMapping("/pBoard/*")
public class ChatController {
	
	private ChatService service;
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/chatroom")
	public void getinfo(Long pbno, Model model, Principal prin) {
		log.info(pbno+"번 채팅방 입장.");
		ChatVO vo = service.run(pbno);
		ArrayList<Chat> listvo = service.getChatList(pbno);
		String sendname ="";
		String sendtime = "";
		String sendcontent ="";
		String strtemp ="";
		
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (int i = 0; i < listvo.size(); i++) {
			sendname += listvo.get(i).getChatName()+",";
			int chattime = Integer.parseInt(fm.format(listvo.get(i).getChatTime()).substring(11, 13));
			String timeType = "오전";
			if(Integer.parseInt(fm.format(listvo.get(i).getChatTime()).substring(11, 13))>12) {
				timeType = "오후";
				chattime -= 12;
				}
			strtemp =fm.format(listvo.get(i).getChatTime());
			sendtime += strtemp.substring(0, 11)+" "+ timeType+" "+chattime+":"+strtemp.substring(14, 16)+",";
			sendcontent += listvo.get(i).getChatContent()+",";
		}
		log.info(sendname);
		log.info(sendtime);		
		sendcontent.replaceAll(" ", "&nbsp;").replaceAll("<", "%lt;").replaceAll(">", "&gh;").replaceAll("\n", "<br>");
		log.info(sendcontent);
		
		vo.setM_id(prin.getName());
		model.addAttribute("ChatInfo", vo);
		model.addAttribute("sendname", sendname);
		model.addAttribute("sendtime", sendtime);
		model.addAttribute("sendcontent", sendcontent);
//		return "redirect:/pBoard/chatroom";
	}
	
	@ResponseBody
	@PostMapping("/chatroom")
	public void recordchat(@Param("pbno")Long pbno, @Param("chatName")String chatName, @Param("chatContent")String chatContent) {
		log.info(pbno);
		try {
			service.submit(pbno, chatName, chatContent);
			
		} catch (Exception e) {
			// TODO: handle exception
			log.info("빈값있음");
		}	
	}
	
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	@PostMapping("/chatlist")
	public void loadchat(@Param("pbno")Long pbno) {
		ArrayList<Chat> vo = service.getChatList(pbno);
		log.info(vo);
	}
}
