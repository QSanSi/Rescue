package com.qss.hemaozhu.admin.controller;


import java.io.IOException;
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
import com.qss.hemaozhu.common.service.FileService;
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
@RequestMapping("/admin/tips")
public class TipsAdminController {
	@Autowired
	private ITipsService tipsService;
	@Autowired
	private FileService fileService;
	
	@RequestMapping("/tips")
	public String list() {
		return "admin/article/tips/tips_list";
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
		return R.ok(page);
	}
	
	@RequestMapping("/add")
	public String add() {
		return "admin/article/tips/tips_add";
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public R add(Tips tips) {
		tipsService.save(tips);
		return R.ok();
	}
	
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	@ResponseBody
	public R upload(@RequestParam(value="file") MultipartFile file) {
		try {
			String src = fileService.uploadtips(file);
			return R.ok()
					.put("url", src);
		} catch (IOException e) {
			e.printStackTrace();
			return R.error("上传失败");
		}
	}
	
	@RequestMapping("/update/{tipsId}")
	public String update(@PathVariable Integer tipsId, Model model) {
		model.addAttribute("tips", tipsService.getById(tipsId));
		return "admin/article/tips/tips_update";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public R update(Tips tips) {
		tipsService.updateById(tips);
		return R.ok();
	}
	
	/**
	 * 删除
	 * @param deptId
	 * @return
	 */
	@RequestMapping("/delete/{tipsId}")
	@ResponseBody
	public R delete(@PathVariable Integer tipsId) {
		tipsService.removeById(tipsId);
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
		tipsService.removeByIds(ids);
		return R.ok();
	}
}
