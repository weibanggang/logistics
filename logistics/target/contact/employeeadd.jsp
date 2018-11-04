<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/3
  Time: 22:03
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
    <form class="layui-form" method="get" action="/depart/add" >
        <div class="layui-form-item">
            <label class="layui-form-label">员工姓名：</label>
            <div class="layui-input-inline" >
                <input type="text" name="staffName" value="${param.staffName}" maxlength="5" required lay-verify="required" placeholder="请输入员工姓名" autocomplete="off" class="layui-input">
            </div>
            <label class="layui-form-label">性   别：</label>
            <div class="layui-input-inline" >
                <input type="radio" name="gender" value="男" title="男" checked="">
                <input type="radio" name="gender" value="女" title="女">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">出生日期：</label>
            <div class="layui-input-inline">
                <input type="text" name="birthhday" placeholder="yyyy-MM-dd" id="date" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
            </div>
            <label class="layui-form-label">手机号码：</label>
            <div class="layui-input-inline">
                <input type="text" name="phone" value="${param.phone}" maxlength="11" required lay-verify="required" placeholder="请输入手机号码" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">部  门：</label>
            <div class="layui-input-inline">
                <select id="departs" name="dedpartNo">
                </select>
            </div>
            <label class="layui-form-label">公  司：</label>
            <div class="layui-input-inline">
                <select id="firms" name="firmNo">

                </select>

            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密  码：</label>
            <div class="layui-input-inline">
                <input type="password" name="password" lay-verify="pass" placeholder="请输入密码" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">请填写6到12位密码</div>
        </div>

        <div class="layui-form-item">
            <input   class="layui-btn layui-btn-normal" type="submit"/>
            <input   class="layui-btn layui-btn-normal"  type="reset" value="重置"/>
        </div>
    </form>
</div>
<script src="js/jquery.js"></script>
<script src="./plugins/layui/layui.js"></script>
<script>
    $(function () {
        layui.use(['form', 'layedit', 'laydate'], function(){
            var form = layui.form
                ,layer = layui.layer
                ,layedit = layui.layedit
                ,laydate = layui.laydate;

            //日期
            laydate.render({
                elem: '#date'
            });
            $.ajax({
                type:"get",
                url:"/dispatch/select",//请求路径
                dataType: 'json'
                ,success:function(data){//请求成功后的事件
                    $.each(data.data,function(index,obj){
                        var option=$("<option value='"+obj.departNo+"'>"+obj.departName+"</option>");
                        $("#departs").append(option);
                        form.render();
                    })
                }
            })
            $.ajax({
                type:"get",
                url:"/firm/select",//请求路径
                dataType: 'json',
                success:function(data){//请求成功后的事件
                    $.each(data.data,function(index,obj){
                        var option=$("<option value='"+obj.firmNo+"'>"+obj.firmName+"</option>");
                        $("#firms").append(option);
                        form.render();
                    })
                }
            })
        });
    })
</script>
</body>
</html>
