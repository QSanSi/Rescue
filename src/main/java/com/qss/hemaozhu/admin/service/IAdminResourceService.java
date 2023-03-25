package com.qss.hemaozhu.admin.service;

import com.qss.hemaozhu.admin.entity.AdminResource;
import com.qss.hemaozhu.common.model.TreeNode;

import java.io.Serializable;
import java.util.Collection;

import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 菜单管理 服务类
 * </p>
 *
 * @author qss
 * @since 2020-03-10
 */
public interface IAdminResourceService extends IService<AdminResource> {
	
	/**
     * 通过id查询该节点的树形结构数据
     *
     * @param
     * @return
     */
	TreeNode getTreeById(Integer id);
	
	boolean save(AdminResource resource);
	
	boolean removeById(Serializable id);
	
	boolean removeByIds(Collection<? extends Serializable> idList);

}
