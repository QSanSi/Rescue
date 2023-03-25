package com.qss.hemaozhu.fore.service;

import com.qss.hemaozhu.fore.entity.Users;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author qss
 * @since 2020-04-02
 */
public interface IUsersService extends IService<Users> {
	boolean updateById(Users user);
	boolean save(Users user);
	boolean updateVol(Users user);
}
