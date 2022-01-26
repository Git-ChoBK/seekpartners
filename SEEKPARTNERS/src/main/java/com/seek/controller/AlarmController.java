package com.seek.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.seek.domain.AlarmVO;
import com.seek.service.AlarmService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/member/*")
public class AlarmController {
	
	 private AlarmService alarmService;
	 
	 @ResponseBody
	 @GetMapping("/AlarmList")	 
	 public List<AlarmVO> readYetGet(Principal prin, String gboardwriter) {
		 
		gboardwriter = prin.getName(); 
		List<AlarmVO> list = alarmService.getAlarmListNoRead(gboardwriter);
		
		log.info("알람의 리턴 값 >>>>>>>>>>" + list);
	 
		return list;
		
	 }
	 
	 @ResponseBody
	 @PostMapping("/readIt")
	 public boolean readItPOST(Long ano) {
		 log.info("업데이트시 ano >>>>>>> " + ano);
		 boolean data = alarmService.readIt(ano);
		 log.info("성공여부 반환 값 >>>>>>>> " + data);
		 
		 return data;
	 }
	 
	 @PostMapping("/readCount")
	 public int readCount(String m_id, Principal prin) {
		 		 
		 int data = alarmService.readCount(m_id);
		 log.info("dataCheck>>>>>" + data);
		  
		 return data;
	 }

}
