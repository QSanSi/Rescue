package com.qss.hemaozhu.fore.controller;


import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
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
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.fore.entity.Users;
import com.qss.hemaozhu.fore.service.IUsersService;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author qss
 * @since 2020-04-02
 */
@Controller
@RequestMapping("/fore/users")
public class UsersController {
	
	@Autowired
	private IUsersService userService;
	
	@RequestMapping(value = "/login")
	public String login() {
		return "fore/login";
	}
	
	@RequestMapping(value = "/userlogin", method = RequestMethod.POST)
	@ResponseBody
	public R userlogin(String username, String password) {
		UsernamePasswordToken token = new UsernamePasswordToken(username, password);
		Subject subject = SecurityUtils.getSubject();
		String msg = null;
		try {
			subject.login(token);
		} catch (UnknownAccountException e) {
			msg = "用户名不存在";
		} catch (AuthenticationException e) {
			msg = "密码错误";
		}
		if (msg != null) {// 出错了，返回登录页面
			return R.error(msg);
		} else {
			return R.ok();
		}
	}
	
	@RequestMapping(value = "/userlogout")
	public String logout() {
		// 销毁会话
		Subject subject = SecurityUtils.getSubject();
		subject.logout();
		return "fore/login";
	}
	
	@RequestMapping("/regist")
	public String regist() {
		return "fore/regist";
	}
	
	@RequestMapping(value = "/regist", method = RequestMethod.POST)
	@ResponseBody
	public R regist(Users user) {
		userService.save(user);
		return R.ok();
	}
	
	@RequestMapping("/user")
	public String list() {
		return "admin/users/user/user_list";
	}
	
	@RequestMapping("/data")
	@ResponseBody
	public R data(String username, Page<Users> page) {
        //1.构造查询条件构造器
		QueryWrapper<Users> param = new QueryWrapper<>();
        if (!StringUtils.isEmpty(username)) {
            param.like("username", username);
        }
        //2.分页查询
        userService.page(page, param);
        //3.返回分页数据
        return R.ok(page);
	}
	
	@RequestMapping("/update/{userId}")
	public String update(@PathVariable Integer userId, Model model) {
		model.addAttribute("user", userService.getById(userId));
		return "admin/users/user/user_update";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public R update(Users user) {
		userService.updateById(user);
		return R.ok();
	}
	
	@RequestMapping("/delete/{userId}")
	@ResponseBody
	public R delete(@PathVariable Integer userId) {
		userService.removeById(userId);
		return R.ok();
	}
	
	@RequestMapping(value = "/deletebatch", method = RequestMethod.POST)
	@ResponseBody
	public R deletebatch(@RequestBody List<Integer> ids) {
		userService.removeByIds(ids);
		return R.ok();
	}
	
	@RequestMapping(value = "/check", method = RequestMethod.POST)
	@ResponseBody
	public String checkUsername(@RequestParam String username) {
		String success = "false";
		QueryWrapper<Users> param = new QueryWrapper<>();
		param.eq("username", username);
		if(userService.count(param) == 0) {
			success = "true";
		}
		return success;
	}
	
	 @RequestMapping(value = "/checktel", method = RequestMethod.POST)
	 @ResponseBody
	 public String checkTel(@RequestParam String tel, @RequestParam(defaultValue = "0") Integer userId) {
	    String success = "false";
	    QueryWrapper<Users> param = new QueryWrapper<>();
	   	param.eq("tel", tel);
	   	param.ne("user_id", userId);
	   	if (userService.count(param) == 0) {
	   		success = "true";
    	}
		return success;
	 }
	 
	 @RequestMapping(value = "/checkemail", method = RequestMethod.POST)
	 @ResponseBody
	 public String checkEmail(@RequestParam String email, @RequestParam(defaultValue = "0") Integer userId) {
	   	String success = "false";
    	QueryWrapper<Users> param = new QueryWrapper<>();
	   	param.eq("email", email);
    	param.ne("user_id", userId);
	    if (userService.count(param) == 0) {
	    	success = "true";
	    }
		return success;
	 }	 
}
