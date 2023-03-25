package com.qss.hemaozhu.fore.service;

import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.fore.entity.Cityadopt;

import java.io.Serializable;
import java.util.Collection;

import org.springframework.web.multipart.MultipartFile;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author qss
 * @since 2020-04-12
 */
public interface ICityadoptService extends IService<Cityadopt> {
	<E extends IPage<Cityadopt>> E page(E page, Wrapper<Cityadopt> queryWrapper);

	R add(Cityadopt cd, MultipartFile file);
	
	R updateallById(Cityadopt cd, MultipartFile file);
	
	boolean removeById(Serializable id);
	
	boolean removeByIds(Collection<? extends Serializable> idList);
}
