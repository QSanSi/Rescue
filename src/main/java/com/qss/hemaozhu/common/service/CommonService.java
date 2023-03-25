package com.qss.hemaozhu.common.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

@Service
public class CommonService {
	public <T> Page<T> handleOrder(Page<T> page, OrderItem order) {
		if(order.getColumn() != null) {
			String col = order.getColumn().replaceAll("[A-Z]", "_$0").toLowerCase();
			order.setColumn(col);
    	}
    	List<OrderItem> orders = new ArrayList<>();
    	orders.add(order);
    	page.setOrders(orders);
    	return page;
	}
	
	/**
     * 获取过去第几天的日期
     *
     * @param past
     * @return
     */
    public String getPastDate(int past,Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.set(Calendar.DATE, calendar.get(Calendar.DATE) - past);
        Date pastday = calendar.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String result = sdf.format(pastday);
        return result;
    }
    
    /**
     * 获取过去7天内的日期数组
     * @return  日期数组
     */
    public ArrayList<String> pastDay(String pastday, String today){
        ArrayList<String> pastDaysList = new ArrayList<>();
        try {
            SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
            Date td = sdf.parse(today);
            Date pd = sdf.parse(pastday);
            int c = this.differentDaysByMillisecond(pd, td);
            for (int i = c; i >= 0; i--) {
                pastDaysList.add(getPastDate(i,td));
            }
        }catch (ParseException e){
            e.printStackTrace();
        }
        return pastDaysList;
    }
    
    /**
     * 通过时间秒毫秒数判断两个时间的间隔
     * @param date1
     * @param date2
     * @return
     */
    public int differentDaysByMillisecond(Date date1,Date date2)
    {
        int days = (int) ((date2.getTime() - date1.getTime()) / (1000*3600*24));
        return days;
    }
    
    public String getToday() {
    	Date today = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	return sdf.format(today);
    }
    
    public String format(Date date) {
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	return sdf.format(date);
    }
    
    public Date parse(String day) {
    	SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
    	Date td = new Date();
        try {
        	td = sdf.parse(day);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return td;
    }
    
    public Date addday(Date day, Integer i) {
    	Calendar cal = Calendar.getInstance();
		cal.setTime(day);
		cal.add(Calendar.DATE, i);
		day = cal.getTime();
		return day;
    }
}
