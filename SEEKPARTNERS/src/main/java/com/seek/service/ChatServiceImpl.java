package com.seek.service;

import java.util.ArrayList;
import java.util.Date;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seek.domain.Chat;
import com.seek.domain.ChatVO;
import com.seek.mapper.ChatMapper;


import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class ChatServiceImpl implements ChatService{
	
	@Autowired
	private ChatMapper mapper;
	
	@Override
	public ChatVO run(Long pbno) {
		// TODO Auto-generated method stub
		return mapper.run(pbno);
	}

	@Override
	public ArrayList<Chat> getChatList(Long pbno) {
		// TODO Auto-generated method stub
		return mapper.getChatList(pbno);
	}

	@Override
	public void submit(@Param("pbno")Long pbno, @Param("chatName")String chatName, @Param("chatContent")String chatContent) {
		// TODO Auto-generated method stub
		mapper.submit(pbno, chatName, chatContent);
	}
}
