package com.qss.hemaozhu.admin.service.impl;

import com.qss.hemaozhu.admin.entity.Dept;
import com.qss.hemaozhu.admin.mapper.AreaMapper;
import com.qss.hemaozhu.admin.mapper.DeptMapper;
import com.qss.hemaozhu.admin.service.IDeptService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 部门/站点信息 服务实现类
 * </p>
 *
 * @author qss
 * @since 2020-03-20
 */
@Service
public class DeptServiceImpl extends ServiceImpl<DeptMapper, Dept> implements IDeptService {
	
	@Autowired
	private AreaMapper areaMapper;

	/**
	 * 获取部门信息
	 * @param id
	 * @return
	 */
	@Override
	public <E extends IPage<Dept>> E page(E page, QueryWrapper<Dept> param) {
		getBaseMapper().selectPage(page, param);
		List<Dept> deptlist = page.getRecords();
		if(deptlist.isEmpty()) {
			deptlist = new ArrayList<>();
		}
		for (Dept dept : deptlist) {
			String Parea = areaMapper.selectById(dept.getPareaId()).getName();
			String Carea = areaMapper.selectById(dept.getCareaId()).getName();
			String Darea = areaMapper.selectById(dept.getDareaId()).getName();
			String area = Parea;
			if(!Carea.equals(Parea)) {
				area += Carea;
			}
			area += Darea;
			String sarea = null;
			if(dept.getType()==1) {
				sarea = "全国";
			}else {
				sarea = Parea;
				if(!Carea.equals(Parea)) {
					sarea += Carea;
				}
			}
			dept.setDeptArea(area);
			dept.setServiceArea(sarea);
		}
		page.setRecords(deptlist);
		return page;
	}

}
