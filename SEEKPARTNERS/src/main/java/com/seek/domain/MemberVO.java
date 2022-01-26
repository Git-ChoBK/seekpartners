package com.seek.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private String m_id;
	private String m_pw;
	private String m_email;
	private Date m_join;
	private Date m_update;
	private int m_enabled;
	private int m_rating;
	
	private List<AuthVO> authList;
}
