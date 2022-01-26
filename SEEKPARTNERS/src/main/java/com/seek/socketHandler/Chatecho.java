package com.seek.socketHandler;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.ws.rs.core.MultivaluedHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class Chatecho extends TextWebSocketHandler {
	   //접속해있는 모든 유저들의 세션을 리스트로 담는다.
	   
	   Map<String, WebSocketSession> userSessions = new HashMap<>();
	   MultivaluedHashMap<String, WebSocketSession> roomOnSession = new MultivaluedHashMap<String, WebSocketSession>();
	   
	   //서버에 접속이 성공 했을때
	   @Override
	   public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	      
	      System.out.println("afterConnectionEstablished");
	      System.out.println("웹소켓 서버 접속 성공 : " + session);
	      String temp = session.getUri().toString();
	      temp = temp.split("=")[1];
	      System.out.println(temp);
	      try {
			roomOnSession.get(temp).add(session);
		} catch (Exception e) {
			// TODO: handle exception
			List<WebSocketSession> newsessions = new ArrayList<>();
			newsessions.add(session);
			roomOnSession.put(temp, newsessions);
		}
	      System.out.println(roomOnSession.get(temp));
	      
	      
	   }
	   
	   //소켓에 메세지를 보냈을때
	   @Override
	   protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	      
	      System.out.println("handleTextMessage");
	      System.out.println("메시지 전송 성공 : " + session + " : " + message);
	      
	      String senderID = getID(session);
	      System.out.println("senderID : " + senderID);
	      
	      String getmsg = message.getPayload();
	      System.out.println(getmsg);
	      
	      String pbno = getmsg.split(",")[0];
	      String chatname = getmsg.split(",")[1];
	      String chatcontent = getmsg.split(",")[2];
	      String chattime = getmsg.split(",")[3];
	      
	      System.out.println(pbno+chatname+chatcontent+chattime);
	      System.out.println(roomOnSession.get(pbno).size());
	      System.out.println(roomOnSession);
	      for(int i=0;i<roomOnSession.get(pbno).size();i++) {
	    	  roomOnSession.get(pbno).get(i).sendMessage(message);
	      }
	      
	   }
	   
	   //연결 해제될때
	   @Override
	   public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	      
	      System.out.println("afterConnectionClosed");
	      System.out.println("웹소켓 연결 해제 : " + session + " : " + status);
	      String temp = session.getUri().toString();
	      temp = temp.split("=")[1];
	      if(roomOnSession.get(temp).size() !=1) {
	    	  roomOnSession.get(temp).remove(session);
	      }else {
	    	  roomOnSession.remove(temp).remove(session);
	      }
	   }
	   
	   private String getID(WebSocketSession session) {   
	      String loginUser = session.getPrincipal().getName();
	      return loginUser;
	      
	   }
	   
	}