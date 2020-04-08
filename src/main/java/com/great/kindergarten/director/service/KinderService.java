package com.great.kindergarten.director.service;

import com.great.kindergarten.commons.entity.TblKinder;
import com.great.kindergarten.director.mapper.KinderMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import javax.annotation.Resource;

/**
 * @author JK
 * 园所实体类
 */
@Service
public class KinderService
{
	@Resource
	private KinderMapper kinderMapper;
	//申请园所
	@Transactional
	public int addKinderMsg(TblKinder tblKinder){
		return  kinderMapper.addKinderMsg(tblKinder);
	}
}
