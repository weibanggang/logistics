package com.wbg.logistics.controller;

import com.wbg.logistics.dao.AdminMapper;
import com.wbg.logistics.entity.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminMapperController {
    @Autowired
    private AdminMapper adminMapper;

    @RequestMapping(method = RequestMethod.GET)
    public String index(@RequestParam(defaultValue = "1") int page, Model model){
        List<Admin> authodList=adminMapper.selectAll();
        model.addAttribute("authod",authodList);
        return "/employee";
    }
}