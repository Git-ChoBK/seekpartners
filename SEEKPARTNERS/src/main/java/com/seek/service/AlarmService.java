package com.seek.service;

import java.util.List;

import com.seek.domain.AlarmVO;

public interface AlarmService {
	public void saveAlarm (AlarmVO vo);
	
	public List<AlarmVO> getAlarmList();
	
	public List<AlarmVO> getAlarmListNoRead(String gboardwriter);
	
	public boolean readIt(Long ano);
	
	public int readCount(String m_id);

}
