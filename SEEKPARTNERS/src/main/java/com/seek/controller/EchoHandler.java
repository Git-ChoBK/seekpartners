package com.seek.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.seek.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@Repository
@Log4j
public class EchoHandler extends TextWebSocketHandler {
	
	//서버에 접속이 성공 했을때
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		log.info("afterConnectionEstablished");
		log.info("웹소켓 서버 접속 성공 : " + session);
		
	}
	
	
	//소켓에 메세지를 보냈을때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		log.info("handleTextMessage");
		log.info("메시지 전송 성공 : " + session + " : " + message);

	}
	
	//연결 해제될때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		log.info("afterConnectionClosed");
		log.info("웹소켓 연결 해제 : " + session + " : " + status);
		
	}

	
}