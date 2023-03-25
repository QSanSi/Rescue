package com.qss.hemaozhu.admin.controller;


import java.util.List;


import org.apache.shiro.authz.annotation.RequiresPermissions;
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

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.qss.hemaozhu.admin.entity.AdminRole;
import com.qss.hemaozhu.admin.entity.AdminRoleResource;
import com.qss.hemaozhu.admin.service.IAdminRoleResourceService;
import com.qss.hemaozhu.admin.service.IAdminRoleService;
import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.common.model.TreeNode;
import com.qss.hemaozhu.common.service.CommonService;
/**
 * <p>
 * 角色 前端控制器
 * </p>
 *
 * @author qss
 * @since 2020-03-10
 */
@Controller
@RequestMapping("/sys/role")
public class AdminRoleController {
	@Autowired
    private IAdminRoleService roleService;

    @Autowired
    private IAdminRoleResourceService roleResourceService;
    
    @Autowired
    private CommonService commonService;

    /**
     * 跳转到列表
     *
     * @return
     */
    @RequestMapping("/role")
    @RequiresPermissions("sys:role:list")
    public String list() {
        return "admin/sys/role/role_list";
    }

    /**
     * 获取列表数据
     */
    @RequestMapping("/data")
    @ResponseBody
    @RequiresPermissions("sys:role:list")
    public R data(String roleName, Page<AdminRole> page, OrderItem order) {
    	//0.处理排序列名驼峰规则
    	page = commonService.handleOrder(page, order);
        //1.构造查询条件构造器
		QueryWrapper<AdminRole> queryWrapper = new QueryWrapper<>();
		if (!StringUtils.isEmpty(roleName)) {
			queryWrapper.like("name", roleName);
		}
        //2.分页查询
        roleService.page(page, queryWrapper);
        //3.返回分页数据
        return R.ok(page);
    }

    /**
     * 跳转到新增页面
     *
     * @return
     */
    @RequestMapping("/add")
    @RequiresPermissions("sys:role:add")
    public String add() {
        return "admin/sys/role/role_add";
    }

    /**
     * 新增
     *
     * @param role
     * @return
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("sys:role:add")
    public R add(AdminRole role) {
        roleService.save(role);
        return R.ok();
    }

    /**
     * 跳转到修改页面
     *
     * @param roleId
     * @param model
     * @return
     */
    @RequestMapping("/edit/{roleId}")
    @RequiresPermissions("sys:role:update")
    public String update(@PathVariable Integer roleId, Model model) {
        model.addAttribute("role", roleService.getById(roleId));
        return "admin/sys/role/role_edit";
    }

    /**
     * 更新数据
     *
     * @param role
     * @return
     */
    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("sys:role:update")
    public R update(AdminRole role) {
        roleService.updateById(role);
        return R.ok();
    }
    
    /**
     * 检查角色名是否以被使用
     * @param name
     * @param roleId
     * @return
     */
    @RequestMapping(value = "/checkname", method = RequestMethod.POST)
    @ResponseBody
    public String checkName(@RequestParam String name, @RequestParam(defaultValue = "0") Integer roleId) {
    	String success = "false";
    	QueryWrapper<AdminRole> param = new QueryWrapper<>();
    	param.eq("name", name);
    	param.ne("role_id", roleId);
    	if (roleService.count(param) == 0) {
    		success = "true";
    	}
		return success;
    }

    /**
     * 删除
     *
     * @param roleId
     * @return
     */
    @RequestMapping("/delete/{roleId}")
    @ResponseBody
    @RequiresPermissions("sys:role:delete")
    public R delete(@PathVariable Integer roleId) {
        roleService.removeById(roleId);
        return R.ok();
    }

    /**
     * 批量删除
     * @param ids
     * @return
     */
    @RequestMapping(value = "/deletebatch", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("sys:role:delete")
    public R deletebatch(@RequestBody List<Integer> ids) {
        roleService.removeByIds(ids);
        return R.ok();
    }

    /**
     * 跳转到给角色分配资源页面
     *
     * @param roleId
     * @return
     */
    @RequestMapping("/assign/resource/{roleId}")
    @RequiresPermissions("sys:role:assign:resource")
    public String assignResource(@PathVariable Integer roleId, Model model) {
        model.addAttribute("roleId", roleId);
        return "admin/sys/role/assign_resource";
    }

    /**
     * 获取选中资源菜单的数据
     *
     * @param roleId
     * @return
     */
    @RequestMapping("/assign/resourceTree/{roleId}")
    @ResponseBody
    @RequiresPermissions("sys:role:assign:resource")
    public R assignResourceTree(@PathVariable Integer roleId) {
        TreeNode treeNode = roleResourceService.getTreeByRoleId(roleId);
        return R.ok("请求成功", treeNode);
    }


    /**
     * 保存给角色分配的资源
     * @param roleId
     * @param roleResourceList
     * @return
     */
    @RequestMapping(value = "/assign/resource/{roleId}", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("sys:role:assign:resource")
    public R assignResource(@PathVariable Integer roleId, @RequestBody List<AdminRoleResource> roleResourceList) {
        roleResourceService.save(roleId, roleResourceList);
        return R.ok();
    }
}
