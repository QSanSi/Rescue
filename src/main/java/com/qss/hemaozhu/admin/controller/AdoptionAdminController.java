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
import com.qss.hemaozhu.admin.service.IDeptService;
import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.common.service.FileService;
import com.qss.hemaozhu.fore.entity.Adoption;
import com.qss.hemaozhu.fore.entity.Pet;
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
@RequestMapping("/admin/adopt")
public class AdoptionAdminController {
	@Autowired
	private IAdoptionService adoptService;
	@Autowired
	private IDeptService deptService;
	@Autowired
	private IPetService petService;
	@Autowired
	private FileService fileService;
	
	@RequestMapping("/adopt")
	public String list() {
		return "admin/article/adopt/adopt_list";
	}
	
	@RequestMapping("/data")
	@ResponseBody
	public R data(Integer deptId, String title, Page<Adoption> page) {
		QueryWrapper<Adoption> param = new QueryWrapper<>();
		if(deptId != 1) {
			param.eq("dept_id", deptId);
		}
		if(!StringUtils.isEmpty(title)) {
			param.like("title", title);
		}
		param.orderByDesc("update_time");
		page = adoptService.page(page, param);
		return R.ok(page);
	}
	
	@RequestMapping("/add/{deptId}")
	public String add(@PathVariable Integer deptId, Model model) {
		QueryWrapper<Pet> p = new QueryWrapper<>();
		p.ne("status", 1);
		if(deptId != 1) {
			p.eq("dept_id", deptId);
		}
		model.addAttribute("petlist", petService.list(p));
		return "admin/article/adopt/adopt_add";
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public R add(Adoption adopt) {
		adoptService.save(adopt);
		return R.ok();
	}
	
	@RequestMapping("/info/{adoptId}")
	public String info(@PathVariable Integer adoptId, Model model) {
		Adoption adopt = adoptService.getById(adoptId);
		model.addAttribute("dept", deptService.getById(adopt.getDeptId()));
		model.addAttribute("pet", petService.getById(adopt.getPetId()));
		model.addAttribute("adopt", adopt);
		return "admin/article/adopt/adopt_info";
	}
	
	@RequestMapping("/update/{adoptId}/{deptId}")
	public String update(@PathVariable Integer adoptId, @PathVariable Integer deptId, Model model) {
		QueryWrapper<Pet> p = new QueryWrapper<>();
		if(deptId != 1) {
			p.eq("dept_id", deptId);
		}
		model.addAttribute("petlist", petService.list(p));
		model.addAttribute("adopt", adoptService.getById(adoptId));
		return "admin/article/adopt/adopt_update";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public R update(Adoption adopt) {
		adoptService.updateById(adopt);
		return R.ok();
	}
	
	/**
	 * 删除
	 * @param deptId
	 * @return
	 */
	@RequestMapping("/delete/{adoptId}")
	@ResponseBody
	public R delete(@PathVariable Integer adoptId) {
		adoptService.removeById(adoptId);
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
		adoptService.removeByIds(ids);
		return R.ok();
	}
	
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	@ResponseBody
	public R upload(@RequestParam(value="file") MultipartFile file) {
		try {
			String src = fileService.uploadadopt(file);
			return R.ok()
					.put("url", src);
		} catch (IOException e) {
			e.printStackTrace();
			return R.error("上传失败");
		}
	}
}
