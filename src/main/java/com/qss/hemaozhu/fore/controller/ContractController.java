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
import com.qss.hemaozhu.admin.service.IDeptService;
import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.fore.entity.Contract;
import com.qss.hemaozhu.fore.entity.Pet;
import com.qss.hemaozhu.fore.service.IContractService;
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
@RequestMapping("/fore/contract")
public class ContractController {
	@Autowired
	private IContractService conService;
	
	@Autowired
	private IDeptService deptService;
	
	@Autowired
	private IPetService petService;
	
	@RequestMapping("/contract")
	public String list() {
		return "admin/pet/contract/contract_list";
	}
	
	@RequestMapping("/data")
	@ResponseBody
	public R data(Integer deptId, String master, Page<Contract> page) {
		QueryWrapper<Contract> param = new QueryWrapper<>();
		if(!StringUtils.isEmpty(master)) {
			param.like("master", master);
		}
		if(deptId != 1) {
			param.eq("dept_id", deptId);
		}
		param.orderByDesc("create_time");
		page = conService.page(page, param);
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
		return "admin/pet/contract/contract_add";
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public R add(Contract contract, @RequestParam(value="file1",required=false) MultipartFile file1
			, @RequestParam(value="file2",required=false) MultipartFile file2) {
		return conService.add(contract, file1, file2);
	}
	
	@RequestMapping("/info/{contractId}")
	public String info(@PathVariable Integer contractId, Model model) {
		Contract con = conService.getById(contractId);
		model.addAttribute("dept", deptService.getById(con.getDeptId()));
		model.addAttribute("petlist", petService.list());
		model.addAttribute("con", conService.getById(contractId));
		return "admin/pet/contract/contract_info";
	}
	
	@RequestMapping("/update/{contractId}/{deptId}")
	public String update(@PathVariable Integer contractId, @PathVariable Integer deptId, Model model) {
		QueryWrapper<Pet> p = new QueryWrapper<>();
		if(deptId != 1) {
			p.eq("dept_id", deptId);
		}
		model.addAttribute("petlist", petService.list(p));
		model.addAttribute("con", conService.getById(contractId));
		return "admin/pet/contract/contract_update";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public R update(Contract con, @RequestParam(value="file",required=false) MultipartFile file1
			, @RequestParam(value="file2",required=false) MultipartFile file2) {
		return conService.updateall(con,file1,file2);
	}
	
	/**
	 * 删除
	 * @param deptId
	 * @return
	 */
	@RequestMapping("/delete/{contractId}")
	@ResponseBody
	public R delete(@PathVariable Integer contractId) {
		conService.removeById(contractId);
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
		conService.removeByIds(ids);
		return R.ok();
	}
}
