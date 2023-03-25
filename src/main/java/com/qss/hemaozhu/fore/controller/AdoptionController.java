package com.qss.hemaozhu.fore.controller;


import java.text.SimpleDateFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.qss.hemaozhu.admin.entity.Dept;
import com.qss.hemaozhu.admin.service.IDeptService;
import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.fore.entity.Adoption;
import com.qss.hemaozhu.fore.service.IAdoptionService;
import com.qss.hemaozhu.fore.service.IPetService;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author qss
 * @since 2020-04-10
 */
@Controller
@RequestMapping("/fore/adopt")
public class AdoptionController {
	@Autowired
	private IAdoptionService adoptService;
	@Autowired
	private IDeptService deptService;
	@Autowired
	private IPetService petService;
	
	@RequestMapping("/list")
	public String list(Model model) {
		QueryWrapper<Dept> param = new QueryWrapper<>();
		param.ne("type", 1);
		model.addAttribute("deptlist", deptService.list(param));
		return "fore/adopt/adopt_list";
	}
	
	@RequestMapping("/data")
	@ResponseBody
	public R data(Integer deptId, String title, Page<Adoption> page) {
		QueryWrapper<Adoption> param = new QueryWrapper<>();
		if(deptId != -1 && deptId != null) {
			param.eq("dept_id", deptId);
		}
		if(!StringUtils.isEmpty(title)) {
			param.like("title", title);
		}
		param.orderByDesc("create_time");
		page = adoptService.page(page, param);
		return R.ok(page)
				.put("current", page.getCurrent())
				.put("maxpage", page.getPages());
	}
	
	@RequestMapping("/find/{adoptId}")
	public String find(@PathVariable Integer adoptId, Model model) {
		Adoption adopt = adoptService.getById(adoptId);
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String createTime = sdf.format(adopt.getCreateTime());
		model.addAttribute("dept", deptService.getById(adopt.getDeptId()));
		model.addAttribute("pet", petService.getById(adopt.getPetId()));
		model.addAttribute("createTime", createTime);
		model.addAttribute("adopt", adopt);
		return "fore/adopt/adopt_details";
	}
	
}
