package com.qss.hemaozhu.admin.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.qss.hemaozhu.admin.entity.DeptgoodsLog;
import com.qss.hemaozhu.admin.service.IDeptGoodsService;
import com.qss.hemaozhu.admin.service.IDeptgoodsLogService;
import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.common.service.CommonService;

/**
 * <p>
 * 物资补充记录 前端控制器
 * </p>
 *
 * @author qss
 * @since 2020-03-30
 */
@Controller
@RequestMapping("/dept/log")
public class DeptgoodsLogController {
	@Autowired
	private IDeptgoodsLogService logService;
	
	@Autowired
	private IDeptGoodsService goodsService;
	
	@Autowired
	private CommonService commonService;
	
	@RequestMapping("/log")
	public String list(Model model) {
		Date today = new Date();
        String pd = commonService.getPastDate(7, today);
        String d = commonService.getToday();
        model.addAttribute("pastday", pd);
        model.addAttribute("today", d);
		return "admin/dept/log/log_list";
	}
	
	@RequestMapping("/logone/{goodsId}")
	public String listone(@PathVariable Integer goodsId, Model model) {
		Date today = new Date();
        String pd = commonService.getPastDate(6, today);
        String d = commonService.getToday();
        model.addAttribute("pastday", pd);
        model.addAttribute("today", d);
        model.addAttribute("goodsId", goodsId);
		return "admin/dept/log/log_list";
	}
	
    @RequestMapping("/data")
    @ResponseBody
	public R data(Integer deptId, Integer goodsId, String pd, String d, Page<DeptgoodsLog> page, OrderItem order) {
    	//0.处理排序列名驼峰规则
    	page = commonService.handleOrder(page, order);
    	//1.构造查询条件构造器
    	QueryWrapper<DeptgoodsLog> param = new QueryWrapper<>();
    	if(goodsId != null) {
    		param.eq("goods_id", goodsId);
    	}
    	if(deptId != 1) {
    		param.eq("dept_id", deptId);
    	}
    	Date today = commonService.parse(d);
    	Date pastday = commonService.parse(pd);
		param.and(QueryWrapper -> QueryWrapper.between("update_time", pastday, commonService.addday(today, 1)).or()
				.between("request_time", pastday, commonService.addday(today, 1)).or()
				.between("confirm_time", pastday, commonService.addday(today, 1)));
    	if(StringUtils.isEmpty(order.getColumn())) {
    		param.orderByDesc("update_time");
    	}
    	//2.分页查询
    	logService.page(page, param);
    	//3.返回分页数据
    	return R.ok(page);
	}
    
    @RequestMapping("/accept/{id}")
    @ResponseBody
    public R accept(@PathVariable Integer id) {
    	if(logService.accept(id))
    		return R.ok();
    	else
    		return R.error("库存不足");
    }
    
    @RequestMapping(value = "/acceptbatch", method = RequestMethod.POST)
    @ResponseBody
    public R acceptbatch(@RequestBody List<Integer> ids) {
    	String msg = "请求成功";
    	String name = "";
    	Boolean b = true;
    	for(Integer id : ids) {
			if(!logService.accept(id)) {
				Integer gid = logService.getById(id).getGoodsId();
				name += goodsService.getById(gid).getName() + "<br/>";
				msg = name + "库存不足";
				b = false;
			}
		}
    	if(b)
    		return R.ok(msg);
    	else
    		return R.error(msg);
    }
    
    @RequestMapping("/check/{id}")
    @ResponseBody
    public R check(@PathVariable Integer id) {
    	logService.check(id);
		return R.ok();
    }
    
    @RequestMapping("/ban/{id}")
    @ResponseBody
    public R ban(@PathVariable Integer id) {
    	if(logService.ban(id))
    		return R.ok();
    	else
    		return R.error("已审核，驳回失败");
    		
    }
    
    @RequestMapping(value = "/banbatch", method = RequestMethod.POST)
    @ResponseBody
    public R banbatch(@RequestBody List<Integer> ids) {
    	String msg = "请求成功";
    	String name = "";
    	Boolean b = true;
    	for(Integer id : ids) {
    		if(!logService.ban(id)) {
    			Integer gid = logService.getById(id).getGoodsId();
				name += goodsService.getById(gid).getName() + "<br/>";
				msg = name + "已审核，驳回失败";
				b = false;
    		}
    		
    	}
    	if(b)
    		return R.ok(msg);
    	else
    		return R.error(msg);
    }
}
