package com.seek.domain;

import java.util.Date;

import lombok.Data;

@Data
public class RPBoardVO {

	private long rpbno;			// 신고게시판 테이블의 게시글 번호(pk)
	private String m_id;		// 신고게시판 테이블의 회원 아이디(fk)
	private String rp_list;		// 신고게시판 테이블의 게시글 분류
	private String rp_title;	// 신고게시판 테이블의 게시글 제목
	private String rp_content;	// 신고게시판 테이블의 게시글 내용
	private Date rp_date;		// 신고게시판 테이블의 게시글 등록일
	private Date rp_update;		// 신고게시판 테이블의 게시글 수정일
	
}
