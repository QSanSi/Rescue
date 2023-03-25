package com.qss.hemaozhu.common.realm;


import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.CredentialsException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.realm.AuthenticatingRealm;
import org.springframework.beans.factory.annotation.Autowired;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.qss.hemaozhu.common.util.MD5Util;
import com.qss.hemaozhu.fore.entity.Users;
import com.qss.hemaozhu.fore.mapper.UsersMapper;

public class SecondRealm extends AuthenticatingRealm {

	@Autowired
	private UsersMapper userMapper;

	/**
	 * 登录认证
	 *
	 * @param authenticationToken
	 * @return
	 * @throws AuthenticationException
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken)
			throws AuthenticationException {
		UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;

		// 1.获取用户输入的用户名
		String username = token.getUsername();
		// 2.获取用户输入的密码
		String password = new String(token.getPassword());

		// 3.根据用户名去DB查询对应的用户信息
		QueryWrapper<Users> param = new QueryWrapper<>();
		param.eq("username", username);
		Users user = userMapper.selectOne(param);
		if (user == null) {
			throw new UnknownAccountException();
		}else {
			password = MD5Util.md5_private_salt(password, user.getSalt());
			 // 两个密码的密文进行比对
	        if (!user.getPassword().equals(password)) {
	            throw new CredentialsException("密码错误");
	        }
	        // 创建简单认证信息对象
			SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(user, token.getCredentials(), getName());
			return info;
		}
	}

}
