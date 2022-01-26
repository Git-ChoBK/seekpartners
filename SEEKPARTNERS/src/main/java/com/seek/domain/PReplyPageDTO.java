package com.seek.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class PReplyPageDTO {
	
	private int replyCnt;
	private List<PReplyVO> list;

}
