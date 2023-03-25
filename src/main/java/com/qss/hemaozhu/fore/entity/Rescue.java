package com.qss.hemaozhu.fore.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.qss.hemaozhu.admin.entity.Area;

import java.util.Date;
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
 * @since 2020-04-14
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Rescue implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "rescue_id", type = IdType.AUTO)
    private Integer rescueId;

    private Integer userId;
    
    @TableField(exist = false)
    private Users user;
    
    @TableField(exist = false)
    private Voluteer vol;

    private String title;

    private String introduction;

    private String tag;

    private String content;

    private Integer province;

    private Integer city;
    
    private Integer status;
    
    private Integer verify;
    
    @TableField(exist = false)
    private Area area;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date updateTime;


}
