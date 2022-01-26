package com.seek.domain;

import org.apache.ibatis.annotations.Param;

import lombok.Data;

//@Getter
//@ToString
@Data
public class PageDTO {
	
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private Criteria cri;
	
	// 페이징 처리
	public PageDTO(@Param("cri")Criteria cri, int total) {
		this.cri = cri;
		this.total = total;

		// 끝번호와 시작번호 계산
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;	// 페이징 끝 번호 계산
		this.startPage = this.endPage - 9;								// 페이징 시작 번호 계산

		// endPage의 재계산
		int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
		
		if (realEnd <= this.endPage) {
			this.endPage = realEnd;
		}

		// 이전페이지와 다음페이지
		this.prev = this.startPage > 1;     // 이전페이지 계산(1보다 작으면 안 됨)
		this.next = this.endPage < realEnd; // 다음페이지 계산(realEnd가 endPage보다 큰 경우에만 존재)
	}
}
