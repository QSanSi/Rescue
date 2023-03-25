package com.qss.hemaozhu.fore.service;

import com.qss.hemaozhu.fore.entity.Revisit;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
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
public interface IRevisitService extends IService<Revisit> {
	<E extends IPage<Revisit>> E page(E page, Wrapper<Revisit> queryWrapper);
	boolean save(Revisit rv);
}
