package com.wbg.logistics.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wbg.logistics.dao.VehicleMapper;
import com.wbg.logistics.entity.Depart;
import com.wbg.logistics.entity.Vehicle;
import com.wbg.logistics.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.jws.WebParam;
import java.util.List;

@Controller
@RequestMapping("/vehicle")
public class VehicleController {
    @Autowired
    VehicleMapper vehicleMapper;
    @RequestMapping(value = "/json",method = RequestMethod.GET)
    @ResponseBody
    public String selectAllJson(@RequestParam("page") int page , @RequestParam("limit") int limit){
        PageHelper.startPage(page,limit);
        R r=new R();
        List<Vehicle> list=vehicleMapper.selectAllJson();
        PageInfo pi = new PageInfo(list);
        r.setMsg("ok");
        r.setData(list);
        r.setCount((int)pi.getTotal());
        return r.toJson();
    }
    //添加
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String add(Vehicle vehicle, RedirectAttributes redirectAttributes) {
        try {
            if (vehicleMapper.insert(vehicle) > 0) {
              redirectAttributes.addAttribute("msg", "添加成功");
                redirectAttributes.addAttribute("license","");
                redirectAttributes.addAttribute("vType", "");
                redirectAttributes.addAttribute("staffNo", "");
                redirectAttributes.addAttribute("vload", "");
            }
            else{
                redirectAttributes.addAttribute("msg","添加失败");
                redirectAttributes.addAttribute("license", vehicle.getLicense());
                redirectAttributes.addAttribute("vType", vehicle.getvType());
                redirectAttributes.addAttribute("staffNo", vehicle.getStaffNo());
                redirectAttributes.addAttribute("vload", vehicle.getVload());
            }
        }catch (Exception e){
            redirectAttributes.addAttribute("msg","添加失败");
            redirectAttributes.addAttribute("license", vehicle.getLicense());
            redirectAttributes.addAttribute("vType", vehicle.getvType());
            redirectAttributes.addAttribute("staffNo", vehicle.getStaffNo());
            redirectAttributes.addAttribute("vload", vehicle.getVload());
            return "redirect:/vehicle";
        }
        return "redirect:/vehicle";

    }

    @RequestMapping(method = RequestMethod.GET)
    public String index(){
        return "vehicleadd";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public String update(@RequestBody Vehicle vehicle) {
        R r = new R();
        try {
            if (vehicleMapper.updateByPrimaryKey(vehicle) > 0) {
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
    @RequestMapping(value = "/del/{license}", method = RequestMethod.POST)
    @ResponseBody
    public String del(@PathVariable("license") String license) {
        R r = new R();
        try {
            if (vehicleMapper.deleteByPrimaryKey(license) > 0) {
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

    @RequestMapping(value = "/ById/{license}", method = RequestMethod.GET)
    @ResponseBody
    public String seleById(@PathVariable("license") String license){
        PageHelper.startPage(1,1000);
        R r=new R();
        List<Vehicle> list=vehicleMapper.selectByPrimaryKey("%"+license+"%");
        PageInfo pi = new PageInfo(list);
        r.setMsg("ok");
        r.setData(list);
        r.setCount((int)pi.getTotal());
        return r.toJson();
    }
    @RequestMapping(value = "/ByName/{vType}", method = RequestMethod.GET)
    @ResponseBody
    public String seleByName(@PathVariable("vType") String vType){
        R r=new R();
        List<Vehicle> list=vehicleMapper.selectByType("%"+vType+"%");
        PageInfo pi = new PageInfo(list);
        r.setMsg("ok");
        r.setData(list);
        r.setCount((int)pi.getTotal());
        return r.toJson();
    }
}
