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
import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.fore.entity.Tips;
import com.qss.hemaozhu.fore.service.ITipsService;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author qss
 * @since 2020-04-16
 */
@Controller
@RequestMapping("/fore/tips")
public class TipsController {
	@Autowired
	private ITipsService tipsService;
	
	@RequestMapping("/list")
	public String list() {
		return "fore/tips/tips_list";
	}
	
	@RequestMapping("/data")
	@ResponseBody
	public R data(String title, Page<Tips> page) {
		QueryWrapper<Tips> param = new QueryWrapper<>();
		if(!StringUtils.isEmpty(title)) {
			param.like("title", title);
		}
		param.orderByDesc("create_time");
		page = tipsService.page(page, param);
		return R.ok(page)
				.put("current", page.getCurrent())
				.put("maxpage", page.getPages());
	}
	
	@RequestMapping("/find/{tipsId}")
	public String find(@PathVariable Integer tipsId, Model model) {
		Tips tips = tipsService.getById(tipsId);
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime = sdf.format(tips.getUpdateTime());
		model.addAttribute("updateTime", updatetime);
		model.addAttribute("tips", tips);
		return "fore/tips/tips_details";
	}
}
