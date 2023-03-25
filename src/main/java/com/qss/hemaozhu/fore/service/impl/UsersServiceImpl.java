package com.qss.hemaozhu.fore.service.impl;

import com.qss.hemaozhu.common.exception.BizException;
import com.qss.hemaozhu.common.util.MD5Util;
import com.qss.hemaozhu.fore.entity.Users;
import com.qss.hemaozhu.fore.mapper.UsersMapper;
import com.qss.hemaozhu.fore.service.IUsersService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author qss
 * @since 2020-04-02
 */
@Service
public class UsersServiceImpl extends ServiceImpl<UsersMapper, Users> implements IUsersService {

	@Override
	public boolean updateById(Users user) {
		String password = user.getPassword();
		String email = user.getEmail();
		String tel = user.getTel();
		// 校验用户名不能为空
		if (StringUtils.isEmpty(password)) {
			throw new BizException("密码不能为空");
		}
		if (!StringUtils.isEmpty(tel)) {
			QueryWrapper<Users> queryMobile = new QueryWrapper<>();
			queryMobile.eq("tel", user.getTel());
			queryMobile.ne("user_id", user.getUserId());
			if (this.count(queryMobile) > 0) {
				throw new BizException("手机号已经被使用");
			}
		}
		if (!StringUtils.isEmpty(email)) {
			QueryWrapper<Users> queryEmail = new QueryWrapper<>();
			queryEmail.eq("email", user.getEmail());
			queryEmail.ne("user_id", user.getUserId());
			if (this.count(queryEmail) > 0) {
				throw new BizException("邮箱已经被使用");
			}
		}
		String salt = UUID.randomUUID().toString().toUpperCase().replace("-", "");
		password = MD5Util.md5_private_salt(password, salt);
		user.setPassword(password);
		user.setSalt(salt);
		return super.updateById(user);
	}

	@Override
	public boolean save(Users user) {
		String username = user.getUsername();
		String password = user.getPassword();
		String email = user.getEmail();
		String tel = user.getTel();
		// 校验用户名不能为空
		if (StringUtils.isEmpty(username)) {
			throw new BizException("用户名不能为空");
		}
		// 校验用户名不能为空
		if (StringUtils.isEmpty(password)) {
			throw new BizException("密码不能为空");
		}

		// 校验用户名是否被占用
		QueryWrapper<Users> queryUsername = new QueryWrapper<>();
		queryUsername.eq("username", username);
		if (this.count(queryUsername) > 0) {
			throw new BizException("用户名已存在");
		}

		if (!StringUtils.isEmpty(tel)) {
			QueryWrapper<Users> queryMobile = new QueryWrapper<>();
			queryMobile.eq("tel", user.getTel());
			if (this.count(queryMobile) > 0) {
				throw new BizException("手机号已经被使用");
			}
		}

		if (!StringUtils.isEmpty(email)) {
			QueryWrapper<Users> queryEmail = new QueryWrapper<>();
			queryEmail.eq("email", user.getEmail());
			if (this.count(queryEmail) > 0) {
				throw new BizException("邮箱已经被使用");
			}
		}

		String salt = UUID.randomUUID().toString().toUpperCase().replace("-", "");
		password = MD5Util.md5_private_salt(password, salt);
		user.setPassword(password);
		user.setSalt(salt);
		return super.save(user);
	}
	
	@Override
	public boolean updateVol(Users user) {
		return super.updateById(user);
	}
}
