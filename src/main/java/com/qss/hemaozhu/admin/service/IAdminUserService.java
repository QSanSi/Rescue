package com.qss.hemaozhu.admin.service;

import com.qss.hemaozhu.admin.entity.AdminUser;
import com.qss.hemaozhu.common.model.TreeNode;

import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 管理用户 服务类
 * </p>
 *
 * @author qss
 * @since 2020-03-10
 */
public interface IAdminUserService extends IService<AdminUser> {
	
	/**
     * 根据用户id获取用户的菜单树
     * @param id
     * @return
     */
    List<TreeNode> getMenuTreeByUserId(Integer id);
    
    /**
     * 根据条件联合查询用户信息
     * @param param 
     * @param id
     * @return
     */
    List<AdminUser> getAdminUserList(QueryWrapper<AdminUser> param);
}
