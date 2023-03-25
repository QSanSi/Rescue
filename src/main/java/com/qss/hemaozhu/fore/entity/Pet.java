package com.qss.hemaozhu.fore.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.qss.hemaozhu.admin.entity.Dept;

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
 * @since 2020-04-05
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Pet implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 宠物id
     */
    @TableId(value = "pet_id", type = IdType.AUTO)
    private Integer petId;

    /**
     * 类型 0：猫 1：狗
     */
    private Integer type;

    /**
     * 品种
     */
    private String variety;

    /**
     * 宠物名
     */
    private String petname;

    /**
     * 性别 0：男 1：女
     */
    private Integer gendar;

    /**
     * 年龄
     */
    private String age;

    /**
     * 生日
     */
    private String birthday;
    
    /**
     * 照片
     */
    private String photo;

    /**
     * 救助站点
     */
    private Integer deptId;
    
    @TableField(exist = false)
    private Dept dept;

    /**
     * 状态 0：未被领养 1：已被领养
     */
    private Integer status;

    /**
     * 备注
     */
    private String remark;

    /**
     * 记录时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;


}
