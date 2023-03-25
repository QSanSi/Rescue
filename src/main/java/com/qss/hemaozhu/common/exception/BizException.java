package com.qss.hemaozhu.common.exception;

/**
 * 自定义业务异常
 */
public class BizException extends RuntimeException{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public BizException(String message) {
        super(message);
    }
}
