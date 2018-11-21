<div style="text-align: center;">
    <ul id="pagination" class="pagination"></ul>
</div>
<script>
//分页
$(function(){
    $("#pagination").twbsPagination({
            totalPages: ${result.pages}||1,
            startPage: ${result.pageNum},
            visiblePages:3,
            first:"首页",
            prev:"上一页",
            next:"下一页",
            last:"尾页",
            onPageClick:function(event,page){
            $("#currentPage").val(page);
            $("#searchForm").submit();
        }
    });
})
</script>