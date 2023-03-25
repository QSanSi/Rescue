package com.qss.hemaozhu.admin.controller;


import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.qss.hemaozhu.admin.entity.AdminResource;
import com.qss.hemaozhu.admin.service.IAdminResourceService;
import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.common.model.TreeNode;
/**
 * <p>
 * 菜单管理 前端控制器
 * </p>
 *
 * @author qss
 * @since 2020-03-10
 */
@Controller
@RequestMapping("/sys/resource")
public class AdminResourceController {
	@Autowired
    private IAdminResourceService resourceService;

    /**
     * 跳转到资源管理的初始化页面
     * @return
     */
    @RequestMapping("/resource")
    public String index(@RequestParam(defaultValue = "0") Integer parentId,Model model) {
        model.addAttribute("parentId",parentId);
        return "admin/sys/resource/resource_index";
    }

    /**
     * 获取左侧菜单树
     * @return
     */
    @RequestMapping("/tree")
    @ResponseBody
    @RequiresPermissions("sys:resource:list")
    public R tree() {
        TreeNode treeNode = resourceService.getTreeById(0);
        return R.ok("请求成功", treeNode);
    }

    /**
     * 跳转到资源列表页面
     * @return
     */
    @RequestMapping("/list")
    @RequiresPermissions("sys:resource:list")
    public String list(@RequestParam(defaultValue = "0") Integer parentId,Model model){
        // 查询出父节点的详细信息传递给resource_list.jsp
        AdminResource parent = resourceService.getById(parentId);
        model.addAttribute("parent",parent);
        return "admin/sys/resource/resource_list";
    }

    /**
     * 获取列表数据
     * @param parentId
     * @param page
     * @return
     */
    @RequestMapping("/data")
    @ResponseBody
    @RequiresPermissions("sys:resource:list")
    public R data(@RequestParam(defaultValue = "0") Integer parentId, Page<AdminResource> page){
        QueryWrapper<AdminResource> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("parent_id",parentId);
        queryWrapper.orderByAsc("order_num");
        resourceService.page(page,queryWrapper);
        return R.ok(page);
    }

    /**
     * 跳转到新增资源页面
     * @param parentId
     * @return
     */
    @RequestMapping("/add/{parentId}")
    @RequiresPermissions("sys:resource:add")
    public String add(@PathVariable Integer parentId,Model model){
        model.addAttribute("parent",resourceService.getById(parentId));
        return "admin/sys/resource/resource_add";
    }

    /**
     * 新增
     * @param resource
     * @return
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("sys:resource:add")
    public R add(AdminResource resource) {
        resourceService.save(resource);
        return R.ok();
    }

    /**
     * 跳转到修改页面
     * @param resourceId
     * @param model
     * @return
     */
    @RequestMapping("/update/{resourceId}")
    @RequiresPermissions("sys:resource:update")
    public String update(@PathVariable Integer resourceId,Model model) {
        // 查询当前资源
    	AdminResource resource = resourceService.getById(resourceId); 
    	if(resource.getIcon() != null && !resource.getIcon().equals("")) {
    		String[] icon = resource.getIcon().split("\\s+");
    		resource.setIcon(icon[1]);
    	}
        model.addAttribute("resource",resource);
        // 查询上级资源
        AdminResource parent = resourceService.getById(resource.getParentId());
        model.addAttribute("parent",parent);
        return "admin/sys/resource/resource_update";
    }

    /**
     * 更新数据
     * @param resource
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("sys:resource:update")
    public R update(AdminResource resource){
    	// 处理icon字符串
		String icon = resource.getIcon();
		if (icon.matches("^fa-(.*)")) {
			resource.setIcon("fa " + icon);
		} else if (icon.matches("^glyphicon-(.*)")) {
			resource.setIcon("glyphicon " + icon);
		}
        resourceService.updateById(resource);
        return R.ok();
    }

    /**
     * 删除资源
     * @param resourceId
     * @return
     */
    @RequestMapping("/delete/{resourceId}")
    @ResponseBody
    @RequiresPermissions("sys:resource:delete")
    public R delete(@PathVariable Integer resourceId){
        resourceService.removeById(resourceId);
        return R.ok();
    }

    /**
     * 批量删除
     * @param ids
     * @return
     */
    @RequestMapping(value = "/deletebatch", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("sys:resource:delete")
    public R deletebatch(@RequestBody List<Integer> ids) {
        resourceService.removeByIds(ids);
        return R.ok();
    }
}
