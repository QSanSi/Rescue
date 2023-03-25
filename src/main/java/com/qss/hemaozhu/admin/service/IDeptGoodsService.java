package com.qss.hemaozhu.admin.service;

import com.qss.hemaozhu.admin.entity.DeptGoods;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 站点物资表 服务类
 * </p>
 *
 * @author qss
 * @since 2020-03-30
 */
public interface IDeptGoodsService extends IService<DeptGoods> {
	<E extends IPage<DeptGoods>> E page(E page, QueryWrapper<DeptGoods> param);
	
	boolean save(DeptGoods deptGoods);
	
	boolean status(DeptGoods deptGoods);
	
	boolean expand(DeptGoods deptGoods, Integer count);

	boolean more(DeptGoods newgoods, Integer count);
	
}
