<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/4
  Time: 6:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="./plugins/layui/css/layui.css" media="all">

    <style>
        .rigtop {
            width: 1140px;
            height: 40px;
            border: 1px solid #b7d5df;
            line-height: 40px;
            margin: auto;
            margin-top: 5px;
            text-align: center;
            color: red;
        }

        .rigbody {
            width: 1140px;
            height: 463px;
            border: 1px solid #b7d5df;
            line-height: 40px;
            margin: auto;
            margin-top: 5px;
        }
    </style>
</head>
<body>

<div class="rigtop" >
    ${param.msg}
</div>
<div class="rigbody" style="margin: auto">
    <form class="layui-form" method="post" action="/waybill/add" >
        <div class="layui-form-item">
            <label class="layui-form-label">运单号</label>
            <div class="layui-input-inline" >
                <input type="text" name="waybillNo" value="${param.waybillNo}" maxlength="11" required lay-verify="required" placeholder="请输入运单号码" autocomplete="off" class="layui-input">
            </div>
            <label class="layui-form-label">数  量</label>
            <div class="layui-input-inline" >
                <input type="number" name="number" value="${param.number}" maxlength="11" required lay-verify="required" placeholder="请输入数量" autocomplete="off" class="layui-input">
            </div>
            <label class="layui-form-label">单  位</label>
            <div class="layui-input-inline" >
                <input type="text" name="unit" value="${param.unit}" maxlength="11" required lay-verify="required" placeholder="请输入单位" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">发件人</label>
            <div class="layui-input-inline" >
                <input type="text" name="sName" value="${param.sName}" maxlength="11" required lay-verify="required" placeholder="请输入发件人姓名" autocomplete="off" class="layui-input">
            </div>
            <label class="layui-form-label">起始省份</label>
            <div class="layui-input-inline" >
                <input type="text" name="sPro" value="${param.sPro}" maxlength="11" required lay-verify="required" placeholder="请输入起始省份" autocomplete="off" class="layui-input">
            </div>
            <label class="layui-form-label">起始城市</label>
            <div class="layui-input-inline" >
                <input type="text" name="sCity" value="${param.sCity}" maxlength="11" required lay-verify="required" placeholder="请输入起始城市" autocomplete="off" class="layui-input">
            </div>

        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">收件人</label>
            <div class="layui-input-inline" >
                <input type="text" name="rName" value="${param.rName}" maxlength="11" required lay-verify="required" placeholder="请输入收件人姓名" autocomplete="off" class="layui-input">
            </div>
            <label class="layui-form-label">目的省份</label>
            <div class="layui-input-inline" >
                <input type="text" name="ePro" value="${param.ePro}" maxlength="11" required lay-verify="required" placeholder="请输入目的省份" autocomplete="off" class="layui-input">
            </div>
            <label class="layui-form-label">目的城市</label>
            <div class="layui-input-inline" >
                <input type="text" name="eCity" value="${param.eCity}" maxlength="11" required lay-verify="required" placeholder="请输入目的城市" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">发件地址</label>
            <div class="layui-input-inline" >
                <input type="text" name="sAddress" value="${param.sAddress}" maxlength="11" required lay-verify="required" placeholder="请输入发件地址" autocomplete="off" class="layui-input">
            </div>


            <label class="layui-form-label">发件手机</label>
            <div class="layui-input-inline" >
                <input type="text" name="sPhone" value="${param.sPhone}" maxlength="11" required lay-verify="required" placeholder="请输入发件人手机" autocomplete="off" class="layui-input">
            </div>
            <label class="layui-form-label">收件手机</label>
            <div class="layui-input-inline" >
                <input type="text" name="rPhone" value="${param.rPhone}" maxlength="11" required lay-verify="required" placeholder="请输入收件人手机" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">收件地址</label>
            <div class="layui-input-block" >
                <input type="text" name="rAddress" value="${param.rAddress}" maxlength="11" required lay-verify="required" placeholder="请输入收件地址" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <input   class="layui-btn layui-btn-normal" type="submit"/>
            <input   class="layui-btn layui-btn-normal"  type="reset" value="重置"/>
        </div>

    </form>
</div>

</body>
</html>
