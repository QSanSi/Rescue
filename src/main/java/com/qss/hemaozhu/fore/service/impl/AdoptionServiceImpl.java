package com.qss.hemaozhu.fore.service.impl;

import com.qss.hemaozhu.admin.mapper.DeptMapper;
import com.qss.hemaozhu.fore.entity.Adoption;
import com.qss.hemaozhu.fore.mapper.AdoptionMapper;
import com.qss.hemaozhu.fore.mapper.PetMapper;
import com.qss.hemaozhu.fore.service.IAdoptionService;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author qss
 * @since 2020-04-10
 */
@Service
public class AdoptionServiceImpl extends ServiceImpl<AdoptionMapper, Adoption> implements IAdoptionService {
	@Autowired
	private DeptMapper deptMapper;
	@Autowired
	private PetMapper petMapper;
	
	@Override
	public <E extends IPage<Adoption>> E page(E page, Wrapper<Adoption> queryWrapper) {
		getBaseMapper().selectPage(page, queryWrapper);
		List<Adoption> adoptlist = page.getRecords();
		if(adoptlist.isEmpty()) {
			adoptlist = new ArrayList<>();
		}
		for (Adoption adopt : adoptlist) {
			adopt.setDept(deptMapper.selectById(adopt.getDeptId()));
			adopt.setPet(petMapper.selectById(adopt.getPetId()));
		}
		page.setRecords(adoptlist);
		return page;
	}

}
