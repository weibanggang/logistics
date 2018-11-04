package com.wbg.logistics.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wbg.logistics.dao.PositionsMapper;
import com.wbg.logistics.entity.Positions;
import com.wbg.logistics.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/positions")
public class PositionsController {
    @Autowired
    private PositionsMapper positionsMapper;

    @RequestMapping(value = "/json",method = RequestMethod.GET)
    @ResponseBody
    public String selectAllJson(@RequestParam("page") int page , @RequestParam("limit") int limit){
        PageHelper.startPage(page,limit);
        R r=new R();
        List<Positions> list=positionsMapper.selectAll();
        PageInfo pi = new PageInfo(list);
        r.setData(list);
        r.setCount((int)pi.getTotal());
        return r.toJson();
    }

    @RequestMapping(value = "/selectWaybillNo/{waybillNo}",method = RequestMethod.GET)
    @ResponseBody
    public String selectWaybillNo(@RequestParam("page") int page , @RequestParam("limit") int limit,@PathVariable("waybillNo") String waybillNo){
        PageHelper.startPage(page,limit);
        R r=new R();
        List<Positions> list=positionsMapper.selectBywaybillNo(waybillNo);
        PageInfo pi = new PageInfo(list);
        r.setData(list);
        r.setCount((int)pi.getTotal());
        return r.toJson();
    }

    //添加
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public String add(@RequestBody Positions positions) {
        R r=new R();
        try {
            if (positionsMapper.insert(positions) > 0) {
                r.setMsg( "添加成功");
                r.setCode(3);
            }
            else{
                r.setMsg( "添加失败");
            }
        }catch (Exception e){
            r.setMsg( "添加失败");
            return r.toJson();
        }
        return r.toJson();
    }

    @RequestMapping(method = RequestMethod.GET)
    public String index(){
        return "ssyd";
    }
}
