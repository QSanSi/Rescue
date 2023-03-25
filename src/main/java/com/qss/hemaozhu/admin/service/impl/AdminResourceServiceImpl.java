package com.qss.hemaozhu.admin.service.impl;

import com.qss.hemaozhu.admin.entity.AdminResource;
import com.qss.hemaozhu.admin.entity.AdminRoleResource;
import com.qss.hemaozhu.admin.mapper.AdminResourceMapper;
import com.qss.hemaozhu.admin.mapper.AdminRoleResourceMapper;
import com.qss.hemaozhu.admin.service.IAdminResourceService;
import com.qss.hemaozhu.common.exception.BizException;
import com.qss.hemaozhu.common.model.TreeNode;
import com.qss.hemaozhu.common.util.TreeUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

/**
 * <p>
 * 菜单管理 服务实现类
 * </p>
 *
 * @author qss
 * @since 2020-03-10
 */
@Service
public class AdminResourceServiceImpl extends ServiceImpl<AdminResourceMapper, AdminResource> implements IAdminResourceService {
	
	@Autowired
    private AdminRoleResourceMapper roleResourceMapper;

    /**
     * 通过id查询该节点的树形结构数据
     *
     * @param
     * @return
     */
	@Override
	public TreeNode getTreeById(Integer id) {
		AdminResource r = this.getById(id);
        //1.查询所有节点
        QueryWrapper<AdminResource> queryWrapper = new QueryWrapper<>();
        queryWrapper.likeRight("path", r.getPath());
        queryWrapper.orderByAsc("order_num");
        List<AdminResource> list = this.list(queryWrapper);

        //2.对象数据转换
        List<TreeNode> treeNodeList = new ArrayList<>();
        for (AdminResource resource : list) {
            TreeNode treeNode = new TreeNode();
            treeNode.setId(resource.getResourceId());
            treeNode.setName(resource.getName());
            treeNode.setParentId(resource.getParentId());
            treeNodeList.add(treeNode);
        }
        TreeUtil treeUtil = new TreeUtil(treeNodeList);
        TreeNode treeNode = treeUtil.generateTree(id);
        return treeNode;
	}
	
	/**
     * 保存资源之前生成资源的path
     *
     * @param resource
     * @return
     */
    @Override
    @Transactional
    public boolean save(AdminResource resource) {
    	// 处理icon字符串
		String icon = resource.getIcon();
		if (icon.matches("^fa-(.*)")) {
			resource.setIcon("fa " + icon);
		} else if (icon.matches("^glyphicon-(.*)")){
			resource.setIcon("glyphicon " + icon);
		}
        //保存以后会自动将生成的主键回写到resource对象上
        super.save(resource);
        //1.获取父资源的路径
        AdminResource parent = this.getById(resource.getParentId());
        String path = parent.getPath() + "/" + resource.getResourceId(); // path/id
        //2.将生成的path更新到资源表
        resource.setPath(path);
        this.updateById(resource);
        return true;
    }
    
    /**
     * 如果该资源下有子资源，不能删除，只能删除叶子节点
     * 将sys_role_resource表中该资源的信息一并删除
     *
     * @param id
     * @return
     */
    @Override
    @Transactional
    public boolean removeById(Serializable id) {
        //检查该节点是否有子节点
        QueryWrapper<AdminResource> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("parent_id", id); //select * from sys_resource where parent_id = 10
        if (this.count(queryWrapper) > 0) {
            throw new BizException("请先删除该资源下的子资源");
        }
        // 删除该资源分配的角色信息
        QueryWrapper<AdminRoleResource> queryRoleResource = new QueryWrapper<>();
        queryRoleResource.eq("resource_id", id);
        roleResourceMapper.delete(queryRoleResource);

        return super.removeById(id);
    }

    @Override
    @Transactional
    public boolean removeByIds(Collection<? extends Serializable> idList) {

        StringBuilder sb = new StringBuilder();
        for (Serializable id : idList) {
            QueryWrapper<AdminResource> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("parent_id", id); //select * from sys_resource where parent_id = 10
            if (this.count(queryWrapper) > 0) {
                // 获取当前资源的详情
            	AdminResource resource = this.getById(id);
                sb.append("请先删除资源【" + resource.getName() + "】下的子资源<br>");
            }
        }
        if (!StringUtils.isEmpty(sb.toString())) {
            throw new BizException(sb.toString());
        }
        // 删除该资源分配的角色信息
        QueryWrapper<AdminRoleResource> queryRoleResource = new QueryWrapper<>();
        queryRoleResource.in("resource_id", idList);
        roleResourceMapper.delete(queryRoleResource);
        return super.removeByIds(idList);
    }
}
