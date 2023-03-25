package com.qss.hemaozhu.fore.service.impl;

import com.qss.hemaozhu.admin.mapper.AreaMapper;
import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.common.service.FileService;
import com.qss.hemaozhu.fore.entity.Cityadopt;
import com.qss.hemaozhu.fore.mapper.CityadoptMapper;
import com.qss.hemaozhu.fore.mapper.UsersMapper;
import com.qss.hemaozhu.fore.service.ICityadoptService;
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
 * @since 2020-04-12
 */
@Service
public class CityadoptServiceImpl extends ServiceImpl<CityadoptMapper, Cityadopt> implements ICityadoptService {
	@Autowired
	private UsersMapper userMapper;
	@Autowired
	private FileService fileService;
	@Autowired
	private CityadoptMapper cdMapper;
	@Autowired
	private AreaMapper areaMapper;

	@Override
	public <E extends IPage<Cityadopt>> E page(E page, Wrapper<Cityadopt> queryWrapper) {
		getBaseMapper().selectPage(page, queryWrapper);
		List<Cityadopt> cdlist = page.getRecords();
		if(cdlist.isEmpty()) {
			cdlist = new ArrayList<>();
		}
		for (Cityadopt cd : cdlist) {
			cd.setUser(userMapper.selectById(cd.getUserId()));
			cd.setArea(areaMapper.selectById(cd.getCity()));
		}
		page.setRecords(cdlist);
		return page;
	}
	
	@Override
	public R add(Cityadopt cd, MultipartFile file) {
		String photo;
		try {
			if(!file.getOriginalFilename().isEmpty()) {
				photo = fileService.uploadcityadopt(file);
				cd.setPhoto(photo);
			}
			this.save(cd);
			return R.ok();
		} catch (IOException e) {
			e.printStackTrace();
			return R.error(e.getMessage());
		}
	}

	@Override
	@Transactional
	public R updateallById(Cityadopt cd, MultipartFile file) {
		String photo;
		try {
			if(!file.getOriginalFilename().isEmpty()) {
				if(cdMapper.selectById(cd).getPhoto() != null) {
					fileService.delFile(cdMapper.selectById(cd).getPhoto());
				}
				photo = fileService.uploadcityadopt(file);
				cd.setPhoto(photo);
			}
			this.updateById(cd);
			return R.ok();
		} catch (IOException e) {
			e.printStackTrace();
			return R.error(e.getMessage());
		}
	}
	
	@Override
	@Transactional
	public boolean removeById(Serializable id) {
		Cityadopt cd = cdMapper.selectById(id);
		if(cd.getPhoto() != null) {
			fileService.delFile(cd.getPhoto());
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
