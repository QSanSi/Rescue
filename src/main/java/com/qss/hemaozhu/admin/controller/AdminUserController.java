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
import com.qss.hemaozhu.admin.entity.AdminUser;
import com.qss.hemaozhu.admin.entity.AdminUserRole;
import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.admin.service.IAdminUserRoleService;
import com.qss.hemaozhu.admin.service.IAdminUserService;
import com.qss.hemaozhu.admin.service.IDeptService;

/**
 * <p>
 * 管理用户 前端控制器
 * </p>
 *
 * @author qss
 * @since 2020-03-10
 */
@Controller
@RequestMapping("/sys/admin")
public class AdminUserController {
	@Autowired
    private IAdminUserService userService;

    @Autowired
    private IAdminUserRoleService userRoleService;
    
    @Autowired
    private IDeptService deptService;
    
    /**
     * 跳转到列表页面
     *
     * @return
     */
    @RequestMapping("/admin")
    @RequiresPermissions("sys:user:list")
    public String list() {
        return "admin/sys/admin/admin_list";
    }
    
    /**
     * 获取列表数据
     *
     * @param username
     * @return
     */
    @RequestMapping("/data")
    @ResponseBody
    @RequiresPermissions("sys:user:list")
    public R data(String username) {
    	QueryWrapper<AdminUser> param = new QueryWrapper<>();
        if (!StringUtils.isEmpty(username)) {
            param.like("username", username);
        }
        // 查询满足条件的数据集
        List<AdminUser> rows = userService.getAdminUserList(param);
        // 查询满足条件的总记录数
        Integer total = userService.count(param);
        return R.ok()
                .put("count", total)
                .put("data", rows);
    }
    
    /**
     * 跳转到新增页面
     *
     * @return
     */
    @RequestMapping("/add")
    @RequiresPermissions("sys:user:add")
    public String add(Model model) {
    	model.addAttribute("deptlist", deptService.list());
        return "admin/sys/admin/admin_add";
    }

    /**
     * 新增
     *
     * @param user
     * @return
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("sys:user:add")
    public R add(AdminUser user) {
        userService.save(user);
        return R.ok();
    }
    
    /**
     * 检查用户名是否存在
     * @param username
     * @return
     */
    @RequestMapping(value = "/check", method = RequestMethod.POST)
    @ResponseBody
    public String checkUsername(@RequestParam String username) {
    	String success = "false";
    	QueryWrapper<AdminUser> param = new QueryWrapper<>();
    	param.eq("username", username);
    	AdminUser user = userService.getOne(param);
    	if(user == null) {
    		success = "true";
    	}
		return success;
    }
    
    /**
     * 检查手机是否已被使用
     * @param mobile
     * @param username
     * @return
     */
    @RequestMapping(value = "/checkmobile", method = RequestMethod.POST)
    @ResponseBody
    public String checkMobile(@RequestParam String mobile, @RequestParam(defaultValue = "0") Integer userId) {
    	String success = "false";
    	QueryWrapper<AdminUser> param = new QueryWrapper<>();
    	param.eq("mobile", mobile);
    	param.ne("user_id", userId);
    	if (userService.count(param) == 0) {
    		success = "true";
    	}
		return success;
    }
    
    /**
     * 检查邮箱是否已被使用
     * @param email
     * @param username
     * @return
     */
    @RequestMapping(value = "/checkemail", method = RequestMethod.POST)
    @ResponseBody
    public String checkEmail(@RequestParam String email, @RequestParam(defaultValue = "0") Integer userId) {
    	String success = "false";
    	QueryWrapper<AdminUser> param = new QueryWrapper<>();
    	param.eq("email", email);
    	param.ne("user_id", userId);
    	if (userService.count(param) == 0) {
    		success = "true";
    	}
		return success;
    }
    
    /**
     * 跳转到更新页面
     *
     * @return
     */
    @RequestMapping("/edit/{id}")
    @RequiresPermissions("sys:user:update")
    public String update(@PathVariable Integer id, Model model) {
        model.addAttribute("user", userService.getById(id));
        model.addAttribute("roleList", userRoleService.list(null));
        model.addAttribute("deptlist", deptService.list());
        return "admin/sys/admin/admin_edit";
    }
    
    /**
     * 更新
     *
     * @param user
     * @return
     */
    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("sys:user:update")
    public R update(AdminUser user) {
        userService.updateById(user);
        return R.ok();
    }
    
    /**
     * 删除
     *
     * @param id
     * @return
     */
    @RequestMapping("/delete/{id}")
    @ResponseBody
    @RequiresPermissions("sys:user:delete")
    public R delete(@PathVariable Integer id) {
        userService.removeById(id);
        return R.ok();
    }
    
    /**
     * 批量删除
     * @param ids
     * @return
     */
    @RequestMapping(value = "/deletebatch", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("sys:user:delete")
    public R deletebatch(@RequestBody List<Integer> ids) {
        userService.removeByIds(ids);
        return R.ok();
    }

    /**
     * 跳转到给用户分配角色的页面
     *
     * @param userId
     * @return
     */
    @RequestMapping("/assign/role/{userId}")
    @RequiresPermissions("sys:user:assign:role")
    public String assignRole(@PathVariable Integer userId, Model model) {
        List<AdminUserRole> userRoleList = userRoleService.getByUserId(userId);
        model.addAttribute("userRoleList", userRoleList);
        model.addAttribute("userId", userId);
        return "admin/sys/admin/assign_role";
    }

    /**
     * 给用户分配角色
     *
     * @param userId
     * @return
     */
    @RequestMapping(value = "/assign/role", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("sys:user:assign:role")
    public R assignRole(Integer userId, @RequestParam(value = "roleId",required = false) List<Integer> roleIdList) {
        userRoleService.save(userId,roleIdList);
        return R.ok();
    }
}
