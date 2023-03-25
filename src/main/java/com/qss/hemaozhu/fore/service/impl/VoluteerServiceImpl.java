package com.qss.hemaozhu.fore.service.impl;

import com.qss.hemaozhu.admin.mapper.AreaMapper;
import com.qss.hemaozhu.admin.mapper.DeptMapper;
import com.qss.hemaozhu.common.util.IdcardMaskUtil;
import com.qss.hemaozhu.fore.entity.Voluteer;
import com.qss.hemaozhu.fore.mapper.UsersMapper;
import com.qss.hemaozhu.fore.mapper.VoluteerMapper;
import com.qss.hemaozhu.fore.service.IVoluteerService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.io.Serializable;
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
 * @since 2020-04-05
 */
@Service
public class VoluteerServiceImpl extends ServiceImpl<VoluteerMapper, Voluteer> implements IVoluteerService {
	@Autowired
	private AreaMapper areaMapper;
	
	@Autowired
	private UsersMapper userMapper;
	
	@Autowired
	private DeptMapper deptMapper;
	
	@Override
	public <E extends IPage<Voluteer>> E page(E page, QueryWrapper<Voluteer> param) {
		getBaseMapper().selectPage(page, param);
		List<Voluteer> vollist = page.getRecords();
		if(vollist.isEmpty()) {
			vollist = new ArrayList<>();
		}
		for (Voluteer vol : vollist) {
			String Parea = areaMapper.selectById(vol.getProvince()).getName();
			String Carea = areaMapper.selectById(vol.getCity()).getName();
			String Darea = areaMapper.selectById(vol.getDistrict()).getName();
			String area = Parea + Carea + Darea;
			vol.setArea(area);
			vol.setUser(userMapper.selectById(vol.getUserId()));
			vol.setDept(deptMapper.selectById(vol.getDeptId()));
		}
		page.setRecords(vollist);
		return page;
	}

	@Override
	public Voluteer getById(Serializable id) {
		Voluteer vol = super.getById(id);
		vol.setIdcard(IdcardMaskUtil.idMask(vol.getIdcard(), 3, 3));
		return vol;
	}

}
