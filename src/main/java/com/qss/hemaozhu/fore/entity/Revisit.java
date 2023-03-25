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
public class Revisit implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 回访id
     */
    @TableId(value = "revisit_id", type = IdType.AUTO)
    private Integer revisitId;

    /**
     * 回访者
     */
    private Integer contractId;
    
    @TableField(exist = false)
    private Contract con;

    /**
     * 总计回访次数
     */
    private Integer count;

    /**
     * 信息是否改变 0：否 1：是
     */
    private Integer ischange;

    /**
     * 是否合格 0：否 1：是
     */
    private Integer pass;
    
    /**
     * 回访站点
     */
    private Integer deptId;
    
    @TableField(exist = false)
    private Dept dept;

    /**
     * 回访时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;


}
