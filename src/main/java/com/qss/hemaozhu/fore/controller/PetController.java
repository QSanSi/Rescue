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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.qss.hemaozhu.admin.entity.Dept;
import com.qss.hemaozhu.admin.service.IDeptService;
import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.fore.entity.Pet;
import com.qss.hemaozhu.fore.service.IPetService;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author qss
 * @since 2020-04-05
 */
@Controller
@RequestMapping("/fore/pet")
public class PetController {
	@Autowired
	private IPetService petService;
	@Autowired
	private IDeptService deptService;
	
	@RequestMapping("/pet")
	public String list() {
		return "admin/pet/pets/pet_list";
	}
	
	@RequestMapping("/data")
	@ResponseBody
	public R data(Integer deptId, String petname, Page<Pet> page) {
		QueryWrapper<Pet> param = new QueryWrapper<>();
		if(!StringUtils.isEmpty(petname)) {
			param.like("petname", petname);
		}
		if(deptId != 1) {
			param.eq("dept_id", deptId);
		}
		param.orderByAsc("pet_id");
		page = petService.page(page, param);
		return R.ok(page);
	}
	
	@RequestMapping("/toadd")
	public String add(Model model) {
		QueryWrapper<Dept> param = new QueryWrapper<>();
		param.ne("type", 1);
		model.addAttribute("deptlist", deptService.list(param));
		return "admin/pet/pets/pet_add";
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public R add(Pet pet, @RequestParam(value="file",required=false) MultipartFile file) {
		return petService.add(pet, file);
	}
	
	@RequestMapping("/info/{petId}")
	public String info(@PathVariable Integer petId, Model model) {
		QueryWrapper<Dept> param = new QueryWrapper<>();
		param.ne("type", 1);
		model.addAttribute("deptlist", deptService.list(param));
		model.addAttribute("pet", petService.getById(petId));
		return "admin/pet/pets/pet_info";
	}
	
	@RequestMapping("/update/{petId}")
	public String update(@PathVariable Integer petId, Model model) {
		QueryWrapper<Dept> param = new QueryWrapper<>();
		param.ne("type", 1);
		model.addAttribute("deptlist", deptService.list(param));
		model.addAttribute("pet", petService.getById(petId));
		return "admin/pet/pets/pet_update";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public R update(Pet pet, @RequestParam(value="file",required=false) MultipartFile file) {
		return petService.updateall(pet,file);
	}
	
	/**
	 * 删除
	 * @param deptId
	 * @return
	 */
	@RequestMapping("/delete/{petId}")
	@ResponseBody
	public R delete(@PathVariable Integer petId) {
		petService.removeById(petId);
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
		petService.removeByIds(ids);
		return R.ok();
	}
}
