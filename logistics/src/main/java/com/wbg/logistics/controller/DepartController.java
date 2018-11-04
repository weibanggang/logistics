package com.wbg.logistics.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wbg.logistics.dao.DepartMapper;
import com.wbg.logistics.entity.Depart;
import com.wbg.logistics.util.DBUtil;
import com.wbg.logistics.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.ws.rs.PathParam;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/depart")
public class DepartController {

    @Autowired
    private DepartMapper departMapper;
    @RequestMapping(value = "/json",method = RequestMethod.GET)
    @ResponseBody
    public String selectAllJson(@RequestParam("page") int page ,@RequestParam("limit") int limit){
        PageHelper.startPage(page,limit);
        R r=new R();
        List<Depart> list=departMapper.selectAllJson();
        PageInfo pi = new PageInfo(list);
        r.setMsg("ok");
        r.setData(list);
        r.setCount((int)pi.getTotal());
        return r.toJsonyMd();
    }
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String add(Depart depart, RedirectAttributes redirectAttributes) {
        try {
            if (departMapper.insert(depart) > 0) {
                redirectAttributes.addAttribute("msg", "添加成功");
                redirectAttributes.addAttribute("routeName","");
                redirectAttributes.addAttribute("staff", "");
            }
            else{
                redirectAttributes.addAttribute("msg","添加失败");

            }
        }catch (Exception e){
            redirectAttributes.addAttribute("msg","添加失败");

            return "redirect:/depart";
        }
        return "redirect:/depart";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public String update(@RequestBody Depart depart) {
        R r = new R();
        try{
            if (departMapper.updateByPrimaryKey(depart) > 0) {
                r.setMsg("修改成功");
                r.setCode(3);
            } else
                r.setMsg("修改失败");
        }catch (Exception e){
            r.setMsg("修改失败");
            return r.toJsonyMd();
        }


        return r.toJsonyMd();
    }

    @RequestMapping(value = "/del/{departNo}", method = RequestMethod.POST)
    @ResponseBody
    public String del(@PathVariable("departNo") int departNo) {
        R r = new R();
        try {
            if (departMapper.deleteByPrimaryKey(departNo) > 0) {
                r.setMsg("删除成功");
                r.setCode(3);
            } else
                r.setMsg("删除失败");
        }catch (Exception e){
            r.setMsg("删除失败,可能存在员工");
            return r.toJsonyMd();
        }
        return r.toJsonyMd();
    }
    @RequestMapping(method = RequestMethod.GET)
    public String index(){
        return "employeeadd";
    }

    @RequestMapping(value = "/ById/{staffNo}", method = RequestMethod.GET)
    @ResponseBody
    public String seleById(@PathVariable("staffNo") int staffNo){
        R r=new R();
        List<Depart> list=departMapper.selectByPrimaryKey(staffNo);
        r.setMsg("ok");
        r.setData(list);
        r.setCount(1);
        return r.toJson();
    }
    @RequestMapping(value = "/ByName/{staffName}", method = RequestMethod.GET)
    @ResponseBody
    public String seleByName(@PathVariable("staffName") String staffName){
        R r=new R();
        List<Depart> list=departMapper.selectByType("%"+staffName+"%");
        PageInfo pi = new PageInfo(list);
        r.setMsg("ok");
        r.setData(list);
        r.setCount((int)pi.getTotal());
        return r.toJson();
    }

}
