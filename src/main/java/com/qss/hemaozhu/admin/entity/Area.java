package com.qss.hemaozhu.admin.entity;

import java.io.Serializable;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author qss
 * @since 2020-03-30
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("area")
public class Area implements Serializable {

    private static final long serialVersionUID = 1L;
    
    @TableId(value = "id")
    private Integer id;
    
    private String name;

    private Integer parentId;

    /**
     * 国0  省1  市2  区3
     */
    private Integer type;


}
