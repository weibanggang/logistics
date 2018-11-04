<%--
  Created by IntelliJ IDEA.
  User: 小邦哥
  Date: 2018/10/29
  Time: 11:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        th .layui-table-cell,td {text-align:center;}
        .rigtop { width: 1143px; height: 40px;border: 1px solid #b7d5df;line-height: 40px;margin:auto;margin-top:5px;}
        .layui-btns {width: 100px;height: 32px;line-height: 32px;position:relative;float:right;border-radius: 20px;top:5px}
        .divtable{width:1145px;margin:auto;margin-top:-5px;}
        .input{width:275px;}
    </style>
</head>
<body>
<div class="rigtop">
    <div class="layui-form-item layui-form" >
        <div class="layui-inline" >
            <label class="layui-form-label" style="width: 28px;">班级:</label>
            <div class="layui-input-inline">
                <select name="quiz">
                    <option value="">请选择班级</option>
                    <optgroup label="高一">
                        <option value="你工作的第一个城市">143</option>
                    </optgroup>
                    <optgroup label="高二">
                        <option value="你的工号">144</option>
                        <option value="你最喜欢的老师">134</option>
                    </optgroup>
                </select>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 28px;">类型:</label>
            <div class="layui-input-inline">
                <select name="quiz" id="quiz">
                    <option value="上课">上课</option>
                    <option value="自习">自习</option>
                    <option value="活动">活动</option>
                    <option value="其他">其他</option>
                </select>
            </div>
        </div>
        <button class="layui-btn layui-btn-normal layui-btns" data-type="getCheckData">查询</button>
        <button class="layui-btn layui-btn-normal layui-btns" data-type="getCheckData">导出Excel</button>
    </div>
</div>
</body>
</html>
