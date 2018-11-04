package com.wbg.logistics.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wbg.logistics.dao.WaybillMapper;
import com.wbg.logistics.entity.Vehicle;
import com.wbg.logistics.entity.Waybill;
import com.wbg.logistics.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/waybill")
public class WaybillController {

    @Autowired
    private WaybillMapper waybillMapper;

    @RequestMapping(value = "/json",method = RequestMethod.GET)
    @ResponseBody
    public String selectAllJson(@RequestParam("page") int page , @RequestParam("limit") int limit){
        PageHelper.startPage(page,limit);
        R r=new R();
        List<Waybill> list=waybillMapper.selectAll();
        PageInfo pi = new PageInfo(list);
        r.setData(list);
        r.setCount((int)pi.getTotal());
        return r.toJsonyMd();
    }

    //添加
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String add(Waybill waybill, RedirectAttributes redirectAttributes) {
        try {
            if (waybillMapper.insert(waybill) > 0) {
                redirectAttributes.addAttribute("msg", "添加成功");
                redirectAttributes.addAttribute("waybillNo","");
                redirectAttributes.addAttribute("number", "");
                redirectAttributes.addAttribute("unit", "");
                redirectAttributes.addAttribute("sName", "");
                redirectAttributes.addAttribute("rName", "");
                redirectAttributes.addAttribute("sPro","");
                redirectAttributes.addAttribute("sCity", "");
                redirectAttributes.addAttribute("rName", "");
                redirectAttributes.addAttribute("ePro", "");
                redirectAttributes.addAttribute("eCity", "");
                redirectAttributes.addAttribute("sAddress", "");
                redirectAttributes.addAttribute("sPhone", "");
                redirectAttributes.addAttribute("rPhone", "");
                redirectAttributes.addAttribute("rAddress", "");
            }
            else{
                redirectAttributes.addAttribute("msg","添加失败");
                redirectAttributes.addAttribute("waybillNo",waybill.getWaybillNo());
                redirectAttributes.addAttribute("number", waybill.getNumber());
                redirectAttributes.addAttribute("unit", waybill.getUnit());
                redirectAttributes.addAttribute("sName", waybill.getsName());
                redirectAttributes.addAttribute("sPro",waybill.getsPro());
                redirectAttributes.addAttribute("sCity", waybill.getsCity());
                redirectAttributes.addAttribute("rName", waybill.getrName());
                redirectAttributes.addAttribute("ePro", waybill.getePro());
                redirectAttributes.addAttribute("eCity", waybill.geteCity());
                redirectAttributes.addAttribute("sAddress", waybill.getsAddress());
                redirectAttributes.addAttribute("sPhone", waybill.getsPhone());
                redirectAttributes.addAttribute("rPhone", waybill.getrPhone());
                redirectAttributes.addAttribute("rAddress", waybill.getrAddress());
            }
        }catch (Exception e){
            redirectAttributes.addAttribute("msg","添加失败");
            redirectAttributes.addAttribute("waybillNo",waybill.getWaybillNo());
            redirectAttributes.addAttribute("number", waybill.getNumber());
            redirectAttributes.addAttribute("unit", waybill.getUnit());
            redirectAttributes.addAttribute("sName", waybill.getsName());
            redirectAttributes.addAttribute("sPro",waybill.getsPro());
            redirectAttributes.addAttribute("sCity", waybill.getsCity());
            redirectAttributes.addAttribute("rName", waybill.getrName());
            redirectAttributes.addAttribute("ePro", waybill.getePro());
            redirectAttributes.addAttribute("eCity", waybill.geteCity());
            redirectAttributes.addAttribute("sAddress", waybill.getsAddress());
            redirectAttributes.addAttribute("sPhone", waybill.getsPhone());
            redirectAttributes.addAttribute("rPhone", waybill.getrPhone());
            redirectAttributes.addAttribute("rAddress", waybill.getrAddress());
            return "redirect:/waybill";
        }
        return "redirect:/waybill";

    }

    @RequestMapping(method = RequestMethod.GET)
    public String index(){
        return "waybilladd";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public String update(@RequestBody Waybill waybill) {
        R r = new R();
        try {
            if (waybillMapper.updateByPrimaryKey(waybill) > 0) {
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

    @RequestMapping(value = "/waybillNo/{waybillNo}", method = RequestMethod.GET)
    @ResponseBody
    public String seleById(@PathVariable("waybillNo") String waybillNo){
        PageHelper.startPage(1,20);
        R r=new R();
        List<Waybill> list=waybillMapper.selectByPrimaryKey("%"+waybillNo+"%");
        PageInfo pi = new PageInfo(list);
        r.setMsg("ok");
        r.setData(list);
        r.setCount((int)pi.getTotal());
        return r.toJson();
    }
    @RequestMapping(value = "/sPhonesele/{sPhonesele}", method = RequestMethod.GET)
    @ResponseBody
    public String sPhonesele(@PathVariable("sPhonesele") String sPhonesele){
        PageHelper.startPage(1,20);
        R r=new R();
        List<Waybill> list=waybillMapper.selectsPhonesele("%"+sPhonesele+"%");
        PageInfo pi = new PageInfo(list);
        r.setMsg("ok");
        r.setData(list);
        r.setCount((int)pi.getTotal());
        return r.toJson();
    }
    @RequestMapping(value = "/rPhonesele/{rPhonesele}", method = RequestMethod.GET)
    @ResponseBody
    public String rPhonesele(@PathVariable("rPhonesele") String rPhonesele){
        PageHelper.startPage(1,20);
        R r=new R();
        List<Waybill> list=waybillMapper.selectrPhonesele("%"+rPhonesele+"%");
        PageInfo pi = new PageInfo(list);
        r.setMsg("ok");
        r.setData(list);
        r.setCount((int)pi.getTotal());
        return r.toJson();
    }
}
