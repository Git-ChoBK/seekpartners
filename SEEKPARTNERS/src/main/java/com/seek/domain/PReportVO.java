package com.seek.domain;

import java.util.Date;

import lombok.Data;

@Data
public class PReportVO {

	private Long prebno;		// 회원 신고게시판 게시글 번호(pk)
	private String m_id;		// 회원 신고게시판 작성자 아이디(fk)
	private String reporter;	// 회원 신고게시판 신고자 아이디
	private Long pbno;			// 회원 신고게시판 참조글 번호(fk)
	private String pre_title;	// 회원 신고게시판 게시글 제목
	private String pre_content;	// 회원 신고게시판 게시글 내용
	private String pre_list;	// 회원 신고게시판 신고분류
	private Date pre_date;		// 회원 신고게시판 게시글 작성 날짜
	private Date pre_update;	// 회원 신고게시판 게시글 수정 날짜
}
