package com.qss.hemaozhu.admin.service;

import com.qss.hemaozhu.admin.entity.AdminUserRole;

import java.util.List;

import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 用户与角色对应关系 服务类
 * </p>
 *
 * @author qss
 * @since 2020-03-10
 */
public interface IAdminUserRoleService extends IService<AdminUserRole> {
	
	/**
     * 根据用户id查询用户拥有的角色
     * @param userId
     * @return
     */
    List<AdminUserRole> getByUserId(Integer userId);

    /**
     * 保存给当前用户分配的角色
     * @param userId
     * @param roleIdList
     * @return
     */
    boolean save(Integer userId,List<Integer> roleIdList);
}
