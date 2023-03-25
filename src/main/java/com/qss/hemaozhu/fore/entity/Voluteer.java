package com.qss.hemaozhu.fore.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
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
 * @since 2020-04-05
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Voluteer implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 志愿者id
     */
    @TableId(value = "vol_id", type = IdType.AUTO)
    private Integer volId;

    /**
     * 对应账户id
     */
    private Integer userId;
    
    @TableField(exist = false)
    private Users user;

    /**
     * 注册站点id
     */
    private Integer deptId;
    
    @TableField(exist = false)
    private Dept dept;

    /**
     * 姓名
     */
    private String realname;

    /**
     * 性别 0：男，1：女
     */
    private Integer gendar;

    /**
     * 联系方式
     */
    private String tel;

    /**
     * 身份证
     */
    private String idcard;

    /**
     * 志愿地址—省
     */
    private Integer province;

    /**
     * 志愿地址—市
     */
    private Integer city;

    /**
     * 志愿地址—区/县
     */
    private Integer district;
    
    @TableField(exist = false)
    private String area;
}
