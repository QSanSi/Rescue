package com.qss.hemaozhu.admin.service.impl;

import com.qss.hemaozhu.admin.entity.DeptGoods;
import com.qss.hemaozhu.admin.mapper.DeptGoodsMapper;
import com.qss.hemaozhu.admin.mapper.DeptMapper;
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

/**
 * <p>
 * 站点物资表 服务实现类
 * </p>
 *
 * @author qss
 * @since 2020-03-30
 */
@Service
public class DeptGoodsServiceImpl extends ServiceImpl<DeptGoodsMapper, DeptGoods> implements IDeptGoodsService {

	@Autowired
	private DeptMapper deptMapper;
	
	@Autowired
	private IDeptgoodsLogService logService;
	
	@Override
	public <E extends IPage<DeptGoods>> E page(E page, QueryWrapper<DeptGoods> param) {
		getBaseMapper().selectPage(page, param);
		List<DeptGoods> goodslist = page.getRecords();
		if(goodslist.isEmpty()) {
			goodslist = new ArrayList<>();
		}
		for (DeptGoods goods : goodslist) {
			goods.setDept(deptMapper.selectById(goods.getDeptId()));
			if(goods.getDept().getType() == 1) {
				goods.setDept(deptMapper.selectById(1));
			}
		}
		page.setRecords(goodslist);
		return page;
	}

	@Override
	public boolean save(DeptGoods deptGoods) {
		if(deptGoods.getParentId() != null) {
			DeptGoods parent = this.getById(deptGoods.getParentId());
			deptGoods.setName(parent.getName());
			deptGoods.setPrice(parent.getPrice());
		}
		this.status(deptGoods);
		logService.log(deptGoods, deptGoods.getCount());
		return super.save(deptGoods);
	}

	@Override
	public boolean status(DeptGoods deptGoods) {
		if(deptGoods.getDeptId() == 1) {
			if(deptGoods.getCount() >= 2000) {
				deptGoods.setStatus(1);
			}else if(deptGoods.getCount() >= 1000) {
				deptGoods.setStatus(2);
			}else if(deptGoods.getCount() >= 500) {
				deptGoods.setStatus(3);
			}else if(deptGoods.getCount() > 0) {
				deptGoods.setStatus(4);
			}else {
				deptGoods.setStatus(5);
			}
		}else {
			if(deptGoods.getCount() >= 200) {
				deptGoods.setStatus(1);
			}else if(deptGoods.getCount() >= 100) {
				deptGoods.setStatus(2);
			}else if(deptGoods.getCount() >= 50) {
				deptGoods.setStatus(3);
			}else if(deptGoods.getCount() > 0) {
				deptGoods.setStatus(4);
			}else {
				deptGoods.setStatus(5);
			}
		}
		return true;
	}

	@Override
	public boolean expand(DeptGoods deptGoods, Integer count) {
		if(deptGoods.getCount() < count) {
			return false;
		}else {
			deptGoods.setCount(deptGoods.getCount() - count);
	    	Date time=new Date();
	    	deptGoods.setUpdateTime(time);
	    	this.status(deptGoods);
	    	this.updateById(deptGoods);
	    	return true;
		}
	}

	@Override
	public boolean more(DeptGoods deptGoods, Integer count) {
		deptGoods.setCount(deptGoods.getCount() + count);
    	Date time=new Date();
    	deptGoods.setUpdateTime(time);
    	this.status(deptGoods);
    	this.updateById(deptGoods);
		return true;
	}

}
