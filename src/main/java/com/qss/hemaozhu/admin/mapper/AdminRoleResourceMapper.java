package com.qss.hemaozhu.admin.mapper;

import com.qss.hemaozhu.admin.entity.AdminRoleResource;

import java.util.List;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author qss
 * @since 2020-03-10
 */
public interface AdminRoleResourceMapper extends BaseMapper<AdminRoleResource> {

	/**
     * 通过角色id查询角色拥有的的资源信息
     * 使用左外连接查询，角色未分配的资源信息一并显示出来
     * @param roleId
     * @return
     */
	List<AdminRoleResource> selectByRoleId(Integer roleId);

}
