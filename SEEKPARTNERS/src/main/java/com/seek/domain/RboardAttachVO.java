package com.seek.domain;

import lombok.Data;

@Data
public class RboardAttachVO {
	private String uuid;
	private String uploadpath;
	private String filename;
	private boolean filetype;
	
	private Long rbno;
}
