package com.seek.domain;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import lombok.Data;
import oracle.sql.DATE;

@Data
public class PBoardVO {
	private long pbno;
	private String m_id;
	private String p_title;
	private String p_content;
	private String p_menu;
	private Date p_date;
	private Date p_update;
	private int p_rpl_cnt;
	private int p_maxmember;
	private Date p_time;
	private int p_total;
	private String p_area;
	private String p_areasplit;
	private Double lat;
	private Double lng;
	private String status;
	
//	public Date transtime(Date time) throws ParseException {
//        // 여기에 원하는 포맷을 넣어주면 된다
//        SimpleDateFormat tranSimpleFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH);
//
//        Date tempdate = tranSimpleFormat.parse(tranSimpleFormat.format(time));
//        System.out.println("1111111::::::"+tempdate);
//        String temp = tranSimpleFormat.format(time);
//
//        return tranSimpleFormat.parse(temp);
//	}
}
