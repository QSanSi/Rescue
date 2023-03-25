package com.qss.hemaozhu.admin.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.qss.hemaozhu.admin.entity.Area;
import com.qss.hemaozhu.admin.service.IAreaService;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author qss
 * @since 2020-04-13
 */
@Controller
@RequestMapping("/area")
public class AreaController {
	
	@Autowired
	private IAreaService areaService;
	
	/**
	 * 省
	 * @return
	 */
	@RequestMapping("/province")
	@ResponseBody
	public List<Area> getprovince() {
		QueryWrapper<Area> param = new QueryWrapper<>(); 
		param.eq("type", "1");
		List<Area> parealist = areaService.list(param);
		return parealist;
	}
	
	/**
	 * 市
	 * @param pid
	 * @return
	 */
	@RequestMapping("/city/{pid}")
	@ResponseBody
	public List<Area> getcity(@PathVariable Integer pid) {
		QueryWrapper<Area> param = new QueryWrapper<>(); 
		param.eq("type", "2");
		param.eq("parent_id", pid);
		List<Area> carealist = areaService.list(param);
		return carealist;
	}
	
	/**
	 * 区
	 * @param cid
	 * @return
	 */
	@RequestMapping("/district/{cid}")
	@ResponseBody
	public List<Area> getdistrict(@PathVariable Integer cid) {
		QueryWrapper<Area> param = new QueryWrapper<>(); 
		param.eq("type", "3");
		param.eq("parent_id", cid);
		List<Area> darealist = areaService.list(param);
		return darealist;
	}
}
