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
import com.qss.hemaozhu.fore.entity.Rescue;
import com.qss.hemaozhu.fore.entity.Users;
import com.qss.hemaozhu.fore.service.IRescueService;
import com.qss.hemaozhu.fore.service.IUsersService;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author qss
 * @since 2020-04-14
 */
@Controller
@RequestMapping("/fore/rescue")
public class RescueController {
	
	@Autowired
	private IUsersService userService;
	@Autowired
	private IRescueService rescueService;
	@Autowired
	private FileService fileService;
	
	@RequestMapping("/list/{userId}")
	public String list(@PathVariable Integer userId) {
		Users user = userService.getById(userId);
		if(user.getIsvol() == 1) {
			return "fore/resuce/rescue_list";
		}else {
			return "redirect:/fore/vol/add/" + userId;
		}
	}
	
	@RequestMapping("/data")
	@ResponseBody
	public R data(Integer city, String title, Page<Rescue> page) {
		QueryWrapper<Rescue> param = new QueryWrapper<>();
		if(city != -1 && city != null) {
			param.eq("city", city);
		}
		if(!StringUtils.isEmpty(title)) {
			param.like("title", title);
		}
		param.eq("verify", 1);
		param.orderByDesc("create_time");
		page = rescueService.page(page, param);
		return R.ok(page)
				.put("current", page.getCurrent())
				.put("maxpage", page.getPages());
	}
	
	@RequestMapping("/find/{rescueId}")
	public String find(@PathVariable Integer rescueId, Model model) {
		Rescue rescue = rescueService.getById(rescueId);
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String createTime = sdf.format(rescue.getCreateTime());
		model.addAttribute("user", userService.getById(rescue.getUserId()));
		model.addAttribute("createTime", createTime);
		model.addAttribute("rescue", rescue);
		return "fore/resuce/rescue_details";
	}
	
	@RequestMapping("/add")
	public String add() {
		return "fore/resuce/rescue_add";
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public R add(Rescue rescue) {
		Boolean success = rescueService.save(rescue);
		if(success)
			return R.ok();
		else
			return R.error("该城市无我司分部，无法提供救助服务");
	}
	
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	@ResponseBody
	public R upload(@RequestParam(value="file") MultipartFile file) {
		try {
			String src = fileService.uploadrescue(file);
			return R.ok()
					.put("url", src);
		} catch (IOException e) {
			e.printStackTrace();
			return R.error("上传失败");
		}
	}
	
	@RequestMapping("/mine")
	public String mine() {
		return "fore/myarticle/my_rescue";
	}
	
	@RequestMapping("/minedata/{userId}")
	@ResponseBody
	public R minedata(@PathVariable Integer userId, String title, Page<Rescue> page) {
		QueryWrapper<Rescue> param = new QueryWrapper<>();
		param.eq("user_id", userId);
		if(!StringUtils.isEmpty(title)) {
			param.like("title", title);
		}
		param.orderByDesc("create_time");
		page = rescueService.page(page, param);
		return R.ok(page)
				.put("current", page.getCurrent())
				.put("maxpage", page.getPages());
	}
}
