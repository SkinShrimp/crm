package cn.wolfcode.crm.query;

import lombok.Data;

@Data
public class QueryObject {
    private int pageSize = 5;
    private int currentPage = 1;
    //获取当前页的开始索引
    public int getBeginIndex() {
        return (currentPage - 1) * pageSize;
    }
}
