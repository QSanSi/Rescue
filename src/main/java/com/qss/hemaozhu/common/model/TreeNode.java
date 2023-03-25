package com.qss.hemaozhu.common.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * 树的节点模型
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class TreeNode {

	private Integer id; // 节点id

	@JsonProperty("text") // 生成json字符串中的属性名称
	private String name;// 节点名称

	private Integer parentId;// 父几点的id

	// 子节点
	@JsonProperty("nodes")
	private List<TreeNode> children = new ArrayList<>();

	private Map<String, Boolean> state = new HashMap<>();

	private String url;
	private String icon;
}
