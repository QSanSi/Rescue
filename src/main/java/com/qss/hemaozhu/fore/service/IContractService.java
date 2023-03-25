package com.qss.hemaozhu.fore.service;

import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.fore.entity.Contract;

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
public interface IContractService extends IService<Contract> {
	<E extends IPage<Contract>> E page(E page, Wrapper<Contract> queryWrapper);
	R add(Contract contract, MultipartFile file, MultipartFile file2);
	R updateall(Contract con, MultipartFile file1, MultipartFile file2);
	boolean removeById(Serializable id);
	boolean removeByIds(Collection<? extends Serializable> idList);
}
