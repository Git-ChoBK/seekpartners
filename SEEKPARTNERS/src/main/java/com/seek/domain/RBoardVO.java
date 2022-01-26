package com.seek.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class RBoardVO {
	
//	private Long rbno;			// 첨부게시판 테이블의 게시글 번호(pk)
	private Long rbno;			// 첨부게시판 테이블의 게시글 번호(pk)
	private String m_id;		// 첨부게시판 테이블의 회원 아이디
	private String r_title;		// 첨부게시판 테이블의 게시글 제목
	private String r_shop;		// 첨부게시판 테이블의 상호명
	private String r_content;	// 첨부게시판 테이블의 게시글 내용
	private String r_area;		// 첨부게시판 테이블의 지역값
	private String r_areasplit;	// 첨부게시판 테이블의 게시글 상 화면에 보여질 주소
	private Date r_date;		// 첨부게시판 테이블의 게시글 등록일
	private Date r_update;		// 첨부게시판 테이블의 게시글 수정일
	private int r_score;		// 첨부게시판 테이블의 평점
	private Double lat;			// 첨부게시판 테이블의 게시글 위도값
	private Double lng;			// 첨부게시판 테이블의 게시글 경도값
	
	private List<RboardAttachVO> attachList;

}
