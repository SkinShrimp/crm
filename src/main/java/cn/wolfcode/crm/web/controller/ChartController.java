package cn.wolfcode.crm.web.controller;

import cn.wolfcode.crm.query.ChartQueryObject;
import cn.wolfcode.crm.service.IChartService;
import cn.wolfcode.crm.util.JsonUtil;
import cn.wolfcode.crm.util.MessageUtil;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/chart")
public class ChartController {
    @Autowired
    private IChartService chartService;

    @RequestMapping("/list")
    @RequiresPermissions(value = {"潜在用户报表查询", "chart:list"}, logical = Logical.OR)
    public String list(Model model, @ModelAttribute("qo") ChartQueryObject qo) {
        model.addAttribute("charts", chartService.queryCustomerChart(qo));
        return "chart/list";
    }

    @RequestMapping("/chartByBar")
    public String charByBar(Model model, @ModelAttribute("qo") ChartQueryObject qo) {
        //1、准备报表中头需要的子标题[销售员，年份，月份]
        model.addAttribute("groupTypeName", MessageUtil.changMsg(qo));
        List<Map<String, Object>> maps = chartService.queryCustomerChart(qo);

        //2、准备报表尾部对应的数值
        List<Object> groupByTypes = new ArrayList<>();
        for (Map<String, Object> map : maps) {
            groupByTypes.add(map.get("groupByType"));
        }
        //将集合转换为Json数据
        model.addAttribute("groupTypes", JsonUtil.toJsonString(groupByTypes));

        //3、准备报表尾部对应的数值
        List<Object> totalNumbers = new ArrayList<>();
        for (Map<String, Object> map : maps) {
            totalNumbers.add(map.get("totalNumber"));
        }
        //将集合转换为Json数据
        model.addAttribute("totalNumbers", JsonUtil.toJsonString(totalNumbers));

        return "chart/chartByBar";
    }

    @RequestMapping("/chartByPie")
    public String charByPie(Model model, @ModelAttribute("qo") ChartQueryObject qo) {
        //1、查询报表头部的子标题，回显
        String message = MessageUtil.changMsg(qo);
        model.addAttribute("groupByTypeName", message);

        //2、查询报表的目录和查询报表的数据
        List<Map<String, Object>> maps = chartService.queryCustomerChart(qo);


        List<Object> groupByTypes = new ArrayList<>();
        List<Map<String, Object>> datas = new ArrayList<>();
        for (Map<String, Object> map : maps) {
            groupByTypes.add(map.get("groupByType"));

            Map<String, Object> data = new HashMap<>();
            data.put("value", map.get("totalNumber"));
            data.put("name", map.get("groupByType"));
            datas.add(data);
        }

        model.addAttribute("groupByTypes", JsonUtil.toJsonString(groupByTypes));
        model.addAttribute("datas", JsonUtil.toJsonString(datas));
        return "chart/chartByPie";
    }
}
