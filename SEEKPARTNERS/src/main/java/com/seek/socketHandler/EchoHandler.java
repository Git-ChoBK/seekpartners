package com.seek.socketHandler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.userdetails.User;
import org.springframework.util.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.log4j.Log4j;

//@Repository
@Log4j
public class EchoHandler extends TextWebSocketHandler {
	//접속해있는 모든 유저들의 세션을 리스트로 담는다.
	List<WebSocketSession> sessions = new ArrayList<>();
	
	Map<String, WebSocketSession> userSessions = new HashMap<>();
	//서버에 접속이 성공 했을때
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		System.out.println("afterConnectionEstablished");
		System.out.println("웹소켓 서버 접속 성공 : " + session);
		
		sessions.add(session);
		String senderID = getID(session);
		userSessions.put(senderID, session);
		
	}
	
	//소켓에 메세지를 보냈을때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		System.out.println("handleTextMessage");
		System.out.println("메시지 전송 성공 : " + session + " : " + message);
		
		String senderID = getID(session);
		System.out.println("senderID : " + senderID);
//		//브로드 캐스팅
//		for(WebSocketSession sess : sessions) {
//			//전체에게 보낸 메시지는 js의 ws.onmessage에서 받을 수 있다.
//			sess.sendMessage(new TextMessage(senderID + " : " + message.getPayload()));
//		}
		
		//protocol: cmd, 댓글작성자, 게시글 작성자, pbno (reply, user2, user1, 484)
		String msg = message.getPayload();
		if(!StringUtils.isEmpty(msg)) {
			String[] strs = msg.split(",");
			
			if(strs != null && strs.length == 4) {
				String cmd = strs[0];
				String applicant = strs[1];
				String boardWriter = strs[2];
				String pbno = strs[3];
				System.out.println("cmd : " + cmd);
				System.out.println("applicant : " + applicant);
				System.out.println("boardWriter : " + boardWriter);
				System.out.println("pbno : " + pbno);
				
				WebSocketSession boardWriterSession =  userSessions.get(boardWriter);
				System.out.println(userSessions);
				System.out.println("boardWriterSession : " + boardWriterSession);
				
				
				if("reply".equals(cmd) && boardWriterSession != null && !strs[1].equals(strs[2])) {
					TextMessage tmpMsg = new TextMessage("<a href='/pBoard/pDetails?pbno=" + pbno + "'>" + applicant + "님이 식구 찾기에 댓글을 달았습니다 &nbsp:)</a>");
					boardWriterSession.sendMessage(tmpMsg);
				}
				if("apply".equals(cmd) && boardWriterSession != null && !strs[1].equals(strs[2])) {
					TextMessage tmpMsg = new TextMessage("<a href='/pBoard/pDetails?pbno=" + pbno + "'>" + applicant + "님이 채팅방에 입장했습니다 &nbsp:)</a>");
					boardWriterSession.sendMessage(tmpMsg);
				}
			}
		}
		
		
	}
	
	//연결 해제될때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		System.out.println("afterConnectionClosed");
		System.out.println("웹소켓 연결 해제 : " + session + " : " + status);
		
	}
	
	private String getID(WebSocketSession session) {	
		String loginUser = session.getPrincipal().getName();
		return loginUser;
		
	}
	
}