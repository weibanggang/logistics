package com.wbg.logistics.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wbg.logistics.dao.DispatchMapper;
import com.wbg.logistics.entity.Dispatch;
import com.wbg.logistics.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/dispatch")
public class DispatchController {

    @Autowired
    private DispatchMapper dispatchMapper;

    @RequestMapping(value = "/json", method = RequestMethod.GET)
    @ResponseBody
    public String selectAllJson(@RequestParam("page") int page, @RequestParam("limit") int limit) {
        R r = new R();
        PageHelper.startPage(page, limit);
        List<Dispatch> list = dispatchMapper.selectAll();
        PageInfo pi = new PageInfo(list);
        r.setData(list);
        r.setCount((int) pi.getTotal());
        return r.toJsonyMd();
    }
    @RequestMapping(value = "/select", method = RequestMethod.GET)
    @ResponseBody
    public String select() {
        R r = new R();
        List<Dispatch> list = dispatchMapper.selectAll();
        r.setData(list);
        return r.toJsonyMd();
    }

    @RequestMapping(value = "/add/{departName}", method = RequestMethod.POST)
    @ResponseBody
    public String add(@PathVariable("departName") String departName) {
        R r = new R();
        Dispatch dispatch = new Dispatch();
        dispatch.setDepartName(departName);
        if (dispatchMapper.insert(dispatch) > 0) {
            r.setMsg("添加成功");
            r.setCode(3);
        } else
            r.setMsg("添加失败");
        return r.toJsonyMd();
    }

    @RequestMapping(value = "/update/{departName}/{departNo}", method = RequestMethod.POST)
    @ResponseBody
    public String update(@PathVariable("departNo") int departNo, @PathVariable("departName") String departName) {
        R r = new R();
        Dispatch dispatch = new Dispatch(departNo, departName);
        if (dispatchMapper.updateByPrimaryKey(dispatch) > 0) {
            r.setMsg("修改成功");
            r.setCode(3);
        } else
            r.setMsg("修改失败");
        return r.toJsonyMd();
    }

    @RequestMapping(value = "/del/{departNo}", method = RequestMethod.POST)
    @ResponseBody
    public String del(@PathVariable("departNo") int departNo) {
        R r = new R();
        try {
            if (dispatchMapper.deleteByPrimaryKey(departNo) > 0) {
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
}
