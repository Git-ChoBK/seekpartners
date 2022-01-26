package com.seek.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Chat {
	
	private Long pbno;
	private String chatName;
	private String chatContent;
	private Date chatTime;
}
