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
public class Contract implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 契约id
     */
    @TableId(value = "contract_id", type = IdType.AUTO)
    private Integer contractId;

    /**
     * 领养站点
     */
    private Integer deptId;
    
    @TableField(exist = false)
    private Dept dept;

    /**
     * 主人姓名
     */
    private String master;

    /**
     * 主人年龄
     */
    private Integer age;

    /**
     * 主人职业
     */
    private String career;

    /**
     * 联系方式
     */
    private String tel;

    /**
     * 居住地址
     */
    private String addr;

    /**
     * 身份证号
     */
    private String idcard;

    /**
     * 领养宠物
     */
    private Integer petId;
    
    @TableField(exist = false)
    private Pet pet;

    /**
     * 协议图片
     */
    private String agreement;

    /**
     * 契约图片
     */
    private String contract;

    /**
     * 记录时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;


}
