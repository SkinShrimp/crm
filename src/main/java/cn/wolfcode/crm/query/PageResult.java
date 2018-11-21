package cn.wolfcode.crm.query;

import lombok.Data;

import java.util.List;

@Data
public class PageResult<T> {
    private int totalCount;
    private List<T> result;

    private QueryObject qo;

    private int totalPage;
    private int prevPage;
    private int nextPage;

    public PageResult(int totalCount, List<T> result, QueryObject qo) {
        this.totalCount = totalCount;
        this.result = result;
        this.qo = qo;
        if (qo.getPageSize() > totalCount) {
            this.totalPage = 1;
            this.prevPage = 1;
            this.nextPage = 1;
            return;
        }

        this.totalPage = this.totalCount % this.qo.getPageSize() == 0 ? this.totalCount / this.qo.getPageSize() : this.totalCount / this.qo.getPageSize() + 1;
        this.prevPage = this.qo.getCurrentPage() - 1 > 1 ? this.qo.getCurrentPage() - 1 : 1;
        this.nextPage = this.qo.getCurrentPage() + 1 < totalPage ? this.qo.getCurrentPage() + 1 : this.totalPage;
    }
}
