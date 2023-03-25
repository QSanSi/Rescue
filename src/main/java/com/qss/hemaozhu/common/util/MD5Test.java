package com.qss.hemaozhu.common.util;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.qss.hemaozhu.common.model.TreeNode;
import com.qss.hemaozhu.admin.entity.AdminUser;
import com.qss.hemaozhu.admin.entity.Dept;
import com.qss.hemaozhu.admin.service.IAdminUserService;
import com.qss.hemaozhu.admin.service.IDeptService;
import com.qss.hemaozhu.common.util.MD5Util;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring-config.xml")
public class MD5Test {
	
	/*
	 * @Test public static void main(String[] args) { String password = "123456";
	 * String code = MD5Util.md5_private_salt(password, "740551032");
	 * System.out.println(code); }
	 */
	
	@Autowired
	private IAdminUserService userService;
	
	@Autowired
	private IDeptService deptService;
	
	@Test
	public void test01() {
		List<TreeNode> list = userService.getMenuTreeByUserId(1);
		System.out.println(list);
	}
	
	@Test
	public void test02() {
		/*
		 * List<Dept> dept = deptService.getDeptByDeptId(null); for (Dept dept2 : dept)
		 * { System.out.println(dept2.getDeptName()); }
		 */
		//System.out.println(dept);
		List<AdminUser> user = userService.getAdminUserList(null);
		System.out.println(user);
	}
}
