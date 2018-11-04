package com.wbg.logistics.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wbg.logistics.dao.RouteMapper;
import com.wbg.logistics.entity.Route;
import com.wbg.logistics.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/route")
public class RouteController {





    @Autowired
    private RouteMapper routeMapper;
    @RequestMapping(value = "/json",method = RequestMethod.GET)
    @ResponseBody
    public String selectAllJson(@RequestParam("page") int page , @RequestParam("limit") int limit){
        PageHelper.startPage(page,limit);
        R r=new R();
        List<Route> list=routeMapper.selectAllJson();
        PageInfo pi = new PageInfo(list);
        r.setMsg("ok");
        r.setData(list);
        r.setCount((int)pi.getTotal());
        return r.toJson();
    }
    //添加
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String add(Route route, RedirectAttributes redirectAttributes) {
        try {
            if (routeMapper.insert(route) > 0) {
                redirectAttributes.addAttribute("msg", "添加成功");
                redirectAttributes.addAttribute("routeName","");
                redirectAttributes.addAttribute("staff", "");
            }
            else{
                redirectAttributes.addAttribute("msg","添加失败");
                redirectAttributes.addAttribute("staff", route.getStaffNo());
                redirectAttributes.addAttribute("routeName", route.getRouteName());
            }
        }catch (Exception e){
            redirectAttributes.addAttribute("msg","添加失败");
            redirectAttributes.addAttribute("staff", route.getStaffNo());
            redirectAttributes.addAttribute("routeName", route.getRouteName());
            return "redirect:/route";
        }
        return "redirect:/route";
    }

    @RequestMapping(method = RequestMethod.GET)
    public String index(){
        return "routeadd";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public String update(@RequestBody Route route) {
        R r = new R();
        try {
            if (routeMapper.updateByPrimaryKey(route) > 0) {
                r.setMsg("修改成功");
                r.setCode(3);
            } else
                r.setMsg("修改失败");
        }catch (Exception e){
            r.setMsg("修改失败,请重试");
            return r.toJsonyMd();
        }

        return r.toJsonyMd();
    }
    @RequestMapping(value = "/del/{routeNo}", method = RequestMethod.POST)
    @ResponseBody
    public String del(@PathVariable("routeNo") int routeNo) {
        R r = new R();
        try {
            if (routeMapper.deleteByPrimaryKey(routeNo) > 0) {
                r.setMsg("删除成功");
                r.setCode(3);
            } else
                r.setMsg("删除失败");
        }catch (Exception e){
            r.setMsg("删除失败,请重试");
            return r.toJsonyMd();
        }
        return r.toJsonyMd();
    }

    @RequestMapping(value = "/ById/{routeNo}", method = RequestMethod.GET)
    @ResponseBody
    public String seleById(@PathVariable("routeNo") int routeNo){
        R r=new R();
        List<Route> list=routeMapper.selectByPrimaryKey(routeNo);
        r.setMsg("ok");
        r.setData(list);
        return r.toJson();
    }
    @RequestMapping(value = "/ByName/{routeName}", method = RequestMethod.GET)
    @ResponseBody
    public String seleByName(@PathVariable("routeName") String routeName){
        R r=new R();
        List<Route> list=routeMapper.selectByName("%"+routeName+"%");
        PageInfo pi = new PageInfo(list);
        r.setMsg("ok");
        r.setData(list);
        r.setCount((int)pi.getTotal());
        return r.toJson();
    }

 }
