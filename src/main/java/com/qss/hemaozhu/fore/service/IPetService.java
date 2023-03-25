package com.qss.hemaozhu.fore.service;

import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.fore.entity.Pet;

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
 * @since 2020-04-05
 */
public interface IPetService extends IService<Pet> {
	<E extends IPage<Pet>> E page(E page, Wrapper<Pet> queryWrapper);
	R add(Pet pet, MultipartFile file);
	R updateall(Pet pet, MultipartFile file);
	boolean removeById(Serializable id);
	boolean removeByIds(Collection<? extends Serializable> idList);
}
