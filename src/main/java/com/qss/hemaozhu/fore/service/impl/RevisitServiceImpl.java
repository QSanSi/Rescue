package com.qss.hemaozhu.fore.service.impl;

import com.qss.hemaozhu.admin.mapper.DeptMapper;
import com.qss.hemaozhu.fore.entity.Revisit;
import com.qss.hemaozhu.fore.mapper.ContractMapper;
import com.qss.hemaozhu.fore.mapper.RevisitMapper;
import com.qss.hemaozhu.fore.service.IRevisitService;
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
 * @since 2020-04-05
 */
@Service
public class RevisitServiceImpl extends ServiceImpl<RevisitMapper, Revisit> implements IRevisitService {
	@Autowired
	private RevisitMapper rvMapper;
	@Autowired
	private DeptMapper deptMapper;
	@Autowired
	private ContractMapper conMapper;

	@Override
	public <E extends IPage<Revisit>> E page(E page, Wrapper<Revisit> queryWrapper) {
		getBaseMapper().selectPage(page, queryWrapper);
		List<Revisit> rvlist = page.getRecords();
		if(rvlist.isEmpty()) {
			rvlist = new ArrayList<>();
		}
		for (Revisit rv : rvlist) {
			rv.setDept(deptMapper.selectById(rv.getDeptId()));
			rv.setCon(conMapper.selectById(rv.getContractId()));
		}
		page.setRecords(rvlist);
		return page;
	}

	@Override
	public boolean save(Revisit rv) {
		QueryWrapper<Revisit> param = new QueryWrapper<>();
		param.eq("contract_id", rv.getContractId());
		Integer count = rvMapper.selectCount(param);
		rv.setCount(count + 1);
		super.save(rv);
		return true;
	}

}
