package com.qss.hemaozhu.fore.controller;


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
import com.qss.hemaozhu.fore.entity.Users;
import com.qss.hemaozhu.fore.entity.Voluteer;
import com.qss.hemaozhu.fore.service.IUsersService;
import com.qss.hemaozhu.fore.service.IVoluteerService;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author qss
 * @since 2020-04-05
 */
@Controller
@RequestMapping("/fore/vol")
public class VoluteerController {
	
	@Autowired
	private IVoluteerService volService;
	
	@Autowired
	private IDeptService deptService;
	
	@Autowired
	private IUsersService userService;
	
	@RequestMapping("/vol")
	public String list() {
		return "admin/users/voluteer/vol_list";
	}
	
	@RequestMapping("/data")
	@ResponseBody
	public R data(String realname, Page<Voluteer> page) {
		QueryWrapper<Voluteer> param = new QueryWrapper<>();
		if(!StringUtils.isEmpty(realname)) {
			param.like("realname", realname);
		}
		param.orderByAsc("vol_id");
		page = volService.page(page, param);
		return R.ok(page);
	}
	
	@RequestMapping("/add/{userId}")
	public String add(@PathVariable Integer userId, Model model) {
		model.addAttribute("userId", userId);
		QueryWrapper<Dept> param = new QueryWrapper<>();
		param.ne("type", 1);
		model.addAttribute("deptlist", deptService.list(param));
		return "fore/voluteer/vol_add";
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public R add(Voluteer vol) {
		volService.save(vol);
		Users user = userService.getById(vol.getUserId());
		user.setIsvol(1);
		userService.updateVol(user);
		return R.ok();
	}
	
	@RequestMapping("/info/{volId}")
	public String info(@PathVariable Integer volId, Model model) {
		model.addAttribute("vol", volService.getById(volId));
		model.addAttribute("deptlist", deptService.list());
		return "admin/users/voluteer/vol_info";
	}
	
	@RequestMapping("/update/{volId}")
	public String update(@PathVariable Integer volId, Model model) {
		model.addAttribute("vol", volService.getById(volId));
		QueryWrapper<Dept> param = new QueryWrapper<>();
		param.ne("type", 1);
		model.addAttribute("deptlist", deptService.list(param));
		return "admin/users/voluteer/vol_update";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public R update(Voluteer vol) {
		volService.updateById(vol);
		return R.ok();
	}
	
	/**
	 * 删除
	 * @param deptId
	 * @return
	 */
	@RequestMapping("/delete/{volId}")
	@ResponseBody
	public R delete(@PathVariable Integer volId) {
		Users user = userService.getById(volService.getById(volId).getUserId());
		user.setIsvol(0);
		userService.updateVol(user);
		volService.removeById(volId);
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
		for (Integer id : ids) {
			Users user = userService.getById(volService.getById(id).getUserId());
			user.setIsvol(0);
			userService.updateVol(user);
		}
		volService.removeByIds(ids);
		return R.ok();
	}
}
