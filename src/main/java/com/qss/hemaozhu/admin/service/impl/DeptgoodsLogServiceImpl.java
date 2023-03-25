package com.qss.hemaozhu.admin.service.impl;

import com.qss.hemaozhu.admin.entity.DeptGoods;
import com.qss.hemaozhu.admin.entity.DeptgoodsLog;
import com.qss.hemaozhu.admin.mapper.DeptGoodsMapper;
import com.qss.hemaozhu.admin.mapper.DeptMapper;
import com.qss.hemaozhu.admin.mapper.DeptgoodsLogMapper;
import com.qss.hemaozhu.admin.service.IDeptGoodsService;
import com.qss.hemaozhu.admin.service.IDeptgoodsLogService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 * 物资补充记录 服务实现类
 * </p>
 *
 * @author qss
 * @since 2020-03-30
 */
@Service
public class DeptgoodsLogServiceImpl extends ServiceImpl<DeptgoodsLogMapper, DeptgoodsLog> implements IDeptgoodsLogService {
	@Autowired
	private DeptMapper deptMapper;
	
	@Autowired
	private DeptGoodsMapper goodsMapper;
	
	@Autowired
	private DeptgoodsLogMapper logMapper;
	
	@Autowired
	private IDeptGoodsService goodsService;
		
	
	@Override
	@Transactional
	public boolean log(DeptGoods deptGoods, Integer count) {
		DeptgoodsLog log = new DeptgoodsLog();
		log.setGoodsId(deptGoods.getGoodsId());
		log.setCount(count);
		log.setRestcount(deptGoods.getCount());
		log.setDeptId(deptGoods.getDeptId());
		log.setStatus(1);
		Date time = new Date();
		log.setUpdateTime(time);
		this.save(log);
		return true;
	}

	@Override
	@Transactional
	public boolean request(DeptGoods deptGoods, Integer count) {
		DeptgoodsLog log = new DeptgoodsLog();
		log.setGoodsId(deptGoods.getGoodsId());
		log.setCount(count);
		log.setRestcount(deptGoods.getCount());
		log.setDeptId(deptGoods.getDeptId());
		log.setStatus(3);
		Date time = new Date();
		log.setRequestTime(time);
		this.save(log);
		return true;
	}

	@Override
	public <E extends IPage<DeptgoodsLog>> E page(E page, QueryWrapper<DeptgoodsLog> param) {
		getBaseMapper().selectPage(page, param);
		List<DeptgoodsLog> loglist = page.getRecords();
		if(loglist.isEmpty()) {
			loglist = new ArrayList<>();
		}
		for (DeptgoodsLog log : loglist) {
			log.setDeptGoods(goodsMapper.selectById(log.getGoodsId()));
			log.setDept(deptMapper.selectById(log.getDeptId()));
		}
		page.setRecords(loglist);
		return page;
	}

	@Override
	@Transactional
	public boolean accept(Integer id) {
		DeptgoodsLog log = logMapper.selectById(id);
		DeptGoods fk = goodsMapper.selectById(log.getGoodsId());
		DeptGoods zk = goodsMapper.selectById(fk.getParentId());
		if(!goodsService.expand(zk, log.getCount())) {
			return false;
		}else {
			this.log(zk, -log.getCount());
			log.setStatus(2);
			this.updateById(log);
			return true;
		}
	}

	@Override
	@Transactional
	public boolean check(Integer id) {
		DeptgoodsLog log = logMapper.selectById(id);
		DeptGoods fk = goodsMapper.selectById(log.getGoodsId());
		goodsService.more(fk, log.getCount());
		log.setStatus(1);
		Date date = new Date();
		log.setUpdateTime(date);
		log.setConfirmTime(date);
		this.updateById(log);
		return true;
	}

	@Override
	@Transactional
	public boolean ban(Integer id) {
		DeptgoodsLog log = logMapper.selectById(id);
		if(log.getStatus() != 3) {
			return false;
		}else {
			log.setStatus(0);
			this.updateById(log);
			return true;
		}
	}

	

}
