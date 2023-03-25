package com.qss.hemaozhu.admin.mapper;

import com.qss.hemaozhu.admin.entity.AdminUser;
import com.qss.hemaozhu.admin.entity.Menu;

import java.util.List;
import java.util.Set;

import org.apache.ibatis.annotations.Param;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;

/**
 * <p>
 * 管理用户 Mapper 接口
 * </p>
 *
 * @author qss
 * @since 2020-03-10
 */
public interface AdminUserMapper extends BaseMapper<AdminUser> {
	/**
     * 根据id查询用户角色名称的集合
     * @param id
     * @return
     */
    Set<String> selectUserRoleNameSet(Integer id);

    /**
     * 根据id查询用户权限名称的集合
     * @param id
     * @return
     */
    Set<String> selectUserPermissionNameSet(Integer id);


    /**
     * 根据用户id查询用户菜单
     * @param id
     * @return
     */
    List<Menu> selectMenuList(Integer id);
    
    /**
     * 根据用户ID查询用户信息/查询用户列表
     * @param id
     * @return
     */
    //List<AdminUser> selectAdminUser(Integer id);
    List<AdminUser> selectAdminUserList(@Param(Constants.WRAPPER) Wrapper<AdminUser> queryWrapper);
}
