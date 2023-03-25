package com.qss.hemaozhu.admin.service.impl;

import com.qss.hemaozhu.admin.entity.AdminRoleResource;
import com.qss.hemaozhu.admin.mapper.AdminRoleResourceMapper;
import com.qss.hemaozhu.admin.service.IAdminRoleResourceService;
import com.qss.hemaozhu.common.model.TreeNode;
import com.qss.hemaozhu.common.util.TreeUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author qss
 * @since 2020-03-10
 */
@Service
public class AdminRoleResourceServiceImpl extends ServiceImpl<AdminRoleResourceMapper, AdminRoleResource> implements IAdminRoleResourceService {
	
	@Autowired
    private AdminRoleResourceMapper roleResourceMapper;

	@Override
	public TreeNode getTreeByRoleId(Integer roleId) {
		//1.获取角色拥有的资源列表
        List<AdminRoleResource> list = roleResourceMapper.selectByRoleId(roleId);

        //2.对象数据转换
        List<TreeNode> treeNodeList = new ArrayList<>();
        for (AdminRoleResource rr : list) {
            TreeNode treeNode = new TreeNode();
            treeNode.setId(rr.getResourceId());
            treeNode.setParentId(rr.getParentId());
            treeNode.setName(rr.getName());
            // 设置节点的选中状态
            Map<String, Boolean> state = new HashMap<>();
            if (rr.getRoleId() == null) {
                state.put("checked", false);
            } else {
                state.put("checked", true);
            }
            treeNode.setState(state);
            treeNodeList.add(treeNode);
        }
        // 3.生成菜单树
        TreeUtil treeUtil = new TreeUtil(treeNodeList);
        TreeNode treeNode = treeUtil.generateTree(0);
        return treeNode;
	}

	@Override
	@Transactional
	public boolean save(Integer roleId, List<AdminRoleResource> roleResourceList) {
		//1.删除该角色已经分配的资源
        QueryWrapper<AdminRoleResource> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("role_id",roleId);
        this.remove(queryWrapper);

        //2.保存新分配的资源到sys_role_resource
        this.saveBatch(roleResourceList);
        return true;
	}

}
