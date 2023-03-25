package com.qss.hemaozhu.admin.controller;

import java.util.HashMap;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qss.hemaozhu.admin.entity.AdminUser;
import com.qss.hemaozhu.common.model.TreeNode;
import com.qss.hemaozhu.admin.service.IAdminUserService;

@Controller
@RequestMapping(value = "/page")
public class PageController {
	
	@Autowired
	private IAdminUserService userService;
	
	/**
     * 跳转到系统初始化页面
     * @return
     */
    @RequestMapping("/index")
    @RequiresAuthentication
    public String index(){
        return "admin/index";
    }
    
    /**
     * 主页
     * @return
     */
    @RequestMapping("/home")
    public String home() {
    	return "admin/home";
    }
    
    /**
     * 空白页
     * @return
     */
    @RequestMapping("/emptypage")
    public String emptypage(){
        return "include/emptypage";
    }
    
    /**
     * 获取资源菜单树
     * @return
     */
    @RequestMapping("/menu")
    @ResponseBody
    public HashMap<String, Object> menu(){
    	HashMap<String, Object> tree_menu = new HashMap<String, Object>();
        Subject subject = SecurityUtils.getSubject();
        AdminUser user = (AdminUser) subject.getPrincipal();
        List<TreeNode> treeNodeList  = userService.getMenuTreeByUserId(user.getUserId());
        tree_menu.put("data",treeNodeList);
        return tree_menu;
    }
    
    @RequestMapping("/foreindex")
    public String foreindex() {
    	return "fore/index";
    }
    
    @RequestMapping("/forehome")
    public String forehome() {
    	return "fore/home";
    }
}
