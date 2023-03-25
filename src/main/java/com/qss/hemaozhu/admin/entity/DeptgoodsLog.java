package com.qss.hemaozhu.admin.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 物资补充记录
 * </p>
 *
 * @author qss
 * @since 2020-03-30
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("deptgoods_log")
public class DeptgoodsLog implements Serializable {

    private static final long serialVersionUID = 1L;
    
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 物资id
     */
    private Integer goodsId;
    
    private Integer deptId;
    
    /**
     * 原库存
     */
    private Integer restcount;

    /**
     * 物资变化数量/请求数量
     */
    private Integer count;
    
    /**
     * 状态 1：未响应，2：发货，3：已确认
     */
    private Integer status;
    
    /**
     * 对应物资实体
     */
    @TableField(exist = false)
    private DeptGoods deptGoods;
    
    @TableField(exist = false)
    private Dept dept;
    
    /**
     * 请求时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date requestTime;
    
    /**
     * 响应时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date updateTime;
    
    /**
     * 确认时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date confirmTime;

}
