package com.seek.domain;

import java.util.Date;

import lombok.Data;

@Data
public class PReplyVO {

	private Long prno;
	private Long pbno;
	
	private String pr_content;
	private String m_id;
	private Date pr_date;
	private Date pr_update;
	
	private String gboardwriter;
}
