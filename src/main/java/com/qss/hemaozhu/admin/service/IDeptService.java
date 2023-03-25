package com.qss.hemaozhu.admin.service;

import com.qss.hemaozhu.admin.entity.Dept;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 部门/站点信息 服务类
 * </p>
 *
 * @author qss
 * @since 2020-03-20
 */
public interface IDeptService extends IService<Dept> {
	/**
	 * 根据deptId获取dept信息
	 * @param id
	 * @return
	 */
	<E extends IPage<Dept>> E page(E page, QueryWrapper<Dept> param);
}
