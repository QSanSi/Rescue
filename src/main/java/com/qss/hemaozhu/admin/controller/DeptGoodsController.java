package com.qss.hemaozhu.admin.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.qss.hemaozhu.admin.entity.DeptGoods;
import com.qss.hemaozhu.admin.entity.DeptgoodsLog;
import com.qss.hemaozhu.admin.service.IDeptGoodsService;
import com.qss.hemaozhu.admin.service.IDeptgoodsLogService;
import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.common.service.CommonService;

/**
 * <p>
 * 站点物资表 前端控制器
 * </p>
 *
 * @author qss
 * @since 2020-03-30
 */
@Controller
@RequestMapping("/dept/goods")
public class DeptGoodsController {
	@Autowired
	private IDeptGoodsService deptgoodsService;
	
	@Autowired
	private IDeptgoodsLogService logService;
	
	@Autowired
	private CommonService commonService;
	
	/**
     * 跳转到列表
     *
     * @return
     */
    @RequestMapping("/goods")
    public String list() {
        return "admin/dept/goods/goods_list";
    }
    
    @RequestMapping("/data")
    @ResponseBody
    public R data(Integer deptId, String name, Page<DeptGoods> page, OrderItem order) {
    	//0.处理排序列名驼峰规则
    	page = commonService.handleOrder(page, order);
    	//1.构造查询条件构造器
    	QueryWrapper<DeptGoods> param = new QueryWrapper<>();
    	if(!StringUtils.isEmpty(name)) {
    		param.like("name", name);
    	}
    	param.eq("dept_id", deptId);
    	if(StringUtils.isEmpty(order.getColumn())) {
    		param.orderByDesc("status");
    	}
    	//2.分页查询
    	deptgoodsService.page(page, param);
    	//3.返回分页数据
    	return R.ok(page);
    }
    
    @RequestMapping(value = "/checkname", method = RequestMethod.POST)
    @ResponseBody
    public String checkname(@RequestParam String name, @RequestParam Integer deptId, @RequestParam(defaultValue = "0") Integer goodsId) {
    	String success = "false";
    	QueryWrapper<DeptGoods> param = new QueryWrapper<>();
    	param.eq("name", name);
    	param.eq("dept_id", deptId);
    	param.ne("goods_id", goodsId);
    	if(deptgoodsService.count(param) == 0) {
    		success = "true";
    	}
    	return success;
    }
    
    @RequestMapping("/add")
    public String add(Model model) {
    	QueryWrapper<DeptGoods> param = new QueryWrapper<>();
    	param.eq("dept_id", 1);
    	model.addAttribute("pgoodslist", deptgoodsService.list(param));
    	return "admin/dept/goods/goods_add";
    }
    
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public R add(DeptGoods goods) {
    	deptgoodsService.save(goods);
    	return R.ok();
    }
    
    @RequestMapping("/edit/{goodsId}")
    public String update(@PathVariable Integer goodsId, Model model) {
        model.addAttribute("goods", deptgoodsService.getById(goodsId));
        return "admin/dept/goods/goods_update";
    }
    
    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ResponseBody
    public R update(DeptGoods goods) {
    	deptgoodsService.status(goods);
    	deptgoodsService.updateById(goods);
        return R.ok();
    }
    
    @RequestMapping("/more/{goodsId}")
    public String more(@PathVariable Integer goodsId, Model model) {
    	QueryWrapper<DeptGoods> param = new QueryWrapper<>();
    	param.eq("goods_id", goodsId);
    	model.addAttribute("goods", deptgoodsService.getOne(param));
    	return "admin/dept/goods/goods_more";
    }
    
    @RequestMapping(value = "/more", method = RequestMethod.POST)
    @ResponseBody
    public R more(DeptGoods goods) {
    	DeptGoods newgoods = deptgoodsService.getById(goods.getGoodsId());
    	deptgoodsService.more(newgoods, goods.getCount());
    	logService.log(newgoods, goods.getCount());
    	return R.ok();
    }
    
    @RequestMapping("/request/{goodsId}")
    public String request(@PathVariable Integer goodsId, Model model) {
    	QueryWrapper<DeptGoods> param = new QueryWrapper<>();
    	param.eq("goods_id", goodsId);
    	model.addAttribute("goods", deptgoodsService.getOne(param));
    	return "admin/dept/goods/goods_request";
    }
    
    @RequestMapping(value = "/request", method = RequestMethod.POST)
    @ResponseBody
    public R request(DeptGoods goods) {
    	DeptGoods newgoods = deptgoodsService.getById(goods.getGoodsId());
    	DeptGoods parentgoods = deptgoodsService.getById(newgoods.getParentId());
    	QueryWrapper<DeptgoodsLog> param = new QueryWrapper<>();
    	param.eq("goods_id", goods.getGoodsId());
    	param.ne("status", 1);
    	param.ne("status", 0);
    	if(logService.count(param) != 0){
    		return R.error("上次申请为完成，请勿重复申请");
    	} else if(goods.getCount() > parentgoods.getCount()) {
    		return R.error("总部库存不足");
    	} else {
    		logService.request(newgoods, goods.getCount());
        	return R.ok();
    	}
    }
    
    @RequestMapping("/expand/{goodsId}/{count}")
    @ResponseBody
    public R expand(@PathVariable Integer goodsId, @PathVariable Integer count) {
    	DeptGoods newgoods = deptgoodsService.getById(goodsId);
    	if(deptgoodsService.expand(newgoods, count)) {
    		logService.log(newgoods, -count);
    		return R.ok();
    	}
    	else
    		return R.error("库存不足");
    }
}
