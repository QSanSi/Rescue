package com.qss.hemaozhu.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.common.service.FileService;

@Controller
@RequestMapping("/filecontrol")
public class FileController {
	@Autowired
	private FileService fileService;
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public R delFile(@RequestParam(value="file") String filename) {
		Boolean b = fileService.delFile(filename);
		if(b) {
			return R.ok();
		}else {
			return R.error("删除失败");
		}
	}
}