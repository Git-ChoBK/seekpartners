package com.seek.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

//@Getter
//@Setter
//@ToString
@Data
public class Criteria {	// 검색기준
	
	private int pageNum;
	private int	amount;
	
	private String type;
	private String keyword;
	
	public Criteria() {
		this(1, 12);		// 페이지당 글은 9개까지만 화면에 보여줌
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;	// 9개만 보여줌
	}
	
	public String[] getTypeArr() {
		
		return type == null ? new String[] {} : type.split("");
	}
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
		.queryParam("pageNum", this.pageNum)
		.queryParam("amount", this.getAmount())
		.queryParam("type", this.getType())
		.queryParam("keyword", this.getKeyword());
		
		return builder.toUriString();
	}

}
