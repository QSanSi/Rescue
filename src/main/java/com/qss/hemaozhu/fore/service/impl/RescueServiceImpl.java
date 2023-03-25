package com.qss.hemaozhu.fore.service.impl;

import com.qss.hemaozhu.admin.entity.Dept;
import com.qss.hemaozhu.admin.mapper.AreaMapper;
import com.qss.hemaozhu.admin.mapper.DeptMapper;
import com.qss.hemaozhu.fore.entity.Rescue;
import com.qss.hemaozhu.fore.entity.Users;
import com.qss.hemaozhu.fore.entity.Voluteer;
import com.qss.hemaozhu.fore.mapper.RescueMapper;
import com.qss.hemaozhu.fore.mapper.UsersMapper;
import com.qss.hemaozhu.fore.mapper.VoluteerMapper;
import com.qss.hemaozhu.fore.service.IRescueService;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
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
 * @since 2020-04-14
 */
@Service
public class RescueServiceImpl extends ServiceImpl<RescueMapper, Rescue> implements IRescueService {
	@Autowired
	private UsersMapper userMapper;
	@Autowired
	private DeptMapper deptMapper;
	@Autowired
	private AreaMapper areaMapper;
	@Autowired
	private VoluteerMapper volMapper;

	@Override
	public <E extends IPage<Rescue>> E page(E page, Wrapper<Rescue> queryWrapper) {
		getBaseMapper().selectPage(page, queryWrapper);
		List<Rescue> rescuelist = page.getRecords();
		if(rescuelist.isEmpty()) {
			rescuelist = new ArrayList<>();
		}
		for (Rescue rescue : rescuelist) {
			Users user = userMapper.selectById(rescue.getUserId());
			rescue.setUser(user);
			QueryWrapper<Voluteer> param = new QueryWrapper<>();
			param.eq("user_id", user.getUserId());
			rescue.setVol(volMapper.selectOne(param));
			rescue.setArea(areaMapper.selectById(rescue.getCity()));
		}
		page.setRecords(rescuelist);
		return page;
	}

	@Override
	public boolean save(Rescue rescue) {
		QueryWrapper<Dept> param = new QueryWrapper<>();
		param.eq("parea_id", rescue.getProvince());
		param.eq("carea_id", rescue.getCity());
		if(deptMapper.selectCount(param) != 0) {
			super.save(rescue);
			return true;
		}
		else
			return false;
	}

}
