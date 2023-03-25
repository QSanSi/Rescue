package com.qss.hemaozhu.fore.controller;


import java.io.IOException;
import java.text.SimpleDateFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.common.service.FileService;
import com.qss.hemaozhu.fore.entity.Cityadopt;
import com.qss.hemaozhu.fore.service.ICityadoptService;
import com.qss.hemaozhu.fore.service.IUsersService;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author qss
 * @since 2020-04-12
 */
@Controller
@RequestMapping("/fore/cityadopt")
public class CityadoptController {
	@Autowired
	private ICityadoptService cdService;
	@Autowired
	private IUsersService userService;
	@Autowired
	private FileService fileService;

	@RequestMapping("/list")
	public String list() {
		return "fore/cityadopt/cityadopt_list";
	}
	
	@RequestMapping("/data")
	@ResponseBody
	public R data(Integer city, String title, Page<Cityadopt> page) {
		QueryWrapper<Cityadopt> param = new QueryWrapper<>();
		if(city != -1 && city != null) {
			param.eq("city", city);
		}
		if(!StringUtils.isEmpty(title)) {
			param.like("title", title);
		}
		param.eq("verify", 1);
		param.orderByDesc("create_time");
		page = cdService.page(page, param);
		return R.ok(page)
				.put("current", page.getCurrent())
				.put("maxpage", page.getPages());
	}
	
	@RequestMapping("/find/{cityadoptId}")
	public String find(@PathVariable Integer cityadoptId, Model model) {
		Cityadopt cd = cdService.getById(cityadoptId);
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String createTime = sdf.format(cd.getCreateTime());
		model.addAttribute("user", userService.getById(cd.getUserId()));
		model.addAttribute("createTime", createTime);
		model.addAttribute("cd", cd);
		return "fore/cityadopt/cityadopt_details";
	}
	
	@RequestMapping("/add")
	public String add() {
		return "fore/cityadopt/cityadopt_add";
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public R add(Cityadopt cd, @RequestParam(value="file",required=false) MultipartFile file) {
		return cdService.add(cd, file);
	}
	
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	@ResponseBody
	public R upload(@RequestParam(value="file") MultipartFile file) {
		try {
			String src = fileService.uploadcityadopt(file);
			return R.ok()
					.put("url", src);
		} catch (IOException e) {
			e.printStackTrace();
			return R.error("上传失败");
		}
	}
	
	@RequestMapping("/mine")
	public String mine() {
		return "fore/myarticle/my_cityadopt";
	}
	
	@RequestMapping("/minedata/{userId}")
	@ResponseBody
	public R minedata(@PathVariable Integer userId, String title, Page<Cityadopt> page) {
		QueryWrapper<Cityadopt> param = new QueryWrapper<>();
		param.eq("user_id", userId);
		if(!StringUtils.isEmpty(title)) {
			param.like("title", title);
		}
		param.orderByDesc("create_time");
		page = cdService.page(page, param);
		return R.ok(page)
				.put("current", page.getCurrent())
				.put("maxpage", page.getPages());
	}
	
	@RequestMapping("/status")
	@ResponseBody
	public R status(Integer cityadoptId, Integer status) {
		Cityadopt cd = cdService.getById(cityadoptId);
		if(cd.getVerify() == 0) {
			return R.error("审核中...");
		}
		else {
			cd.setStatus(status);
			cdService.updateById(cd);
			return R.ok();
		}
	}
}
