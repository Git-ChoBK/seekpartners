package com.seek.mapper;

import java.util.ArrayList;
import java.util.Date;

import org.apache.ibatis.annotations.Param;

import com.seek.domain.Chat;
import com.seek.domain.ChatVO;

public interface ChatMapper {
	public ChatVO run(Long pbno);
	
	public ArrayList<Chat> getChatList(Long pbno);
	
	public void submit(@Param("pbno")Long pbno, @Param("chatName")String chatName, @Param("chatContent")String chatContent);
}
