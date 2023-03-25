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
 * @since 2020-04-12
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Cityadopt implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "cityadopt_id", type = IdType.AUTO)
    private Integer cityadoptId;

    private Integer userId;
    
    @TableField(exist = false)
    private Users user;

    private Integer province;

    private Integer city;
    
    @TableField(exist = false)
    private Area area;

    private String petname;

    private String variety;

    private Integer gendar;

    private String age;

    private String birthday;

    private String photo;

    private String title;

    private String introduction;

    private String tag;

    private String content;
    
    private Integer status;
    
    private Integer verify;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date updateTime;


}
