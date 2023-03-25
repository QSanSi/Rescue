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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.fore.entity.Cityadopt;
import com.qss.hemaozhu.fore.service.ICityadoptService;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author qss
 * @since 2020-04-12
 */
@Controller
@RequestMapping("/admin/cityadopt")
public class CityadoptAdminController {
	@Autowired
	private ICityadoptService cdService;
	
	@RequestMapping("/cityadopt")
	public String list() {
		return "admin/article/cityadopt/cityadopt_list";
	}
	
	@RequestMapping("/data")
	@ResponseBody
	public R data(String title, Page<Cityadopt> page) {
		QueryWrapper<Cityadopt> param = new QueryWrapper<>();
		if(!StringUtils.isEmpty(title)) {
			param.like("title", title);
		}
		param.orderByAsc("verify");
		param.orderByDesc("create_time");
		page = cdService.page(page, param);
		return R.ok(page);
	}
	
	@RequestMapping("/update/{cityadoptId}")
	public String update(@PathVariable Integer cityadoptId, Model model) {
		model.addAttribute("cd", cdService.getById(cityadoptId));
		return "admin/article/cityadopt/cityadopt_update";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public R update(Cityadopt cd, @RequestParam(value="file",required=false) MultipartFile file) {
		return cdService.updateallById(cd, file);
	}
	
	@RequestMapping("/accept/{cityadoptId}")
	@ResponseBody
	public R accept(@PathVariable Integer cityadoptId) {
		Cityadopt cd = cdService.getById(cityadoptId);
		cd.setVerify(1);
		cdService.updateById(cd);
		return R.ok();
	}
	
	@RequestMapping(value = "/acceptbatch", method = RequestMethod.POST)
	@ResponseBody
	public R acceptbatch(@RequestBody List<Integer> ids) {
		for (Integer cityadoptId : ids) {
			Cityadopt cd = cdService.getById(cityadoptId);
			cd.setVerify(1);
			cdService.updateById(cd);
		}
		return R.ok();
	}
	
	/**
	 * 删除
	 * @param deptId
	 * @return
	 */
	@RequestMapping("/delete/{cityadoptId}")
	@ResponseBody
	public R delete(@PathVariable Integer cityadoptId) {
		cdService.removeById(cityadoptId);
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
		cdService.removeByIds(ids);
		return R.ok();
	}
	
}
