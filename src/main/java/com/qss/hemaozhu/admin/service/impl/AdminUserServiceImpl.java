package com.qss.hemaozhu.admin.service.impl;

import com.qss.hemaozhu.admin.entity.AdminUser;
import com.qss.hemaozhu.admin.entity.AdminUserRole;
import com.qss.hemaozhu.admin.entity.Menu;
import com.qss.hemaozhu.common.exception.BizException;
import com.qss.hemaozhu.admin.mapper.AdminUserMapper;
import com.qss.hemaozhu.admin.mapper.AdminUserRoleMapper;
import com.qss.hemaozhu.admin.mapper.DeptMapper;
import com.qss.hemaozhu.common.model.TreeNode;
import com.qss.hemaozhu.admin.service.IAdminUserService;
import com.qss.hemaozhu.common.util.MD5Util;
import com.qss.hemaozhu.common.util.TreeUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

/**
 * <p>
 * 管理用户 服务实现类
 * </p>
 *
 * @author qss
 * @since 2020-03-10
 */
@Service
public class AdminUserServiceImpl extends ServiceImpl<AdminUserMapper, AdminUser> implements IAdminUserService {
	@Autowired
	private AdminUserMapper userMapper;

	@Autowired
	private AdminUserRoleMapper userRoleMapper;
	
	@Autowired
	private DeptMapper deptMapper;

	@Override
	public boolean save(AdminUser user) {
		String username = user.getUsername();
		String password = user.getPassword();
		String email = user.getEmail();
		String mobile = user.getMobile();
		// 校验用户名不能为空
		if (StringUtils.isEmpty(username)) {
			throw new BizException("用户名不能为空");
		}
		// 校验用户名不能为空
		if (StringUtils.isEmpty(password)) {
			throw new BizException("密码不能为空");
		}

		// 校验用户名是否被占用
		QueryWrapper<AdminUser> queryUsername = new QueryWrapper<>();
		queryUsername.eq("username", username);
		if (this.count(queryUsername) > 0) {
			throw new BizException("用户名已存在");
		}

		if (!StringUtils.isEmpty(mobile)) {
			QueryWrapper<AdminUser> queryMobile = new QueryWrapper<>();
			queryMobile.eq("mobile", user.getMobile());
			if (this.count(queryMobile) > 0) {
				throw new BizException("手机号已经被使用");
			}
		}

		if (!StringUtils.isEmpty(email)) {
			QueryWrapper<AdminUser> queryEmail = new QueryWrapper<>();
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
	public boolean updateById(AdminUser user) {
		String email = user.getEmail();
		String mobile = user.getMobile();

		// 不是当前用户使用了该手机号，表示手机号被占用
		if (!StringUtils.isEmpty(mobile)) {
			QueryWrapper<AdminUser> queryMobile = new QueryWrapper<>();
			queryMobile.eq("mobile", user.getMobile());
			queryMobile.ne("user_id", user.getUserId());
			if (this.count(queryMobile) > 0) {
				throw new BizException("手机号已经被使用");
			}
		}
		if (!StringUtils.isEmpty(email)) {
			QueryWrapper<AdminUser> queryEmail = new QueryWrapper<>();
			queryEmail.eq("email", user.getEmail());
			queryEmail.ne("user_id", user.getUserId());
			if (this.count(queryEmail) > 0) {
				throw new BizException("邮箱已经被使用");
			}
		}
		return super.updateById(user);
	}

	@Override
	@Transactional
	public boolean removeById(Serializable id) {
		// 删除用户已经分配的角色信息
		QueryWrapper<AdminUserRole> queryWrapper = new QueryWrapper<>();
		queryWrapper.eq("user_id", id);
		userRoleMapper.delete(queryWrapper);
		return super.removeById(id);
	}

	/**
	 * 获取用户的菜单树
	 * 
	 * @param id
	 * @return
	 */
	@Override
	public List<TreeNode> getMenuTreeByUserId(Integer id) {
		// 查询用户拥有的菜单资源
		List<Menu> menuList = userMapper.selectMenuList(id);
		if (menuList.isEmpty()) {
			return new ArrayList<>();
		}

		// 存储父id是0的节点的id
		List<Integer> nodeIds = new ArrayList<>();
		List<TreeNode> treeNodeList = new ArrayList<>();
		for (Menu menu : menuList) {
			TreeNode treeNode = new TreeNode();
			treeNode.setId(menu.getResourceId());
			treeNode.setName(menu.getName());
			treeNode.setParentId(menu.getParentId());
			treeNode.setUrl(menu.getUrl());
			treeNode.setIcon(menu.getIcon());
			treeNodeList.add(treeNode);
			if (treeNode.getParentId() == 0) {
				nodeIds.add(treeNode.getId());
			}
		}
		TreeUtil treeUtil = new TreeUtil(treeNodeList);
		List<TreeNode> treeNodeData = new ArrayList<>();
		for (Integer nodeId : nodeIds) {
			treeNodeData.add(treeUtil.generateTree(nodeId));
		}
		return treeNodeData;
	}

	/**
	 * 根据用户id联合查询用户信息
	 * 
	 * @param id
	 * @return
	 */
	@Override
	public List<AdminUser> getAdminUserList(QueryWrapper<AdminUser> param) {
		List<AdminUser> Adminuserlist = userMapper.selectList(param);
		if (Adminuserlist.isEmpty()) {
			return new ArrayList<>();
		}
		for (AdminUser user : Adminuserlist) {
			user.setDept(deptMapper.selectById(user.getDeptId()));
		}
		return Adminuserlist;
	}
}
