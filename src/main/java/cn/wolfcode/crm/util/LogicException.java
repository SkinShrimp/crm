package cn.wolfcode.crm.util;

/**
 * 处理用户找不到的报错
 *
 * @author
 */
public class LogicException extends RuntimeException {
    public LogicException() {
        super();
    }

    public LogicException(String message) {
        super(message);
    }

    public LogicException(String message, Throwable cause) {
        super(message, cause);
    }
}
