package com.qss.hemaozhu.admin.service;

import com.qss.hemaozhu.admin.entity.AdminRoleResource;
import com.qss.hemaozhu.common.model.TreeNode;

import java.util.List;

import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author qss
 * @since 2020-03-10
 */
public interface IAdminRoleResourceService extends IService<AdminRoleResource> {

	TreeNode getTreeByRoleId(Integer roleId);

	boolean save(Integer roleId, List<AdminRoleResource> roleResourceList);

}
