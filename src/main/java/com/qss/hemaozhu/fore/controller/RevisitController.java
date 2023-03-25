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
import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.fore.entity.Contract;
import com.qss.hemaozhu.fore.entity.Revisit;
import com.qss.hemaozhu.fore.service.IContractService;
import com.qss.hemaozhu.fore.service.IRevisitService;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author qss
 * @since 2020-04-05
 */
@Controller
@RequestMapping("/fore/revisit")
public class RevisitController {
	
	@Autowired
	private IRevisitService rvService;
	@Autowired
	private IContractService conService;
	
	@RequestMapping("/revisit")
	public String list() {
		return "admin/pet/revisit/revisit_list";
	}
	
	@RequestMapping("/data")
	@ResponseBody
	public R data(Integer deptId, String master, Page<Revisit> page) {
		QueryWrapper<Revisit> param = new QueryWrapper<>();
		QueryWrapper<Contract> p = new QueryWrapper<>();
		if(!StringUtils.isEmpty(master)) {
			p.like("master", master);
			List<Contract> conlist = conService.list(p);
			if(!conlist.isEmpty()) {
				for (Contract con : conlist) {
					param.eq("contract_id", con.getContractId());
				}
			}
			else
				param.eq("contract_id", 0);
		}
		if(deptId != 1) {
			param.eq("dept_id", deptId);
		}
		param.orderByDesc("create_time");
		page = rvService.page(page, param);
		return R.ok(page);
	}
	
	@RequestMapping("/add/{deptId}")
	public String add(@PathVariable Integer deptId, Model model) {
		QueryWrapper<Contract> param = new QueryWrapper<>();
		param.eq("dept_id", deptId);
		model.addAttribute("conlist", conService.list(param));
		return "admin/pet/revisit/revisit_add";
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public R add(Revisit rv) {
		rvService.save(rv);
		return R.ok();
	}
	
	/**
	 * 删除
	 * @param deptId
	 * @return
	 */
	@RequestMapping("/delete/{revisitId}")
	@ResponseBody
	public R delete(@PathVariable Integer revisitId) {
		rvService.removeById(revisitId);
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
		rvService.removeByIds(ids);
		return R.ok();
	}
}
