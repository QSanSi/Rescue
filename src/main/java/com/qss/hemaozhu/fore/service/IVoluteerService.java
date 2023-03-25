package com.qss.hemaozhu.fore.service;

import com.qss.hemaozhu.fore.entity.Voluteer;

import java.io.Serializable;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author qss
 * @since 2020-04-05
 */
public interface IVoluteerService extends IService<Voluteer> {
	<E extends IPage<Voluteer>> E page(E page, QueryWrapper<Voluteer> param);
	Voluteer getById(Serializable id);
}
