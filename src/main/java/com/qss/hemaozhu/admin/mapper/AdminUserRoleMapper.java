package com.qss.hemaozhu.admin.mapper;

import com.qss.hemaozhu.admin.entity.AdminUserRole;

import java.util.List;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * <p>
 * 用户与角色对应关系 Mapper 接口
 * </p>
 *
 * @author qss
 * @since 2020-03-10
 */
public interface AdminUserRoleMapper extends BaseMapper<AdminUserRole> {

	/**
     * 通过用户id查询用户拥有的的角色信息
     * 使用左外连接查询，用户未分配的角色信息一并显示出来
     * @param userId
     * @return
     */
	List<AdminUserRole> selectByUserId(Integer userId);

}
