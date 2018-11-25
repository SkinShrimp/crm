package cn.wolfcode.crm.query;

import lombok.Data;
import org.springframework.util.StringUtils;

@Data
public class QueryObject {
    private int pageSize = 5;
    private int currentPage = 1;
    private String orderBy;

    public String getOrderBy() {
        return StringUtils.hasLength(orderBy) ? orderBy : null;
    }

    //获取当前页的开始索引
    public int getBeginIndex() {
        return (currentPage - 1) * pageSize;
    }
}
