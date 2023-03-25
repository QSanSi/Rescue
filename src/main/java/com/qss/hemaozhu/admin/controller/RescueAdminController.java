package com.qss.hemaozhu.admin.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.qss.hemaozhu.admin.entity.Dept;
import com.qss.hemaozhu.admin.service.IDeptService;
import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.fore.entity.Rescue;
import com.qss.hemaozhu.fore.service.IRescueService;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author qss
 * @since 2020-04-14
 */
@Controller
@RequestMapping("/admin/rescue")
public class RescueAdminController {
	@Autowired
	private IRescueService rescueService;
	@Autowired
	private IDeptService deptService;
	
	@RequestMapping("/rescue")
	public String list() {
		return "admin/article/rescue/rescue_list";
	}
	
	@RequestMapping("/data")
	@ResponseBody
	public R data(String title, Integer deptId, Page<Rescue> page) {
		QueryWrapper<Rescue> param = new QueryWrapper<>();
		if(!StringUtils.isEmpty(title)) {
			param.like("title", title);
		}
		if(deptId != 1) {
			Dept dept = deptService.getById(deptId);
			param.eq("province", dept.getPareaId());
			param.eq("city", dept.getCareaId());
		}
		param.orderByAsc("verify");
		param.orderByAsc("status");
		param.orderByDesc("create_time");
		page = rescueService.page(page, param);
		return R.ok(page);
	}
	
	@RequestMapping("/update/{rescueId}")
	public String update(@PathVariable Integer rescueId, Model model) {
		model.addAttribute("rescue", rescueService.getById(rescueId));
		return "admin/article/rescue/rescue_update";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public R update(Rescue rescue) {
		rescueService.updateById(rescue);
		return R.ok();
	}
	
	@RequestMapping("/accept/{rescueId}")
	@ResponseBody
	public R accept(@PathVariable Integer rescueId) {
		Rescue rescue = rescueService.getById(rescueId);
		rescue.setVerify(1);
		rescueService.updateById(rescue);
		return R.ok();
	}
	
	@RequestMapping(value = "/acceptbatch", method = RequestMethod.POST)
	@ResponseBody
	public R acceptbatch(@RequestBody List<Integer> ids) {
		for (Integer rescueId : ids) {
			Rescue rescue = rescueService.getById(rescueId);
			rescue.setVerify(1);
			rescueService.updateById(rescue);
		}
		return R.ok();
	}
	
	/**
	 * 删除
	 * @param deptId
	 * @return
	 */
	@RequestMapping("/delete/{rescueId}")
	@ResponseBody
	public R delete(@PathVariable Integer rescueId) {
		rescueService.removeById(rescueId);
		return R.ok();
	}
	
	/**
	 * 批量删除
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/deletebatch", method = RequestMethod.POST)
	@ResponseBody
	public R deletebatch(@RequestBody List<Integer> ids) {
		rescueService.removeByIds(ids);
		return R.ok();
	}
	
	@RequestMapping("/status")
	@ResponseBody
	public R status(Integer cityadoptId, Integer status) {
		Rescue rescue = rescueService.getById(cityadoptId);
		if(rescue.getVerify() == 0) {
			return R.error("审核中...");
		}
		else {
			rescue.setStatus(status);
			rescueService.updateById(rescue);
			return R.ok();
		}
	}
}
