package com.seek.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.seek.domain.AlarmVO;
import com.seek.mapper.AlarmMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class AlarmServiceImpl implements AlarmService {
	
	private AlarmMapper alarmMapper;

	@Override
	public void saveAlarm(AlarmVO vo) {
		alarmMapper.saveAlarm(vo);
		
	}

	@Override
	public List<AlarmVO> getAlarmList() {
		return alarmMapper.getAlarmList();
	}

	@Override
	public List<AlarmVO> getAlarmListNoRead(String gboardwriter) {
		return alarmMapper.getAlarmListNoRead(gboardwriter);
	}

	@Override
	public boolean readIt(Long ano) {
		return alarmMapper.readIt(ano) == 1;
	}

	@Override
	public int readCount(String m_id) {
		return alarmMapper.readCount(m_id);
	}

}
