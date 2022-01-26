package com.seek.mapper;

import java.util.List;

import com.seek.domain.AlarmVO;

public interface AlarmMapper {
	public void saveAlarm (AlarmVO vo);
	
	public List<AlarmVO> getAlarmList();
	
	public List<AlarmVO> getAlarmListNoRead(String gboardwriter);
	
	public int readIt(Long ano);
	
	public int readCount(String m_id);
}
