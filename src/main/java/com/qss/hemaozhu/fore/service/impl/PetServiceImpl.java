package com.qss.hemaozhu.fore.service.impl;

import com.qss.hemaozhu.admin.mapper.DeptMapper;
import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.common.service.FileService;
import com.qss.hemaozhu.fore.entity.Pet;
import com.qss.hemaozhu.fore.mapper.PetMapper;
import com.qss.hemaozhu.fore.service.IPetService;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author qss
 * @since 2020-04-05
 */
@Service
public class PetServiceImpl extends ServiceImpl<PetMapper, Pet> implements IPetService {
	@Autowired
	private PetMapper petMapper;
	
	@Autowired
	private DeptMapper deptMapper;
	
	@Autowired
	private FileService fileService;
	
	@Override
	public <E extends IPage<Pet>> E page(E page, Wrapper<Pet> queryWrapper) {
		getBaseMapper().selectPage(page, queryWrapper);
		List<Pet> petlist = page.getRecords();
		if(petlist.isEmpty()) {
			petlist = new ArrayList<>();
		}
		for (Pet pet : petlist) {
			pet.setDept(deptMapper.selectById(pet.getDeptId()));
		}
		page.setRecords(petlist);
		return page;
	}

	@Override
	public R add(Pet pet, MultipartFile file) {
		String photo;
		try {
			if(!file.getOriginalFilename().isEmpty()) {
				photo = fileService.uploadpet(file);
				pet.setPhoto(photo);
			}
			this.save(pet);
			return R.ok();
		} catch (IOException e) {
			e.printStackTrace();
			return R.error(e.getMessage());
		}
		
	}

	@Override
	@Transactional
	public R updateall(Pet pet, MultipartFile file) {
		String photo;
		try {
			if(!file.getOriginalFilename().isEmpty()) {
				if(petMapper.selectById(pet).getPhoto() != null) {
					fileService.delFile(petMapper.selectById(pet).getPhoto());
				}
				photo = fileService.uploadpet(file);
				pet.setPhoto(photo);
			}
			this.updateById(pet);
			return R.ok();
		} catch (IOException e) {
			e.printStackTrace();
			return R.error(e.getMessage());
		}
	}

	@Override
	@Transactional
	public boolean removeById(Serializable id) {
		Pet pet = petMapper.selectById(id);
		if(pet.getPhoto() != null) {
			fileService.delFile(pet.getPhoto());
		}
		return super.removeById(id);
	}

	@Override
	@Transactional
	public boolean removeByIds(Collection<? extends Serializable> idList) {
		for (Serializable id : idList) {
			removeById(id);
		}
		return super.removeByIds(idList);
	}


}
