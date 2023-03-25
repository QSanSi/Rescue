package com.qss.hemaozhu.fore.service;

import com.qss.hemaozhu.fore.entity.Adoption;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author qss
 * @since 2020-04-10
 */
public interface IAdoptionService extends IService<Adoption> {
	<E extends IPage<Adoption>> E page(E page, Wrapper<Adoption> queryWrapper);
}
