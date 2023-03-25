package com.qss.hemaozhu.admin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

import java.io.Serializable;
import java.math.BigDecimal;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 站点物资表
 * </p>
 *
 * @author qss
 * @since 2020-03-30
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("dept_goods")
public class DeptGoods implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 物资id
     */
    @TableId(value = "goods_id", type = IdType.AUTO)
    private Integer goodsId;
    
    /**
     * 对应父id
     */
    private Integer parentId;

    /**
     * 物资名
     */
    private String name;

    /**
     * 物资数量
     */
    private Integer count;

    /**
     * 物资所属部门
     */
    private Integer deptId;
    
    @TableField(exist = false)
    private Dept dept;
    
    /**
     * 单价
     */
    private BigDecimal price;
    
    /**
     * 状态  0：不再使用，1：充足，2：不足，3：紧缺，4：耗尽
     */
    private Integer status;
    
    /**
     * 物资录入时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;

    /**
     * 最近物资补充时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date updateTime;

    private String remark;


}
