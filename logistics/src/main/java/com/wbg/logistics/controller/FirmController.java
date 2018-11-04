package com.wbg.logistics.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wbg.logistics.dao.DepartMapper;
import com.wbg.logistics.dao.FirmMapper;
import com.wbg.logistics.entity.Depart;
import com.wbg.logistics.entity.Firm;
import com.wbg.logistics.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/firm")
public class FirmController {
    @Autowired
    private FirmMapper firmMapper;
    @RequestMapping(value = "/json",method = RequestMethod.GET)
    @ResponseBody
    public String selectAllJson(@RequestParam("page") int page , @RequestParam("limit") int limit){
        PageHelper.startPage(page,limit);
        R r=new R();
        List<Firm> list=firmMapper.selectAll();
        PageInfo pi = new PageInfo(list);
        r.setData(list);
        r.setCount((int)pi.getTotal());
        return r.toJsonyMd();
    }
    @RequestMapping(value = "/select",method = RequestMethod.GET)
    @ResponseBody
    public String select(){
        R r=new R();
        List<Firm> list=firmMapper.selectAll();
        r.setData(list);
        return r.toJsonyMd();
    }
    @RequestMapping(value = "/add/{firmName}", method = RequestMethod.POST)
    @ResponseBody
    public String add(@PathVariable("firmName") String firmName) {
        R r = new R();
        Firm firm = new Firm();
        firm.setFirmName(firmName);
        if (firmMapper.insert(firm) > 0) {
            r.setMsg("添加成功");
            r.setCode(3);
        } else
            r.setMsg("添加失败");
        return r.toJsonyMd();
    }

    @RequestMapping(value = "/update/{firmName}/{firmNo}", method = RequestMethod.POST)
    @ResponseBody
    public String update(@PathVariable("firmNo") int firmNo, @PathVariable("firmName") String firmName) {
        R r = new R();
        Firm dispatch = new Firm(firmNo, firmName);
        if (firmMapper.updateByPrimaryKey(dispatch) > 0) {
            r.setMsg("修改成功");
            r.setCode(3);
        } else
            r.setMsg("修改失败");
        return r.toJsonyMd();
    }

    @RequestMapping(value = "/del/{firmNo}", method = RequestMethod.POST)
    @ResponseBody
    public String del(@PathVariable("firmNo") int firmNo) {
        R r = new R();
        try {
            if (firmMapper.deleteByPrimaryKey(firmNo) > 0) {
                r.setMsg("删除成功");
                r.setCode(3);
            } else
                r.setMsg("删除失败");
        }catch (Exception e){
            r.setMsg("删除失败");
            return r.toJsonyMd();
        }
        return r.toJsonyMd();
    }
}
