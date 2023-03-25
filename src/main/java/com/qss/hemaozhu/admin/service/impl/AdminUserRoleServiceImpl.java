package com.qss.hemaozhu.admin.service.impl;

import com.qss.hemaozhu.admin.entity.AdminUserRole;
import com.qss.hemaozhu.admin.mapper.AdminUserRoleMapper;
import com.qss.hemaozhu.admin.service.IAdminUserRoleService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 * 用户与角色对应关系 服务实现类
 * </p>
 *
 * @author qss
 * @since 2020-03-10
 */
@Service
public class AdminUserRoleServiceImpl extends ServiceImpl<AdminUserRoleMapper, AdminUserRole> implements IAdminUserRoleService {
	
	@Autowired
    private AdminUserRoleMapper userRoleMapper;
	
	@Override
	public List<AdminUserRole> getByUserId(Integer userId) {
		return userRoleMapper.selectByUserId(userId);
	}

	@Override
	@Transactional
	public boolean save(Integer userId, List<Integer> roleIdList) {
		//1.删除当前用户拥有的角色
        QueryWrapper<AdminUserRole> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        this.remove(queryWrapper);

        if (roleIdList != null && !roleIdList.isEmpty()) {
            //2.将新设置的角色分配给当前用户
            List<AdminUserRole> userRoleList = new ArrayList<>();
            for (Integer roleId : roleIdList) {
                AdminUserRole userRole = new AdminUserRole();
                userRole.setUserId(userId);
                userRole.setRoleId(roleId);
                userRoleList.add(userRole);
            }
            //3.批量插入数据
            this.saveBatch(userRoleList);
        }
        return true;
	}

}
