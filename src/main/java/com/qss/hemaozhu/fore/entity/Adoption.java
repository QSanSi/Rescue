package com.qss.hemaozhu.fore.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.qss.hemaozhu.admin.entity.Dept;

import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author qss
 * @since 2020-04-10
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Adoption implements Serializable {

    private static final long serialVersionUID = 1L;
    
    @TableId(value = "adopt_id", type = IdType.AUTO)
    private Integer adoptId;
    
    private Integer petId;
    
    @TableField(exist = false)
    private Pet pet;
    
    private Integer deptId;
    
    @TableField(exist = false)
    private Dept dept;

    private String title;

    private String introduction;

    private String tag;

    private String content;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;
    
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date updateTime;


}
