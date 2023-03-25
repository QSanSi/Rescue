package com.qss.hemaozhu.admin.controller;


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

/**
 * <p>
 * 部门/站点信息 前端控制器S
 * </p>
 *
 * @author qss
 * @since 2020-03-20
 */
@Controller
@RequestMapping("/dept/info")
public class DeptController {
	
	@Autowired
	private IDeptService deptService;
	
	/**
	 * 跳转到列表页面
	 * @return
	 */
	@RequestMapping("/info")
	//@RequiresPermissions("dept:info:list")
	public String list() {
		return "admin/dept/site/site_list";
	}
	
	/**
	 * 获取数据列表
	 * @param deptName
	 * @param page
	 * @return
	 */
	@RequestMapping("/data")
	@ResponseBody
	//@RequiresPermissions("dept:info:list")
	public R data(String deptName, Page<Dept> page){
		QueryWrapper<Dept> param = new QueryWrapper<>();
		if(!StringUtils.isEmpty(deptName)) {
			param.like("dept_name", deptName);
		}
		param.orderByAsc("dept_id");
		// 查询满足条件的数据集
		page = deptService.page(page, param);
		return R.ok(page);
	}
	/**
	 * 跳转到其他信息页面
	 * @return
	 */
	@RequestMapping("/otherinfo/{deptId}")
	//@RequiresPermissions("dept:info:list")
	public String otherinfo(@PathVariable Integer deptId, Model model) {
		model.addAttribute("dept", deptService.getById(deptId));
		return "admin/dept/site/site_otherinfo";
	}
	
	/**
	 * 跳转到新增页面
	 * @return
	 */
	@RequestMapping("/add")
	public String add() {
		return "admin/dept/site/site_add";
	}
	
	/**
	 * 新增
	 * @param dept
	 * @return
	 */
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public R add(Dept dept) {
		deptService.save(dept);
		return R.ok();
	}
	
	/**
     * 跳转到修改页面
     *
     * @param roleId
     * @param model
     * @return
     */
	@RequestMapping("/edit/{deptId}")
	public String update(@PathVariable Integer deptId, Model model) {
		model.addAttribute("dept", deptService.getById(deptId));
		return "admin/dept/site/site_update";
	}
	
	/**
     * 更新数据
     *
     * @param role
     * @return
     */
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	@ResponseBody
	public R update(Dept dept) {
		deptService.updateById(dept);
		return R.ok();
	}
	
	/**
	 * 删除
	 * @param deptId
	 * @return
	 */
	@RequestMapping("/delete/{deptId}")
	@ResponseBody
	public R delete(@PathVariable Integer deptId) {
		deptService.removeById(deptId);
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
		deptService.removeByIds(ids);
		return R.ok();
	}
}
