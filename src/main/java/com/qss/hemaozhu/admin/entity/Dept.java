package com.qss.hemaozhu.admin.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 部门/站点信息
 * </p>
 *
 * @author qss
 * @since 2020-03-20
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("admin_dept")
public class Dept implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 部门id
     */
    @TableId(value = "dept_id", type = IdType.AUTO)
    private Integer deptId;

    /**
     * 部门名
     */
    private String deptName;

    /**
     * 负责人
     */
    private String deptManager;

    /**
     * 负责人联系方式
     */
    private String managerTel;
    
    /**
     * 部门类型
     */
    private Integer type;
    
    /**
     * 部门所在省
     */
    private Integer pareaId;
    
    /**
     * 部门所在市
     */
    private Integer careaId;
    
    /**
     * 部门所在区
     */
    private Integer dareaId;

    /**
     * 部门所在省市区
     */
    @TableField(exist = false)
    private String deptArea;
    
    /**
     * 线下站点服务范围
     */
    @TableField(exist = false)
    private String serviceArea;

    /**
     * 部门详细地址
     */
    private String deptAdd;

    /**
     * 备注
     */
    private String remark;


}
