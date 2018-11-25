<div style="text-align: center;">
    <ul id="pagination" class="pagination"></ul>
</div>
<script>
    //分页
    $(function () {
        $("#pagination").twbsPagination({
            totalPages: ${pageInfo.pages},//总页数
            startPage: ${pageInfo.pageNum},//当前页
            visiblePages: ${qo.pageSize},
            first: '首页',
            prev: '上一页',
            next: '下一页',
            last: '末页',
            onPageClick: function (event, page) {
                $("#currentPage").val(page);//修改表单中的页面参数
                $("#searchForm").submit();
            }
        });
    });
</script>