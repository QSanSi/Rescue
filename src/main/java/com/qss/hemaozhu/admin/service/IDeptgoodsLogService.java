package com.qss.hemaozhu.admin.service;

import com.qss.hemaozhu.admin.entity.DeptGoods;
import com.qss.hemaozhu.admin.entity.DeptgoodsLog;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 物资补充记录 服务类
 * </p>
 *
 * @author qss
 * @since 2020-03-30
 */
public interface IDeptgoodsLogService extends IService<DeptgoodsLog> {
	
	<E extends IPage<DeptgoodsLog>> E page(E page, QueryWrapper<DeptgoodsLog> param);
	
	boolean log(DeptGoods deptGoods, Integer count);

	boolean request(DeptGoods deptGoods, Integer count);

	boolean accept(Integer id);

	boolean check(Integer id);

	boolean ban(Integer id);
}
