<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="/js/plugins/chart/echarts.common.min.js"></script>
</head>

<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div id="main" style="width: 550px; height: 400px; margin: 30px auto;"></div>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));

    // 指定图表的配置项和数据
    option = {
        title: {
            text: '客户报表',
            subtext: '${groupTypeName}',
            left: 'center'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: ['客户总数'],
            left: 'left'
        },
        toolbox: {
            show: true,
            feature: {
                dataView: {show: true, readOnly: false},
                magicType: {show: true, type: ['line', 'bar']},
                restore: {show: true},
                saveAsImage: {show: true}
            }
        },
        calculable: true,
        xAxis: [
            {
                type: 'category',
                data: ${groupTypes}
            }
        ],
        yAxis: [
            {
                type: 'value'
            }
        ],
        series: [
            {
                name: '客户总数',
                type: 'bar',
                data: ${totalNumbers},
                markPoint: {
                    data: [
                        {type: 'max', name: '最大值'},
                        {type: 'min', name: '最小值'}
                    ]
                },
                markLine: {
                    data: [
                        {type: 'average', name: '平均值'}
                    ]
                }
            }
        ]
    };
    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);

    $(function () {
        $("#barModel").modal("show")
    });
</script>

<body>
</body>
</html>