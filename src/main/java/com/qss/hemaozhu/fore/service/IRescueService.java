package com.qss.hemaozhu.fore.service;

import com.qss.hemaozhu.fore.entity.Rescue;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author qss
 * @since 2020-04-14
 */
public interface IRescueService extends IService<Rescue> {
	<E extends IPage<Rescue>> E page(E page, Wrapper<Rescue> queryWrapper);
	boolean save(Rescue rescue);
}
