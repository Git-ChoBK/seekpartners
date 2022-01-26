package com.seek.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ScoreVO {
	
	private Long sbno;
	private Long s_score;
	
	private String m_id;
	private String s_id;
	private String s_comment;
	
	private Date s_date;	
}
